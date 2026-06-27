import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';
import 'package:mobile_flutter/features/attendance/data/database/attendance_database.dart';
import 'package:mobile_flutter/features/attendance/data/datasources/attendance_local_datasource.dart';
import 'package:mobile_flutter/features/attendance/data/datasources/attendance_remote_datasource.dart';
import 'package:mobile_flutter/features/attendance/data/repositories/connectivity_repository.dart';
import 'package:mobile_flutter/features/attendance/data/repositories/sync_repository.dart';
import 'package:mobile_flutter/features/attendance/services/retry_service.dart';

/// Background Sync Engine - Single Source of Truth Synchronization
///
/// DESIGN PHILOSOPHY:
/// 1. Decoupled: Lives outside UI navigation stack
/// 2. Resilient: Survives app restarts, network flaps
/// 3. Bidirectional: Push (local→server) + Pull (server→local)
/// 4. Optimistic: UI never blocks on sync operations
/// 5. Consistent: Delta timestamps minimize bandwidth
class SyncEngine {
  final SyncRepository syncRepository;
  final ConnectivityRepository connectivityRepository;
  final AttendanceRemoteDataSource remoteDataSource;
  final AttendanceLocalDataSource localDataSource;
  final AttendanceDatabase database;
  final RetryService retryService;

  StreamSubscription? _connectivitySubscription;
  Timer? _periodicSyncTimer;
  bool _isSyncing = false;
  bool _isInitialized = false;
  Future<void> Function()? onRefreshStudentStatus;

  final StreamController<SyncState> _syncStateController =
      StreamController<SyncState>.broadcast();
  Stream<SyncState> get syncStateStream => _syncStateController.stream;

  SyncEngine({
    required this.syncRepository,
    required this.connectivityRepository,
    required this.remoteDataSource,
    required this.localDataSource,
    RetryService? retryService,
  }) : database = syncRepository.database,
       retryService = retryService ?? RetryService();

  /// Initialize sync engine - call once at app startup
  void initialize({bool enablePeriodicSync = true}) {
    if (_isInitialized) {
      debugPrint('[SyncEngine] Already initialized');
      return;
    }

    debugPrint('[SyncEngine] Initializing...');

    // Listen to connectivity changes
    _connectivitySubscription = connectivityRepository.onConnectivityChanged
        .listen((isConnected) {
          debugPrint('[SyncEngine] Connectivity changed: $isConnected');
          if (!isConnected) {
            _syncStateController.add(SyncStatus.offline);
            return;
          }
          if (isConnected && !_isSyncing) {
            // Immediate sync when connection restored
            syncNow();
          }
        });

    // Periodic sync every 5 minutes when online (optional)
    if (enablePeriodicSync) {
      _periodicSyncTimer = Timer.periodic(const Duration(minutes: 5), (
        _,
      ) async {
        if (await connectivityRepository.isConnected() && !_isSyncing) {
          await syncNow();
        }
      });
    }

    _isInitialized = true;
  }

  /// Trigger manual sync (pull + push)
  Future<void> syncNow({bool forcePull = false}) async {
    debugPrint('[SyncEngine] Manual sync triggered (pull+push)');
    await _fullSyncCycle(forcePull: forcePull);
  }

  /// Core sync algorithm: Pull → Push → Cleanup
  ///
  /// Phase 1: DELTA PULL
  ///   For each entity type (students, attendance, sessions):
  ///   - GET /sync?since=last_timestamp
  ///   - Upsert into local DB
  ///   - Update last_sync_at
  ///   - Handle conflicts (serverWins/lastWriteWins)
  ///
  /// Phase 2: QUEUE PUSH
  ///   - Process pending_sync_queue sequentially
  ///   - Retry failed items with exponential backoff
  ///   - Mark as synced on success
  ///
  /// Phase 3: CLEANUP
  ///   - Remove old success records from queue (keep last 30 days)
  ///   - Vacuum database if needed
  Future<void> _fullSyncCycle({bool forcePull = false}) async {
    if (_isSyncing) {
      debugPrint('[SyncEngine] Already syncing, skipping...');
      return;
    }

    if (!await connectivityRepository.isConnected()) {
      _syncStateController.add(SyncStatus.offline);
      return;
    }

    _isSyncing = true;
    _syncStateController.add(SyncStatus.syncing);

    try {
      // ───────────────────────────────────────────
      // PHASE 1: DELTA PULL (Server → Local)
      // ───────────────────────────────────────────
      if (await connectivityRepository.isConnected()) {
        final pullSuccess = await _performDeltaPull();
        if (!pullSuccess) {
          debugPrint('[SyncEngine] Delta pull failed, continuing with push...');
        }
      }

      // ───────────────────────────────────────────
      // PHASE 2: QUEUE PUSH (Local → Server)
      // ───────────────────────────────────────────
      await _processQueue();

      if (onRefreshStudentStatus != null) {
        try {
          await onRefreshStudentStatus!();
        } catch (_) {}
      }

      // ───────────────────────────────────────────
      // PHASE 3: CLEANUP
      // ───────────────────────────────────────────
      await _cleanupOldQueueItems();

      _syncStateController.add(SyncStatus.synced);
      debugPrint('[SyncEngine] Full sync cycle complete');
    } catch (e) {
      debugPrint('[SyncEngine] Sync error: $e');
      _syncStateController.add(SyncStatus.failed);
    } finally {
      _isSyncing = false;
    }
  }

  /// Delta Pull: Fetch only modified rows from server since last sync
  Future<bool> _performDeltaPull() async {
    final entityTypes = [
      'students',
      'courses',
      'attendance_sessions',
      'schedules',
      'attendance',
    ];
    int updatedCount = 0;

    for (final entityType in entityTypes) {
      try {
        final lastSync = await syncRepository.getLastSyncTimestamp(entityType);
        debugPrint('[SyncEngine] Pulling $entityType changes since $lastSync');

        final deltaPayload = await remoteDataSource.fetchDeltaChanges(
          entityType: entityType,
          since: lastSync,
        );
        final serverChanges =
            deltaPayload[entityType] ?? const <Map<String, dynamic>>[];

        if (serverChanges.isNotEmpty) {
          await _applyServerChanges(entityType, serverChanges);
          final latestTimestamp = _extractLatestTimestamp(serverChanges);
          if (latestTimestamp != null) {
            await syncRepository.setLastSyncTimestamp(
              entityType: entityType,
              timestamp: latestTimestamp,
            );
          }
          updatedCount += serverChanges.length;
        }
      } on AppException catch (e) {
        if (e.message.contains('Not Found')) {
          debugPrint(
            '[SyncEngine] Delta pull endpoint not available for $entityType, skipping',
          );
          continue;
        }
        if (e.isNetworkError) {
          debugPrint(
            '[SyncEngine] Network error pulling $entityType: ${e.message}',
          );
          continue; // Non-fatal: continue with other entities
        }
        rethrow;
      } catch (e) {
        debugPrint('[SyncEngine] Error pulling $entityType: $e');
      }
    }

    debugPrint(
      '[SyncEngine] Delta pull complete: $updatedCount records updated',
    );
    return true;
  }

  /// Apply server changes to local database with conflict resolution
  Future<void> _applyServerChanges(
    String entityType,
    List<Map<String, dynamic>> changes,
  ) async {
    await database.transaction(() async {
      for (final change in changes) {
        final action = change['_operation'] as String? ?? 'upsert';
        final data = Map<String, dynamic>.from(change);
        data.remove('_operation');

        switch (entityType) {
          case 'students':
            if (action == 'delete' ||
                data['deletedAt'] != null ||
                data['isDeleted'] == true) {
              await _softDeleteStudent(data);
            } else {
              await _upsertStudent(data);
            }
            break;
          case 'courses':
            if (action == 'delete' ||
                data['deletedAt'] != null ||
                data['isDeleted'] == true) {
              await _softDeleteCourse(data);
            } else {
              await _upsertCourse(data);
            }
            break;
          case 'schedules':
            if (action == 'delete' ||
                data['deletedAt'] != null ||
                data['isDeleted'] == true) {
              await _softDeleteSchedule(data);
            } else {
              await _upsertSchedule(data);
            }
            break;
          case 'attendance_sessions':
            if (action == 'delete' ||
                data['deletedAt'] != null ||
                data['isDeleted'] == true) {
              await _softDeleteAttendanceSession(data);
            } else {
              await _upsertAttendanceSession(data);
            }
            break;
          case 'attendance':
            if (action == 'delete' ||
                data['deletedAt'] != null ||
                data['isDeleted'] == true) {
              await _softDeleteAttendance(data);
            } else {
              await _upsertAttendance(data);
            }
            break;
        }
      }
    });
  }

  Future<void> _softDeleteStudent(Map<String, dynamic> data) async {
    await database
        .into(database.students)
        .insertOnConflictUpdate(
          StudentsCompanion(
            id: Value(data['id'] as int? ?? 0),
            universityStudentId: Value(
              data['universityStudentId'] as String? ?? '',
            ),
            qrCode: Value(data['qrCode'] as String? ?? ''),
            fullName: Value(data['fullName'] as String? ?? ''),
            email: Value(data['email'] as String?),
            universityId: Value(data['universityId'] as int? ?? 0),
            programId: Value(data['programId'] as int? ?? 0),
            offlineUuid: Value(data['offlineUuid'] as String? ?? ''),
            isActive: const Value(false),
            isDeleted: const Value(true),
            deletedAt: Value(
              _parseTimestamp(data['deletedAt'] ?? data['updatedAt']),
            ),
            updatedAt: Value(_parseTimestamp(data['updatedAt'])),
          ),
        );
  }

  Future<void> _softDeleteCourse(Map<String, dynamic> data) async {
    await database
        .into(database.courses)
        .insertOnConflictUpdate(
          CoursesCompanion(
            id: Value(data['id'] as int? ?? 0),
            universityCourseId: Value(
              data['universityCourseId'] as String? ?? '',
            ),
            courseCode: Value(data['courseCode'] as String? ?? ''),
            courseName: Value(data['courseName'] as String? ?? ''),
            universityId: Value(data['universityId'] as int? ?? 0),
            programId: Value(data['programId'] as int? ?? 0),
            semesterId: Value(data['semesterId'] as int? ?? 0),
            isActive: const Value(false),
            isDeleted: const Value(true),
            deletedAt: Value(
              _parseTimestamp(data['deletedAt'] ?? data['updatedAt']),
            ),
            updatedAt: Value(_parseTimestamp(data['updatedAt'])),
          ),
        );
  }

  Future<void> _softDeleteSchedule(Map<String, dynamic> data) async {
    await database
        .into(database.schedules)
        .insertOnConflictUpdate(
          SchedulesCompanion(
            id: Value(data['id'] as int? ?? 0),
            universitySlotId: Value(data['universitySlotId'] as String? ?? ''),
            courseId: Value(data['courseId'] as int? ?? 0),
            facultyMemberId: Value(data['facultyMemberId'] as int? ?? 0),
            semesterId: Value(data['semesterId'] as int? ?? 0),
            dayOfWeek: Value(data['dayOfWeek'] as int? ?? 0),
            startTime: Value(data['startTime'] as String? ?? ''),
            endTime: Value(data['endTime'] as String? ?? ''),
            isActive: const Value(false),
            isDeleted: const Value(true),
            deletedAt: Value(
              _parseTimestamp(data['deletedAt'] ?? data['updatedAt']),
            ),
            updatedAt: Value(_parseTimestamp(data['updatedAt'])),
          ),
        );
  }

  Future<void> _softDeleteAttendanceSession(Map<String, dynamic> data) async {
    await database
        .into(database.attendanceSessions)
        .insertOnConflictUpdate(
          AttendanceSessionsCompanion(
            id: Value(data['id'] as int? ?? 0),
            scheduleSlotId: Value(data['scheduleSlotId'] as int? ?? 0),
            facultyMemberId: Value(data['facultyMemberId'] as int? ?? 0),
            sessionDate: Value(_parseDate(data['sessionDate'])),
            startTime: Value(data['startTime'] as String? ?? ''),
            endTime: Value(data['endTime'] as String? ?? ''),
            attendanceMode: Value(
              data['attendanceMode'] as String? ?? 'QRCode',
            ),
            offlineUuid: Value(data['offlineUuid'] as String? ?? ''),
            isSynced: const Value(true),
            isDeleted: const Value(true),
            deletedAt: Value(
              _parseTimestamp(data['deletedAt'] ?? data['updatedAt']),
            ),
            updatedAt: Value(_parseTimestamp(data['updatedAt'])),
          ),
        );
  }

  Future<void> _softDeleteAttendance(Map<String, dynamic> data) async {
    await database
        .into(database.attendances)
        .insertOnConflictUpdate(
          AttendancesCompanion(
            id: Value(data['id'] as int? ?? 0),
            studentId: Value(data['studentId'] as int? ?? 0),
            courseId: Value(data['courseId'] as int? ?? 0),
            sessionId: Value(data['sessionId'] as int? ?? 0),
            attendanceDate: Value(_parseDate(data['attendanceDate'])),
            status: Value(data['status'] as String? ?? 'absent'),
            offlineUuid: Value(data['offlineUuid'] as String? ?? ''),
            deviceId: Value(data['deviceId'] as String? ?? ''),
            isSynced: const Value(true),
            pendingSync: const Value(false),
            isDeleted: const Value(true),
            deletedAt: Value(
              _parseTimestamp(data['deletedAt'] ?? data['updatedAt']),
            ),
            updatedAt: Value(_parseTimestamp(data['updatedAt'])),
          ),
        );
  }

  Future<void> _upsertStudent(Map<String, dynamic> data) async {
    await database
        .into(database.students)
        .insertOnConflictUpdate(
          StudentsCompanion(
            id: Value(data['id'] as int? ?? 0),
            universityStudentId: Value(data['universityStudentId'] as String),
            qrCode: Value(data['qrCode'] as String),
            fullName: Value(data['fullName'] as String),
            email: Value(data['email'] as String?),
            universityId: Value(data['universityId'] as int),
            programId: Value(data['programId'] as int),
            offlineUuid: Value(data['offlineUuid'] as String? ?? ''),
            isActive: Value(data['isActive'] as bool? ?? true),
            isDeleted: Value(data['isDeleted'] as bool? ?? false),
            updatedAt: Value(_parseTimestamp(data['updatedAt'])),
          ),
        );
  }

  Future<void> _upsertCourse(Map<String, dynamic> data) async {
    await database
        .into(database.courses)
        .insertOnConflictUpdate(
          CoursesCompanion(
            id: Value(data['id'] as int? ?? 0),
            universityCourseId: Value(data['universityCourseId'] as String),
            courseCode: Value(data['courseCode'] as String),
            courseName: Value(data['courseName'] as String),
            universityId: Value(data['universityId'] as int),
            programId: Value(data['programId'] as int),
            semesterId: Value(data['semesterId'] as int),
            isActive: Value(data['isActive'] as bool? ?? true),
            isDeleted: Value(data['isDeleted'] as bool? ?? false),
            updatedAt: Value(_parseTimestamp(data['updatedAt'])),
          ),
        );
  }

  Future<void> _upsertSchedule(Map<String, dynamic> data) async {
    await database
        .into(database.schedules)
        .insertOnConflictUpdate(
          SchedulesCompanion(
            id: Value(data['id'] as int? ?? 0),
            universitySlotId: Value(data['universitySlotId'] as String),
            courseId: Value(data['courseId'] as int),
            facultyMemberId: Value(data['facultyMemberId'] as int),
            semesterId: Value(data['semesterId'] as int),
            dayOfWeek: Value(data['dayOfWeek'] as int),
            startTime: Value(data['startTime'] as String),
            endTime: Value(data['endTime'] as String),
            isActive: Value(data['isActive'] as bool? ?? true),
            isDeleted: Value(data['isDeleted'] as bool? ?? false),
            updatedAt: Value(_parseTimestamp(data['updatedAt'])),
          ),
        );
  }

  Future<void> _upsertAttendanceSession(Map<String, dynamic> data) async {
    await database
        .into(database.attendanceSessions)
        .insertOnConflictUpdate(
          AttendanceSessionsCompanion(
            id: Value(data['id'] as int? ?? 0),
            scheduleSlotId: Value(data['scheduleSlotId'] as int),
            facultyMemberId: Value(data['facultyMemberId'] as int),
            sessionDate: Value(_parseDate(data['sessionDate'])),
            startTime: Value(data['startTime'] as String),
            endTime: Value(data['endTime'] as String),
            attendanceMode: Value(data['attendanceMode'] as String),
            offlineUuid: Value(data['offlineUuid'] as String? ?? ''),
            isSynced: Value(data['isSynced'] as bool? ?? true),
            isDeleted: Value(data['isDeleted'] as bool? ?? false),
            syncedAt: Value(_parseTimestamp(data['syncedAt'])),
            updatedAt: Value(_parseTimestamp(data['updatedAt'])),
          ),
        );
  }

  Future<void> _upsertAttendance(Map<String, dynamic> data) async {
    await database
        .into(database.attendances)
        .insertOnConflictUpdate(
          AttendancesCompanion(
            id: Value(data['id'] as int? ?? 0),
            studentId: Value(data['studentId'] as int),
            courseId: Value(data['courseId'] as int),
            sessionId: Value(data['sessionId'] as int),
            attendanceDate: Value(_parseDate(data['attendanceDate'])),
            status: Value(data['status'] as String),
            offlineUuid: Value(data['offlineUuid'] as String? ?? ''),
            deviceId: Value(data['deviceId'] as String? ?? ''),
            isSynced: Value(data['isSynced'] as bool? ?? true),
            pendingSync: Value(data['pendingSync'] as bool? ?? false),
            isDeleted: Value(data['isDeleted'] as bool? ?? false),
            verifiedBy: Value(data['verifiedBy'] as String?),
            verificationMethod: Value(data['verificationMethod'] as String?),
            syncedAt: Value(_parseTimestamp(data['syncedAt'])),
            updatedAt: Value(_parseTimestamp(data['updatedAt'])),
          ),
        );
  }

  DateTime _parseTimestamp(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString()) ?? DateTime.now();
  }

  DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    final parsed = DateTime.tryParse(value.toString());
    if (parsed != null) return parsed;
    return DateTime.now();
  }

  DateTime? _extractLatestTimestamp(List<Map<String, dynamic>> changes) {
    DateTime? latest;
    for (final change in changes) {
      final updatedStr = change['updatedAt'] as String?;
      if (updatedStr != null) {
        final updated = DateTime.tryParse(updatedStr);
        if (updated != null && (latest == null || updated.isAfter(latest))) {
          latest = updated;
        }
      }
    }
    return latest;
  }

  /// Process pending sync queue (Local → Server)
  Future<void> _processQueue() async {
    final pendingItems = await syncRepository.getPendingItems();
    final failedItems = await syncRepository.getFailedItems(maxRetries: 3);
    final now = DateTime.now();
    final dueForRetry = failedItems
        .where(
          (item) => item.nextRetryAt == null || item.nextRetryAt!.isBefore(now),
        )
        .toList();
    final allItems = [...pendingItems, ...dueForRetry];

    if (allItems.isEmpty) {
      debugPrint('[SyncEngine] No pending items to push');
      return;
    }

    debugPrint(
      '[SyncEngine] Processing ${allItems.length} items '
      '(${pendingItems.length} pending, ${dueForRetry.length} retry)',
    );

    int syncedCount = 0;
    int failedCount = 0;

    for (final item in allItems) {
      if (item.retryCount >= 3) {
        debugPrint('[SyncEngine] Item ${item.id} exceeded max retries');
        await syncRepository.markAsFailed(item.id, 'Retry limit reached.');
        failedCount++;
        continue;
      }

      try {
        await syncRepository.markAsSyncing(item.id);
        debugPrint('[SyncEngine] Pushing item ${item.id} (${item.actionType})');

        final startTime = DateTime.now();
        final syncResult = await remoteDataSource.executeSyncItem(item);
        final duration = DateTime.now().difference(startTime).inMilliseconds;

        if (syncResult != null && syncResult.scheduleSlotId > 0) {
          final records = syncResult.serverRecords.isNotEmpty
              ? syncResult.serverRecords
              : syncResult.records;
          await localDataSource.reconcileSyncedAttendance(
            scheduleSlotId: syncResult.scheduleSlotId,
            sessionId: syncResult.sessionId,
            attendanceDate: syncResult.sessionDate,
            records: records,
          );
        }

        await syncRepository.markAsSuccess(item.id);
        debugPrint('[SyncEngine] Item ${item.id} synced in ${duration}ms');
        syncedCount++;
      } on AppException catch (e) {
        await syncRepository.markAsFailed(item.id, e.message);
        failedCount++;

        if (retryService.shouldRetry(item.retryCount) && item.retryCount < 3) {
          final delay = retryService.getNextRetryDelay(item.retryCount);
          debugPrint(
            '[SyncEngine] Item ${item.id} will retry in ${delay.inSeconds}s',
          );
          _scheduleRetry(delay);
        }
      } catch (e) {
        await syncRepository.markAsFailed(item.id, e.toString());
        failedCount++;
      }
    }

    debugPrint(
      '[SyncEngine] Push complete: $syncedCount synced, $failedCount failed',
    );
  }

  /// Periodic cleanup of old sync queue entries
  Future<void> _cleanupOldQueueItems() async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

    await database.batch((batch) {
      batch.deleteWhere(
        database.syncQueues,
        (tbl) =>
            (tbl.syncStatus.equals('success') |
                tbl.syncStatus.equals('synced')) &
            tbl.actionType.isNotIn(['_sync_meta', 'delta_sync']) &
            tbl.createdAt.isSmallerThanValue(thirtyDaysAgo),
      );
      batch.deleteWhere(
        database.syncQueues,
        (tbl) =>
            tbl.actionType.isIn(['_sync_meta', 'delta_sync']) &
            tbl.createdAt.isSmallerThanValue(sevenDaysAgo),
      );
    });
  }

  /// Schedule retry with exponential backoff
  void _scheduleRetry(Duration delay) {
    Future.delayed(delay, () {
      if (!_isSyncing) {
        syncNow();
      }
    });
  }

  /// Dispose resources
  void dispose() {
    debugPrint('[SyncEngine] Disposing');
    _connectivitySubscription?.cancel();
    _periodicSyncTimer?.cancel();
    _syncStateController.close();
    _isInitialized = false;
  }
}

// ─────────────────────────────────────────────
// SYNC STATE (UI consumption)
// ─────────────────────────────────────────────

enum SyncStatus { idle, offline, syncing, synced, failed }

typedef SyncState = SyncStatus;

extension SyncStatusExtension on SyncStatus {
  String get label {
    switch (this) {
      case SyncStatus.idle:
        return 'Idle';
      case SyncStatus.offline:
        return 'Saved offline';
      case SyncStatus.syncing:
        return 'Syncing...';
      case SyncStatus.synced:
        return 'Synced';
      case SyncStatus.failed:
        return 'Sync Error';
    }
  }
}
