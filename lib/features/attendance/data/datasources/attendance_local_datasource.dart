import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import 'package:mobile_flutter/features/attendance/data/database/attendance_database.dart';
import 'package:mobile_flutter/features/attendance/data/models/attendance_model.dart';
import 'package:mobile_flutter/features/attendance/data/models/sync_queue_model.dart';

class AttendanceLocalDataSource {
  AttendanceLocalDataSource({required this.database});

  final AttendanceDatabase database;
  static const List<String> _internalSyncActionTypes = [
    '_sync_meta',
    'delta_sync',
  ];

  // ─────────────────────────────────────────────
  // STUDENT LOOKUP (QR VALIDATION)
  // ─────────────────────────────────────────────

  /// Fast student lookup by QR code (for instant QR scanner validation)
  /// Returns StudentData or null
  Future<Student?> findStudentByQr(String qrPayload) async {
    final record =
        await (database.select(database.students)
              ..where(
                (tbl) =>
                    tbl.qrCode.equals(qrPayload) & tbl.isDeleted.equals(false),
              )
              ..limit(1))
            .getSingleOrNull();
    return record;
  }

  /// Get multiple students by program (for bulk caching)
  Future<List<Student>> getStudentsByProgram({
    required int universityId,
    required int programId,
  }) async {
    final records =
        await (database.select(database.students)
              ..where(
                (tbl) =>
                    tbl.universityId.equals(universityId) &
                    tbl.programId.equals(programId) &
                    tbl.isActive.equals(true) &
                    tbl.isDeleted.equals(false),
              )
              ..orderBy([(tbl) => OrderingTerm(expression: tbl.fullName)]))
            .get();
    return records;
  }

  /// Insert a new student record (upsert on conflict)
  Future<Student> cacheStudent({
    required String universityStudentId,
    required String qrPayload,
    required String fullName,
    String? email,
    int universityId = 0,
    int programId = 0,
  }) async {
    final now = DateTime.now();
    final offlineUuid = _generateUuid();

    final id = await database
        .into(database.students)
        .insert(
          StudentsCompanion(
            universityStudentId: Value(universityStudentId),
            qrCode: Value(qrPayload),
            fullName: Value(fullName),
            email: Value(email),
            universityId: Value(universityId),
            programId: Value(programId),
            offlineUuid: Value(offlineUuid),
            createdAt: Value(now),
            updatedAt: Value(now),
            lastSeenAt: Value(now),
          ),
        );

    return await (database.select(
      database.students,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  /// Update last seen timestamp for student (for analytics)
  Future<void> updateStudentLastSeen(int studentId) async {
    await (database.update(database.students)
          ..where((tbl) => tbl.id.equals(studentId)))
        .write(StudentsCompanion(lastSeenAt: Value(DateTime.now())));
  }

  // ─────────────────────────────────────────────
  // SYNC QUEUE MANAGEMENT
  // ─────────────────────────────────────────────

  // Existing methods remain unchanged (getPendingAttendances, watchAttendanceByDate, etc.)
  // ... keep all existing methods ...

  Future<List<AttendanceModel>> getPendingAttendances() async {
    final records =
        await (database.select(database.attendances)..where(
              (tbl) =>
                  tbl.pendingSync.equals(true) & tbl.isDeleted.equals(false),
            ))
            .get();
    return records.map(_mapAttendance).toList();
  }

  Stream<List<AttendanceModel>> watchAttendanceByDate(DateTime date) {
    final range = _dayRange(date);
    final query = database.select(database.attendances)
      ..where(
        (tbl) =>
            tbl.attendanceDate.isBiggerOrEqualValue(range.$1) &
            tbl.attendanceDate.isSmallerThanValue(range.$2) &
            tbl.isDeleted.equals(false),
      )
      ..orderBy([
        (tbl) =>
            OrderingTerm(expression: tbl.updatedAt, mode: OrderingMode.desc),
      ]);

    return query.watch().map((rows) => rows.map(_mapAttendance).toList());
  }

  Stream<List<AttendanceModel>> watchAttendanceBySession({
    required int courseId,
    required int sessionId,
    required DateTime date,
  }) {
    final range = _dayRange(date);
    final query = database.select(database.attendances)
      ..where(
        (tbl) =>
            tbl.courseId.equals(courseId) &
            tbl.sessionId.equals(sessionId) &
            tbl.attendanceDate.isBiggerOrEqualValue(range.$1) &
            tbl.attendanceDate.isSmallerThanValue(range.$2) &
            tbl.isDeleted.equals(false),
      )
      ..orderBy([
        (tbl) =>
            OrderingTerm(expression: tbl.updatedAt, mode: OrderingMode.desc),
      ]);

    return query.watch().map((rows) => rows.map(_mapAttendance).toList());
  }

  Stream<int> watchPendingSyncCount() {
    final query = database.select(database.syncQueues)
      ..where(
        (tbl) =>
            (tbl.syncStatus.equals('pending') |
                tbl.syncStatus.equals('syncing')) &
            tbl.actionType.isNotIn(_internalSyncActionTypes),
      );
    return query.watch().map((rows) => rows.length);
  }

  Stream<List<String>> watchCoursesCacheJson({required String cacheKey}) {
    final query = database.select(database.coursesCaches)
      ..where((tbl) => tbl.cacheKey.equals(cacheKey));
    return query.watch().map(
      (rows) => rows.map((row) => row.payloadJson).toList(),
    );
  }

  Stream<List<String>> watchStudentsCacheJson({required String cacheKey}) {
    final query = database.select(database.studentsCaches)
      ..where((tbl) => tbl.cacheKey.equals(cacheKey));
    return query.watch().map(
      (rows) => rows.map((row) => row.payloadJson).toList(),
    );
  }

  Stream<Map<String, dynamic>?> watchSessionSnapshot({
    required int scheduleSlotId,
    required DateTime attendanceDate,
  }) {
    final query = database.select(database.sessionSnapshots)
      ..where(
        (tbl) =>
            tbl.cacheKey.equals(_sessionKey(scheduleSlotId, attendanceDate)),
      );

    return query.watchSingleOrNull().asyncMap((record) async {
      if (record == null) {
        return null;
      }
      return await compute(_parseJson, record.payloadJson);
    });
  }

  Stream<Map<String, dynamic>?> watchStudentAttendanceStatus(String cacheKey) {
    final query = database.select(database.studentAttendanceStatuses)
      ..where((tbl) => tbl.cacheKey.equals(cacheKey));

    return query.watchSingleOrNull().asyncMap((record) async {
      if (record == null) {
        return null;
      }
      return await compute(_parseJson, record.payloadJson);
    });
  }

  Future<AttendanceModel> saveAttendance({
    required int studentId,
    required DateTime attendanceDate,
    required String status,
    required int courseId,
    required int sessionId,
  }) async {
    final normalizedDate = DateTime.utc(
      attendanceDate.year,
      attendanceDate.month,
      attendanceDate.day,
      attendanceDate.hour,
      attendanceDate.minute,
      attendanceDate.second,
      attendanceDate.millisecond,
      attendanceDate.microsecond,
    );

    return database.transaction(() async {
      final existing = await _findAttendanceByIdentity(
        studentId: studentId,
        courseId: courseId,
        sessionId: sessionId,
        attendanceDate: normalizedDate,
      );

      final now = DateTime.now();
      if (existing == null) {
        final id = await database
            .into(database.attendances)
            .insert(
              AttendancesCompanion(
                studentId: Value(studentId),
                attendanceDate: Value(normalizedDate),
                status: Value(status),
                courseId: Value(courseId),
                sessionId: Value(sessionId),
                offlineUuid: Value(_generateUuid()),
                deviceId: const Value('local-device'),
                createdAt: Value(now),
                updatedAt: Value(now),
                pendingSync: const Value(true),
              ),
            );
        final inserted = await (database.select(
          database.attendances,
        )..where((tbl) => tbl.id.equals(id))).getSingle();
        return _mapAttendance(inserted);
      }

      await (database.update(
        database.attendances,
      )..where((tbl) => tbl.id.equals(existing.id))).write(
        AttendancesCompanion(
          studentId: Value(studentId),
          attendanceDate: Value(normalizedDate),
          status: Value(status),
          courseId: Value(courseId),
          sessionId: Value(sessionId),
          updatedAt: Value(now),
          pendingSync: const Value(true),
        ),
      );

      final updated = await (database.select(
        database.attendances,
      )..where((tbl) => tbl.id.equals(existing.id))).getSingle();
      return _mapAttendance(updated);
    });
  }

  Future<AttendanceModel?> updateAttendance({
    required int attendanceId,
    required String status,
    required bool pendingSync,
  }) async {
    final now = DateTime.now();
    await (database.update(
      database.attendances,
    )..where((tbl) => tbl.id.equals(attendanceId))).write(
      AttendancesCompanion(
        status: Value(status),
        pendingSync: Value(pendingSync),
        updatedAt: Value(now),
      ),
    );

    return getAttendance(attendanceId);
  }

  Future<void> deleteAttendance(int id) async {
    await (database.delete(
      database.attendances,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<AttendanceModel?> getAttendance(int id) async {
    final record = await (database.select(
      database.attendances,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return record == null ? null : _mapAttendance(record);
  }

  Future<List<AttendanceModel>> getAttendanceByDate(DateTime date) async {
    final range = _dayRange(date);
    final records =
        await (database.select(database.attendances)..where(
              (tbl) =>
                  tbl.attendanceDate.isBiggerOrEqualValue(range.$1) &
                  tbl.attendanceDate.isSmallerThanValue(range.$2) &
                  tbl.isDeleted.equals(false),
            ))
            .get();
    return records.map(_mapAttendance).toList();
  }

  Future<void> enqueueSyncItem({
    required String actionType,
    required String entityType,
    required int entityId,
    required Map<String, dynamic> payload,
  }) async {
    await database.transaction(() async {
      await (database.delete(database.syncQueues)..where(
            (tbl) =>
                tbl.entityType.equals(entityType) &
                tbl.entityId.equals(entityId) &
                (tbl.syncStatus.equals('pending') |
                    tbl.syncStatus.equals('syncing')),
          ))
          .go();

      await database
          .into(database.syncQueues)
          .insert(
            SyncQueuesCompanion(
              actionType: Value(actionType),
              entityType: Value(entityType),
              entityId: Value(entityId),
              payloadJson: Value(jsonEncode(payload)),
              syncStatus: const Value('pending'),
              deviceId: const Value('local-device'),
            ),
            mode: InsertMode.insertOrReplace,
          );
    });
  }

  Future<List<SyncQueueModel>> getPendingSyncItems() async {
    final records =
        await (database.select(database.syncQueues)
              ..where(
                (tbl) =>
                    (tbl.syncStatus.equals('pending') |
                        tbl.syncStatus.equals('syncing')) &
                    tbl.actionType.isNotIn(_internalSyncActionTypes),
              )
              ..orderBy([
                (tbl) => OrderingTerm(
                  expression: tbl.priority,
                  mode: OrderingMode.desc,
                ),
                (tbl) => OrderingTerm(
                  expression: tbl.createdAt,
                  mode: OrderingMode.asc,
                ),
              ]))
            .get();
    return records.map(_mapSyncQueue).toList();
  }

  Future<int> getPendingSyncCount() async {
    final rows =
        await (database.select(database.syncQueues)..where(
              (tbl) =>
                  (tbl.syncStatus.equals('pending') |
                      tbl.syncStatus.equals('syncing')) &
                  tbl.actionType.isNotIn(_internalSyncActionTypes),
            ))
            .get();
    return rows.length;
  }

  Future<void> markSyncItemAsSyncing(int queueId) async {
    await database.transaction(() async {
      final record = await (database.select(
        database.syncQueues,
      )..where((tbl) => tbl.id.equals(queueId))).getSingleOrNull();
      if (record == null) {
        return;
      }

      await (database.delete(database.syncQueues)..where(
            (tbl) =>
                tbl.id.isNotValue(queueId) &
                tbl.entityType.equals(record.entityType) &
                tbl.entityId.equals(record.entityId) &
                tbl.syncStatus.equals('syncing'),
          ))
          .go();

      await (database.update(
        database.syncQueues,
      )..where((tbl) => tbl.id.equals(queueId))).write(
        SyncQueuesCompanion(
          syncStatus: const Value('syncing'),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  Future<void> markSyncItemAsSuccess(int queueId) async {
    await database.transaction(() async {
      final record = await (database.select(
        database.syncQueues,
      )..where((tbl) => tbl.id.equals(queueId))).getSingleOrNull();
      if (record == null) {
        return;
      }

      await (database.delete(database.syncQueues)..where(
            (tbl) =>
                tbl.id.isNotValue(queueId) &
                tbl.entityType.equals(record.entityType) &
                tbl.entityId.equals(record.entityId) &
                (tbl.syncStatus.equals('success') |
                    tbl.syncStatus.equals('synced')),
          ))
          .go();

      final now = DateTime.now();
      await (database.update(
        database.syncQueues,
      )..where((tbl) => tbl.id.equals(queueId))).write(
        SyncQueuesCompanion(
          syncStatus: const Value('synced'),
          lastRetryAt: Value(now),
          syncedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    });
  }

  Future<void> markSyncItemAsFailed(int queueId, String error) async {
    final record = await (database.select(
      database.syncQueues,
    )..where((tbl) => tbl.id.equals(queueId))).getSingleOrNull();

    if (record == null) {
      return;
    }

    final now = DateTime.now();
    final newRetryCount = record.retryCount + 1;
    final retryDelay = Duration(
      seconds: pow(2.0, newRetryCount).toInt().clamp(1, 60),
    );

    await database.transaction(() async {
      await (database.delete(database.syncQueues)..where(
            (tbl) =>
                tbl.id.isNotValue(queueId) &
                tbl.entityType.equals(record.entityType) &
                tbl.entityId.equals(record.entityId) &
                tbl.syncStatus.equals('failed'),
          ))
          .go();

      await (database.update(
        database.syncQueues,
      )..where((tbl) => tbl.id.equals(queueId))).write(
        SyncQueuesCompanion(
          syncStatus: const Value('failed'),
          retryCount: Value(newRetryCount),
          lastError: Value(error),
          lastRetryAt: Value(now),
          nextRetryAt: Value(now.add(retryDelay)),
          updatedAt: Value(now),
        ),
      );
    });
  }

  Future<void> clearSyncedItems() async {
    await (database.delete(database.syncQueues)..where(
          (tbl) =>
              tbl.syncStatus.equals('success') |
              tbl.syncStatus.equals('synced'),
        ))
        .go();
  }

  Future<void> deleteSyncQueueItem(int queueId) async {
    await (database.delete(
      database.syncQueues,
    )..where((tbl) => tbl.id.equals(queueId))).go();
  }

  Future<void> saveCoursesCacheJson({
    required int semesterId,
    required int teacherId,
    required String cacheKey,
    required String payloadJson,
  }) async {
    await database.transaction(() async {
      await (database.delete(
        database.coursesCaches,
      )..where((tbl) => tbl.cacheKey.equals(cacheKey))).go();
      await database
          .into(database.coursesCaches)
          .insert(
            CoursesCachesCompanion(
              semesterId: Value(semesterId),
              teacherId: Value(teacherId),
              cacheKey: Value(cacheKey),
              payloadJson: Value(payloadJson),
              updatedAt: Value(DateTime.now()),
            ),
          );
    });
  }

  Future<String?> loadCoursesCacheJson({required String cacheKey}) async {
    final record = await (database.select(
      database.coursesCaches,
    )..where((tbl) => tbl.cacheKey.equals(cacheKey))).getSingleOrNull();
    return record?.payloadJson;
  }

  Future<void> saveStudentsCacheJson({
    required int slotContextId,
    required String cacheKey,
    required String payloadJson,
  }) async {
    await database.transaction(() async {
      await (database.delete(
        database.studentsCaches,
      )..where((tbl) => tbl.cacheKey.equals(cacheKey))).go();
      await database
          .into(database.studentsCaches)
          .insert(
            StudentsCachesCompanion(
              slotContextId: Value(slotContextId),
              cacheKey: Value(cacheKey),
              payloadJson: Value(payloadJson),
              updatedAt: Value(DateTime.now()),
            ),
          );
    });
  }

  Future<String?> loadStudentsCacheJson({required String cacheKey}) async {
    final record = await (database.select(
      database.studentsCaches,
    )..where((tbl) => tbl.cacheKey.equals(cacheKey))).getSingleOrNull();
    return record?.payloadJson;
  }

  Future<void> saveSessionSnapshot({
    required int scheduleSlotId,
    required DateTime attendanceDate,
    required Map<String, dynamic> session,
  }) async {
    final normalized = _normalizeSessionSnapshot(
      scheduleSlotId: scheduleSlotId,
      attendanceDate: attendanceDate,
      session: session,
    );

    final cacheKey = _sessionKey(scheduleSlotId, attendanceDate);

    await database.transaction(() async {
      // Delete existing to avoid UNIQUE constraint on cache_key
      await (database.delete(
        database.sessionSnapshots,
      )..where((tbl) => tbl.cacheKey.equals(cacheKey))).go();

      // Insert new snapshot
      await database
          .into(database.sessionSnapshots)
          .insert(
            SessionSnapshotsCompanion(
              cacheKey: Value(cacheKey),
              scheduleSlotId: Value(scheduleSlotId),
              attendanceDate: Value(
                DateTime.utc(
                  attendanceDate.year,
                  attendanceDate.month,
                  attendanceDate.day,
                ),
              ),
              payloadJson: Value(jsonEncode(normalized)),
              updatedAt: Value(DateTime.now()),
            ),
          );
    });
  }

  Future<Map<String, dynamic>?> loadSessionSnapshot({
    required int scheduleSlotId,
    required DateTime attendanceDate,
  }) async {
    final record =
        await (database.select(database.sessionSnapshots)..where(
              (tbl) => tbl.cacheKey.equals(
                _sessionKey(scheduleSlotId, attendanceDate),
              ),
            ))
            .getSingleOrNull();
    if (record == null) {
      return null;
    }

    return compute(_parseJson, record.payloadJson);
  }

  Future<void> clearSessionSnapshot({
    required int scheduleSlotId,
    required DateTime attendanceDate,
  }) async {
    await (database.delete(database.sessionSnapshots)..where(
          (tbl) =>
              tbl.cacheKey.equals(_sessionKey(scheduleSlotId, attendanceDate)),
        ))
        .go();
  }

  Future<void> saveStudentAttendanceStatus({
    required String cacheKey,
    required int studentId,
    required Map<String, dynamic> status,
  }) async {
    await database.transaction(() async {
      await (database.delete(
        database.studentAttendanceStatuses,
      )..where((tbl) => tbl.cacheKey.equals(cacheKey))).go();
      await database
          .into(database.studentAttendanceStatuses)
          .insert(
            StudentAttendanceStatusesCompanion(
              cacheKey: Value(cacheKey),
              studentId: Value(studentId),
              payloadJson: Value(jsonEncode(status)),
              updatedAt: Value(DateTime.now()),
            ),
          );
    });
  }

  Future<Map<String, dynamic>?> loadStudentAttendanceStatus({
    required String cacheKey,
  }) async {
    final record = await (database.select(
      database.studentAttendanceStatuses,
    )..where((tbl) => tbl.cacheKey.equals(cacheKey))).getSingleOrNull();
    if (record == null) {
      return null;
    }

    return compute(_parseJson, record.payloadJson);
  }

  /// Builds an offline QR payload from the locally synced students table.
  Future<String?> buildOfflineQrPayload(String userId) async {
    final record =
        await (database.select(database.students)
              ..where(
                (tbl) =>
                    tbl.universityStudentId.equals(userId) &
                    tbl.isDeleted.equals(false),
              )
              ..limit(1))
            .getSingleOrNull();

    if (record == null) {
      return null;
    }

    return record.qrCode.isNotEmpty ? record.qrCode : null;
  }

  AttendanceModel _mapAttendance(Attendance record) {
    return AttendanceModel(
      id: record.id,
      studentId: record.studentId,
      attendanceDate: record.attendanceDate,
      status: record.status,
      courseId: record.courseId,
      sessionId: record.sessionId,
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
      pendingSync: record.pendingSync,
      syncError: record.syncError,
    );
  }

  SyncQueueModel _mapSyncQueue(SyncQueue record) {
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

  Future<AttendanceModel?> _findAttendanceByIdentity({
    required int studentId,
    required int courseId,
    required int sessionId,
    required DateTime attendanceDate,
  }) async {
    final range = _dayRange(attendanceDate);
    final record =
        await (database.select(database.attendances)..where(
              (tbl) =>
                  tbl.studentId.equals(studentId) &
                  tbl.courseId.equals(courseId) &
                  tbl.sessionId.equals(sessionId) &
                  tbl.attendanceDate.isBiggerOrEqualValue(range.$1) &
                  tbl.attendanceDate.isSmallerThanValue(range.$2),
            ))
            .getSingleOrNull();
    return record == null ? null : _mapAttendance(record);
  }

  String _sessionKey(int scheduleSlotId, DateTime attendanceDate) {
    return '$scheduleSlotId:${attendanceDate.year.toString().padLeft(4, '0')}-${attendanceDate.month.toString().padLeft(2, '0')}-${attendanceDate.day.toString().padLeft(2, '0')}';
  }

  Map<String, dynamic> _normalizeSessionSnapshot({
    required int scheduleSlotId,
    required DateTime attendanceDate,
    required Map<String, dynamic> session,
  }) {
    final normalized = Map<String, dynamic>.from(session);
    normalized['scheduleSlotId'] = scheduleSlotId;
    normalized['sessionDate'] = DateTime.utc(
      attendanceDate.year,
      attendanceDate.month,
      attendanceDate.day,
    ).toIso8601String();
    normalized['attendance'] =
        (normalized['attendance'] as List<dynamic>? ?? const <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(
              (item) => <String, dynamic>{
                'studentId': item['studentId'],
                'status': (item['status'] ?? 'absent').toString(),
                if (item['notes'] != null) 'notes': item['notes'],
              },
            )
            .toList();
    return normalized;
  }

  static Map<String, dynamic> _parseJson(String json) {
    final decoded = jsonDecode(json);
    return decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
  }

  (DateTime, DateTime) _dayRange(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (start, end);
  }

  String _generateUuid() {
    // Simple UUID v4 generation
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(256));
    values[6] = (values[6] & 0x0f) | 0x40;
    values[8] = (values[8] & 0x3f) | 0x80;
    final hex = values.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }
}
