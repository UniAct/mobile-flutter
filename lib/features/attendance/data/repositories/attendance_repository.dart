import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';
import 'package:mobile_flutter/features/attendance/attendance_models.dart';
import 'package:mobile_flutter/features/attendance/data/datasources/attendance_local_datasource.dart';
import 'package:mobile_flutter/features/attendance/data/datasources/attendance_remote_datasource.dart';
import 'package:mobile_flutter/features/attendance/data/database/attendance_database.dart';
import 'package:mobile_flutter/features/attendance/data/models/attendance_model.dart';
import 'package:mobile_flutter/features/attendance/services/local_student_service.dart';

/// Repository implementing SSOT (Single Source of Truth) pattern
///
/// ARCHITECTURAL RULES:
/// 1. UI reads ONLY from local database (SQLite/Drift streams)
/// 2. Writes are LOCAL ONLY - queue for background sync
/// 3. Repository NEVER exposes API-level models to UI
/// 4. SyncEngine runs independently; repository doesn't trigger it
class AttendanceRepository {
  final AttendanceLocalDataSource localDataSource;
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepository({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  // ─────────────────────────────────────────────
  // LOCAL STUDENT LOOKUP (QR VALIDATION)
  // ─────────────────────────────────────────────
  /// High-speed local student lookup by QR code
  /// Expected latency: < 1ms with proper indexes
  Future<LocalStudent?> findStudentByQr(String qrPayload) async {
    try {
      final student = await localDataSource.findStudentByQr(qrPayload);
      return student == null ? null : _toLocalStudent(student);
    } catch (e) {
      debugPrint('[AttendanceRepository] QR lookup failed: $e');
      return null;
    }
  }

  /// Bulk student lookup for pre-caching (before scanner opens)
  Future<List<LocalStudent>> getStudentsForProgram({
    required int universityId,
    required int programId,
  }) async {
    try {
      final students = await localDataSource.getStudentsByProgram(
        universityId: universityId,
        programId: programId,
      );
      return students.map(_toLocalStudent).toList();
    } catch (e) {
      debugPrint('[AttendanceRepository] Student cache miss: $e');
      return [];
    }
  }

  /// Cache a new student (called after successful QR scan with unknown student)
  Future<LocalStudent> cacheStudentFromQr({
    required String qrPayload,
    required String fullName,
    String? email,
    String? universityStudentId,
  }) async {
    try {
      final student = await localDataSource.cacheStudent(
        qrPayload: qrPayload,
        fullName: fullName,
        email: email,
        universityStudentId: universityStudentId ?? qrPayload,
      );
      return _toLocalStudent(student);
    } catch (e) {
      debugPrint('[AttendanceRepository] Failed to cache student: $e');
      rethrow;
    }
  }

  // ─────────────────────────────────────────────
  // READING OPERATIONS (SQLite-First, No API)
  // ─────────────────────────────────────────────

  Stream<List<AttendanceModel>> watchAttendanceByDate(DateTime date) {
    return localDataSource.watchAttendanceByDate(date);
  }

  Stream<List<AttendanceModel>> watchAttendanceBySession({
    required int courseId,
    required int sessionId,
    required DateTime date,
  }) {
    return localDataSource.watchAttendanceBySession(
      courseId: courseId,
      sessionId: sessionId,
      date: date,
    );
  }

  Stream<int> watchPendingSyncCount() {
    return localDataSource.watchPendingSyncCount();
  }

  Stream<List<StaffAttendanceCourseOption>> watchCoursesCached({
    required int semesterId,
    required int teacherId,
  }) async* {
    final cacheKey = '$semesterId:$teacherId';
    yield await getCoursesCached(semesterId: semesterId, teacherId: teacherId);
    yield* localDataSource.watchCoursesCacheJson(cacheKey: cacheKey).asyncMap((
      payloads,
    ) async {
      return await compute(_parseCoursesPayload, payloads).then((list) => list);
    });
  }

  static List<StaffAttendanceCourseOption> _parseCoursesPayload(
    List<String> payloads,
  ) {
    return payloads
        .expand((payload) {
          final decoded = jsonDecode(payload);
          final list = decoded is List ? decoded : const <dynamic>[];
          return list.whereType<Map<String, dynamic>>();
        })
        .map(StaffAttendanceCourseOption.fromJson)
        .toList();
  }

  Stream<List<EnrolledStudent>> watchStudentsCached(int slotContextId) async* {
    final cacheKey = slotContextId.toString();
    yield await getStudentsCached(slotContextId);
    yield* localDataSource.watchStudentsCacheJson(cacheKey: cacheKey).asyncMap((
      payloads,
    ) async {
      return await compute(_parseStudentsPayload, payloads);
    });
  }

  static List<EnrolledStudent> _parseStudentsPayload(List<String> payloads) {
    return payloads
        .expand((payload) {
          final decoded = jsonDecode(payload);
          final list = decoded is List ? decoded : const <dynamic>[];
          return list.whereType<Map<String, dynamic>>();
        })
        .map(EnrolledStudent.fromJson)
        .toList();
  }

  Stream<Map<String, dynamic>?> watchSessionSnapshot({
    required int scheduleSlotId,
    required DateTime attendanceDate,
  }) {
    return localDataSource.watchSessionSnapshot(
      scheduleSlotId: scheduleSlotId,
      attendanceDate: attendanceDate,
    );
  }

  Stream<Map<String, dynamic>?> watchStudentAttendanceStatus(String cacheKey) {
    return localDataSource.watchStudentAttendanceStatus(cacheKey);
  }

  // ─────────────────────────────────────────────
  // CACHE READING (Offline Mode)
  // ─────────────────────────────────────────────

  Future<List<StaffAttendanceCourseOption>> getCoursesCached({
    required int semesterId,
    required int teacherId,
  }) async {
    try {
      final cacheKey = '$semesterId:$teacherId';
      final cached = await localDataSource.loadCoursesCacheJson(
        cacheKey: cacheKey,
      );

      if (cached == null || cached.isEmpty) {
        return [];
      }

      final decoded = jsonDecode(cached);
      final list = decoded is List ? decoded : [];
      return list
          .whereType<Map<String, dynamic>>()
          .map(StaffAttendanceCourseOption.fromJson)
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<EnrolledStudent>> getStudentsCached(int slotContextId) async {
    try {
      final cacheKey = slotContextId.toString();
      final cached = await localDataSource.loadStudentsCacheJson(
        cacheKey: cacheKey,
      );

      if (cached == null || cached.isEmpty) {
        return [];
      }

      final decoded = jsonDecode(cached);
      final list = decoded is List ? decoded : [];
      return list
          .whereType<Map<String, dynamic>>()
          .map(EnrolledStudent.fromJson)
          .toList();
    } catch (_) {
      return [];
    }
  }

  // ─────────────────────────────────────────────
  // WRITE OPERATIONS (Optimistic Local-First)
  // ─────────────────────────────────────────────
  ///
  /// All writes obey the SSOT contract:
  /// 1. Write to local database immediately (optimistic UI)
  /// 2. Enqueue sync item for background processing
  /// 3. Return immediately; UI updates via stream listener
  /// 4. No network blocking; sync happens asynchronously

  Future<List<StaffAttendanceCourseOption>> fetchAndCacheCourses({
    required int semesterId,
    required int teacherId,
  }) async {
    try {
      final courses = await remoteDataSource.getCourseOptions(
        semesterId: semesterId,
        teacherId: teacherId,
      );
      if (courses.isNotEmpty) {
        final cacheKey = '$semesterId:$teacherId';
        await localDataSource.saveCoursesCacheJson(
          semesterId: semesterId,
          teacherId: teacherId,
          cacheKey: cacheKey,
          payloadJson: jsonEncode(courses.map((c) => c.toJson()).toList()),
        );
      }
      return courses;
    } catch (e) {
      debugPrint('[AttendanceRepository] fetchAndCacheCourses failed: $e');
      return getCoursesCached(semesterId: semesterId, teacherId: teacherId);
    }
  }

  Future<List<EnrolledStudent>> fetchAndCacheStudents(int slotContextId) async {
    try {
      final students = await remoteDataSource.getEnrolledStudents(
        slotContextId,
      );
      if (students.isNotEmpty) {
        final cacheKey = slotContextId.toString();
        await localDataSource.saveStudentsCacheJson(
          slotContextId: slotContextId,
          cacheKey: cacheKey,
          payloadJson: jsonEncode(students.map((s) => s.toJson()).toList()),
        );
      }
      return students;
    } catch (e) {
      debugPrint('[AttendanceRepository] fetchAndCacheStudents failed: $e');
      return getStudentsCached(slotContextId);
    }
  }

  /// Fetches the student's own attendance status and caches it for offline use.
  Future<Map<String, dynamic>?> fetchAndCacheStudentStatus(
    String userId,
  ) async {
    try {
      final status = await remoteDataSource.getStudentAttendanceStatus();
      if (status.isNotEmpty) {
        await localDataSource.saveStudentAttendanceStatus(
          cacheKey: userId,
          studentId: int.tryParse(userId) ?? 0,
          status: status,
        );
      }
      return status;
    } catch (e) {
      debugPrint(
        '[AttendanceRepository] fetchAndCacheStudentStatus failed: $e',
      );
      return localDataSource.loadStudentAttendanceStatus(cacheKey: userId);
    }
  }

  Future<Map<String, dynamic>?> fetchAndCacheSessionSnapshot({
    required int scheduleSlotId,
    required DateTime attendanceDate,
  }) async {
    try {
      final session = await remoteDataSource.getSessionBySlotAndDate(
        scheduleSlotId: scheduleSlotId,
        attendanceDate: attendanceDate,
      );

      if (session == null || session.isEmpty) {
        await localDataSource.clearSessionSnapshot(
          scheduleSlotId: scheduleSlotId,
          attendanceDate: attendanceDate,
        );
        return null;
      }

      await localDataSource.saveSessionSnapshot(
        scheduleSlotId: scheduleSlotId,
        attendanceDate: attendanceDate,
        session: session,
      );
      return session;
    } catch (e) {
      debugPrint(
        '[AttendanceRepository] fetchAndCacheSessionSnapshot failed: $e',
      );
      return localDataSource.loadSessionSnapshot(
        scheduleSlotId: scheduleSlotId,
        attendanceDate: attendanceDate,
      );
    }
  }

  /// Returns a locally available QR payload for offline display.
  Future<String?> getOfflineQrPayload(String userId) async {
    return localDataSource.buildOfflineQrPayload(userId);
  }

  Future<AttendanceModel> markAttendanceLocally({
    required int studentId,
    required DateTime attendanceDate,
    required String status,
    required int courseId,
    required int sessionId,
  }) async {
    try {
      final record = await localDataSource.saveAttendance(
        studentId: studentId,
        attendanceDate: attendanceDate,
        status: status,
        courseId: courseId,
        sessionId: sessionId,
      );

      await localDataSource.enqueueSyncItem(
        actionType: 'mark_attendance',
        entityType: 'attendance',
        entityId: record.id,
        payload: {
          'studentId': studentId,
          'attendanceDate': attendanceDate.toIso8601String(),
          'status': status,
          'courseId': courseId,
          'sessionId': sessionId,
        },
      );

      return record;
    } catch (e) {
      throw AppException('Failed to save attendance: $e');
    }
  }

  Future<List<AttendanceModel>> submitManualAttendanceLocally({
    required int scheduleSlotId,
    required int facultyMemberId,
    required DateTime attendanceDate,
    required String startTime,
    required String endTime,
    required List<ManualAttendanceRecord> records,
  }) async {
    try {
      final saved = <AttendanceModel>[];
      for (final record in records) {
        saved.add(
          await localDataSource.saveAttendance(
            studentId: record.studentId,
            attendanceDate: attendanceDate,
            status: record.status,
            courseId: scheduleSlotId,
            sessionId: scheduleSlotId,
          ),
        );
      }

      await localDataSource.enqueueSyncItem(
        actionType: 'manual_batch',
        entityType: 'attendance_session',
        entityId: scheduleSlotId,
        payload: {
          'slotId': scheduleSlotId,
          'facultyMemberId': facultyMemberId,
          'startTime': startTime,
          'endTime': endTime,
          'records': records.map((record) => record.toJson()).toList(),
          'sessionDate': attendanceDate.toIso8601String(),
          'attendanceMode': 'Manual',
        },
      );

      await localDataSource.saveSessionSnapshot(
        scheduleSlotId: scheduleSlotId,
        attendanceDate: attendanceDate,
        session: <String, dynamic>{
          'scheduleSlotId': scheduleSlotId,
          'sessionDate': attendanceDate.toIso8601String(),
          'attendanceMode': 'Manual',
          'attendance': records
              .map(
                (record) => <String, dynamic>{
                  'studentId': record.studentId,
                  'status': record.status.toString(),
                  if (record.notes != null) 'notes': record.notes,
                },
              )
              .toList(),
        },
      );

      return saved;
    } catch (e) {
      throw AppException('Failed to save attendance locally: $e');
    }
  }

  Future<void> submitQrScanLocally({
    required int scheduleSlotId,
    required int facultyMemberId,
    required int studentId,
    required DateTime attendanceDate,
    required String startTime,
    required String endTime,
    required String qrPayload,
  }) async {
    try {
      await localDataSource.enqueueSyncItem(
        actionType: 'qr_scan',
        entityType: 'attendance_qr_scan',
        entityId: _attendanceQueueEntityId(
          scheduleSlotId: scheduleSlotId,
          studentId: studentId,
          attendanceDate: attendanceDate,
        ),
        payload: {
          'slotId': scheduleSlotId,
          'facultyMemberId': facultyMemberId,
          'studentId': studentId,
          'startTime': startTime,
          'endTime': endTime,
          'sessionDate': attendanceDate.toIso8601String(),
          'attendanceMode': 'QRCode',
          'qrPayload': qrPayload,
          'status': 'present',
        },
      );
    } catch (e) {
      throw AppException('Failed to queue QR attendance locally: $e');
    }
  }

  int _attendanceQueueEntityId({
    required int scheduleSlotId,
    required int studentId,
    required DateTime attendanceDate,
  }) {
    final key =
        '$scheduleSlotId:$studentId:${attendanceDate.year}-'
        '${attendanceDate.month}-${attendanceDate.day}';
    var hash = 0x811c9dc5;
    for (final codeUnit in key.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 0x01000193) & 0x7fffffff;
    }
    return hash;
  }

  Future<AttendanceModel> applyQrAttendanceLocally({
    required int scheduleSlotId,
    required DateTime attendanceDate,
    required int studentId,
    required String status,
  }) async {
    try {
      final record = await localDataSource.saveAttendance(
        studentId: studentId,
        attendanceDate: attendanceDate,
        status: status,
        courseId: scheduleSlotId,
        sessionId: scheduleSlotId,
      );

      final snapshot = await localDataSource.loadSessionSnapshot(
        scheduleSlotId: scheduleSlotId,
        attendanceDate: attendanceDate,
      );

      final attendance = <Map<String, dynamic>>[
        for (final item
            in (snapshot?['attendance'] as List<dynamic>? ?? const <dynamic>[])
                .whereType<Map<String, dynamic>>())
          <String, dynamic>{
            'studentId': item['studentId'],
            'status': (item['status'] ?? 'absent').toString(),
            if (item['notes'] != null) 'notes': item['notes'],
          },
      ];

      final updatedIndex = attendance.indexWhere(
        (item) => _toInt(item['studentId']) == studentId,
      );
      if (updatedIndex >= 0) {
        attendance[updatedIndex] = {'studentId': studentId, 'status': status};
      } else {
        attendance.add({'studentId': studentId, 'status': status});
      }

      await localDataSource.saveSessionSnapshot(
        scheduleSlotId: scheduleSlotId,
        attendanceDate: attendanceDate,
        session: <String, dynamic>{
          ...(snapshot ?? <String, dynamic>{}),
          'scheduleSlotId': scheduleSlotId,
          'sessionDate': attendanceDate.toIso8601String(),
          'attendance': attendance,
        },
      );

      return record;
    } catch (e) {
      throw AppException('Failed to save QR attendance locally: $e');
    }
  }

  Future<AttendanceModel?> updateAttendanceLocally({
    required int attendanceId,
    required String status,
  }) async {
    try {
      return await localDataSource.updateAttendance(
        attendanceId: attendanceId,
        status: status,
        pendingSync: true,
      );
    } catch (e) {
      throw AppException('Failed to update attendance locally: $e');
    }
  }

  Future<void> deleteAttendanceLocally(int attendanceId) async {
    try {
      await localDataSource.deleteAttendance(attendanceId);
      await localDataSource.enqueueSyncItem(
        actionType: 'delete_attendance',
        entityType: 'attendance',
        entityId: attendanceId,
        payload: {'id': attendanceId},
      );
    } catch (e) {
      throw AppException('Failed to delete attendance locally: $e');
    }
  }

  // ─────────────────────────────────────────────
  // CONFLICT RESOLUTION
  // ─────────────────────────────────────────────

  bool shouldUpdateLocal({
    required DateTime localUpdatedAt,
    required DateTime remoteUpdatedAt,
  }) {
    return remoteUpdatedAt.isAfter(localUpdatedAt);
  }

  // ─────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────

  int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is String) {
      return int.tryParse(value) ?? 0;
    }

    if (value is num) {
      return value.toInt();
    }

    return 0;
  }

  LocalStudent _toLocalStudent(Student student) {
    return LocalStudent(
      id: student.id,
      universityStudentId: student.universityStudentId,
      qrCode: student.qrCode,
      fullName: student.fullName,
      email: student.email,
      universityId: student.universityId,
      programId: student.programId,
      currentSemester: student.currentSemester,
      offlineUuid: student.offlineUuid,
      deviceId: student.deviceId,
      isActive: student.isActive,
      isDeleted: student.isDeleted,
      createdAt: student.createdAt,
      updatedAt: student.updatedAt,
      lastSeenAt: student.lastSeenAt,
    );
  }
}
