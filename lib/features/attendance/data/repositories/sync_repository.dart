import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:mobile_flutter/features/attendance/data/datasources/attendance_local_datasource.dart';
import 'package:mobile_flutter/features/attendance/data/models/sync_queue_model.dart';
import 'package:mobile_flutter/features/attendance/data/database/attendance_database.dart';

/// Central repository for all synchronization operations
///
/// Responsibilities:
/// 1. Manage push queue (outgoing changes)
/// 2. Manage pull delta sync (incoming changes)
/// 3. Track sync state and timestamps (last_sync_at per entity type)
/// 4. Conflict detection and resolution
class SyncRepository {
  final AttendanceLocalDataSource localDataSource;
  final AttendanceDatabase database;

  SyncRepository({required this.localDataSource})
    : database = localDataSource.database;

  // ─────────────────────────────────────────────
  // PUSH QUEUE (Local → Server)
  // ─────────────────────────────────────────────

  Future<List<SyncQueueModel>> getPendingItems({int limit = 50}) async {
    return await localDataSource.getPendingSyncItems();
  }

  Future<int> getPendingCount() async {
    try {
      return await localDataSource.getPendingSyncCount();
    } catch (_) {
      return 0;
    }
  }

  Stream<int> watchPendingCount() {
    return localDataSource.watchPendingSyncCount();
  }

  Future<void> markAsSyncing(int queueId) async {
    try {
      await localDataSource.markSyncItemAsSyncing(queueId);
    } catch (_) {}
  }

  Future<void> markAsSuccess(int queueId) async {
    try {
      await localDataSource.markSyncItemAsSuccess(queueId);
    } catch (_) {}
  }

  Future<void> markAsFailed(int queueId, String error) async {
    try {
      await localDataSource.markSyncItemAsFailed(queueId, error);
    } catch (_) {}
  }

  Future<void> clearSyncedItems() async {
    try {
      await localDataSource.clearSyncedItems();
    } catch (_) {}
  }

  // ─────────────────────────────────────────────
  // PULL DELTA SYNC (Server → Local)
  // ─────────────────────────────────────────────

  /// Record the last successful sync timestamp for an entity type
  Future<void> setLastSyncTimestamp({
    required String entityType,
    required DateTime timestamp,
  }) async {
    await database
        .into(database.syncQueues)
        .insertOnConflictUpdate(
          SyncQueuesCompanion(
            actionType: const Value('_sync_meta'),
            entityType: Value(entityType),
            entityId: const Value(0),
            payloadJson: Value(
              '{"last_sync_at": "${timestamp.toIso8601String()}"}',
            ),
            syncStatus: const Value('success'),
            retryCount: const Value(0),
            createdAt: Value(timestamp),
            updatedAt: Value(timestamp),
          ),
        );
  }

  /// Get the last sync timestamp for an entity type
  Future<DateTime?> getLastSyncTimestamp(String entityType) async {
    final record =
        await (database.select(database.syncQueues)
              ..where(
                (tbl) =>
                    tbl.entityType.equals(entityType) &
                    tbl.actionType.equals('_sync_meta'),
              )
              ..orderBy([
                (tbl) => OrderingTerm(
                  expression: tbl.createdAt,
                  mode: OrderingMode.desc,
                ),
              ])
              ..limit(1))
            .getSingleOrNull();

    if (record == null) return null;
    try {
      final payload = jsonDecode(record.payloadJson) as Map<String, dynamic>;
      final lastSync = payload['last_sync_at'] as String?;
      return lastSync != null ? DateTime.parse(lastSync) : null;
    } catch (_) {
      return null;
    }
  }

  /// Enqueue a delta sync request for specific entity type
  /// This is called when connectivity is restored to fetch server changes
  Future<void> enqueueDeltaSync({
    required String entityType,
    required Map<String, dynamic> params,
  }) async {
    final now = DateTime.now();
    await database
        .into(database.syncQueues)
        .insert(
          SyncQueuesCompanion(
            actionType: const Value('delta_sync'),
            entityType: Value(entityType),
            entityId: const Value(0),
            payloadJson: Value(jsonEncode(params)),
            syncStatus: const Value('pending'),
            priority: const Value(1), // High priority
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
  }

  /// Mark entire sync session as complete (used for batch operations)
  Future<void> markBatchComplete(List<int> queueIds) async {
    await database.batch((batch) {
      for (final id in queueIds) {
        batch.update(
          database.syncQueues,
          const SyncQueuesCompanion(syncStatus: Value('success')),
          where: (tbl) => tbl.id.equals(id),
        );
      }
    });
  }

  /// Get failed items for retry with backoff
  Future<List<SyncQueueModel>> getFailedItems({int maxRetries = 5}) async {
    final records =
        await (database.select(database.syncQueues)
              ..where(
                (tbl) =>
                    tbl.syncStatus.equals('failed') &
                    tbl.retryCount.isSmallerThanValue(maxRetries) &
                    tbl.actionType.isNotIn(['_sync_meta', 'delta_sync']),
              )
              ..orderBy([
                (tbl) => OrderingTerm(
                  expression: tbl.nextRetryAt,
                  mode: OrderingMode.asc,
                ),
                (tbl) => OrderingTerm(
                  expression: tbl.createdAt,
                  mode: OrderingMode.asc,
                ),
              ]))
            .get();

    return records.map(_toSyncQueueModel).toList();
  }

  /// Reset sync state (used on conflict resolution or manual reset)
  Future<void> resetSyncStateForEntity(String entityType) async {
    await (database.update(database.syncQueues)
          ..where((tbl) => tbl.entityType.equals(entityType)))
        .write(const SyncQueuesCompanion(syncStatus: Value('pending')));
  }

  // ─────────────────────────────────────────────
  // CONFLICT RESOLUTION
  // ─────────────────────────────────────────────

  /// Check for conflicting pending items for the same entity
  Future<List<SyncQueueModel>> getConflictsForEntity({
    required String entityType,
    required int entityId,
  }) async {
    final records =
        await (database.select(database.syncQueues)
              ..where(
                (tbl) =>
                    tbl.entityType.equals(entityType) &
                    tbl.entityId.equals(entityId) &
                    (tbl.syncStatus.equals('pending') |
                        tbl.syncStatus.equals('syncing')),
              )
              ..orderBy([
                (tbl) => OrderingTerm(
                  expression: tbl.createdAt,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();

    return records.map(_toSyncQueueModel).toList();
  }

  SyncQueueModel _toSyncQueueModel(SyncQueue record) {
    return SyncQueueModel(
      id: record.id,
      actionType: record.actionType,
      entityType: record.entityType,
      entityId: record.entityId,
      payloadJson: record.payloadJson,
      createdAt: record.createdAt,
      syncStatus: record.syncStatus,
      retryCount: record.retryCount,
      lastError: record.lastError,
      lastRetryAt: record.lastRetryAt,
      nextRetryAt: record.nextRetryAt,
    );
  }

  /// Resolve conflict by preferring server version (if newer) or client version (if offline)
  /// Returns true if resolution applied
  Future<bool> resolveConflict({
    required String entityType,
    required int entityId,
    required ConflictResolution strategy,
  }) async {
    final conflicts = await getConflictsForEntity(
      entityType: entityType,
      entityId: entityId,
    );

    if (conflicts.isEmpty) return false;

    switch (strategy) {
      case ConflictResolution.clientWins:
        // Delete all pending conflicts except latest
        for (final conflict in conflicts.skip(1)) {
          await localDataSource.deleteSyncQueueItem(conflict.id);
        }
        return true;

      case ConflictResolution.serverWins:
        // Mark all pending items as cancelled; force re-fetch
        for (final conflict in conflicts) {
          await (database.update(database.syncQueues)
                ..where((tbl) => tbl.id.equals(conflict.id)))
              .write(const SyncQueuesCompanion(syncStatus: Value('cancelled')));
        }
        return true;

      case ConflictResolution.merge:
        // Not implemented: would require schema-merge logic
        return false;
    }
  }
}

enum ConflictResolution {
  clientWins, // Local changes prevail
  serverWins, // Server state prevails (overwrite local)
  merge, // Merge both (document-level merge)
}
