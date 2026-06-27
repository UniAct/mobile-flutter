import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile_flutter/core/api/api_client.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';
import 'package:mobile_flutter/features/attendance/attendance_models.dart';
import 'package:mobile_flutter/features/attendance/data/models/sync_queue_model.dart';

class AttendanceRemoteDataSource {
  final ApiClient apiClient;

  AttendanceRemoteDataSource({required this.apiClient});

  // ─────────────────────────────────────────────
  // DELTA SYNC API
  // ─────────────────────────────────────────────

  /// Fetch changes since last sync timestamp
  /// GET /sync/delta?since=2024-01-01T00:00:00Z&entity=students,attendance,courses
  /// Returns: {
  ///   "students": [{...}, ...],
  ///   "attendance": [{...}, ...],
  ///   "lastSync": "2024-01-01T12:00:00Z"
  /// }
  Future<Map<String, List<Map<String, dynamic>>>> fetchDeltaChanges({
    required String entityType,
    required DateTime? since,
    int limit = 200,
  }) async {
    debugPrint(
      '[RemoteDataSource] Delta sync is not exposed by the backend contract; '
      'skipping $entityType pull.',
    );
    return {entityType: []};
  }

  // ─────────────────────────────────────────────
  // BULK SYNC ENDPOINTS
  // ─────────────────────────────────────────────

  /// Batch create/update attendance records (for delta sync)
  Future<void> syncAttendanceBatch(List<Map<String, dynamic>> records) async {
    throw AppException(
      'Bulk attendance sync is not available in the current backend contract.',
    );
  }

  /// Batch sync students (for initial/full sync)
  Future<Map<String, dynamic>> syncStudentsBatch({
    required List<Map<String, dynamic>> students,
    required DateTime lastSync,
  }) async {
    throw AppException(
      'Bulk student sync is not available in the current backend contract.',
    );
  }

  // ─────────────────────────────────────────────
  // CONFLICT DETECTION API
  // ─────────────────────────────────────────────

  /// Check for version conflicts before applying changes
  /// GET /sync/check-conflicts?type=attendance&ids=1,2,3
  Future<Map<String, Map<String, DateTime>>> checkConflicts({
    required String entityType,
    required List<int> entityIds,
    required Map<int, DateTime> localVersions,
  }) async {
    debugPrint(
      '[RemoteDataSource] Conflict check is not exposed by the backend '
      'contract; using local FIFO conflict handling for $entityType.',
    );
    return <String, Map<String, DateTime>>{};
  }

  // ─────────────────────────────────────────────
  // EXISTING API METHODS (UNCHANGED)
  // ─────────────────────────────────────────────

  Future<List<StaffAttendanceCourseOption>> getCourseOptions({
    required int semesterId,
    required int teacherId,
  }) async {
    try {
      final query = <String, String>{
        'semesterId': semesterId.toString(),
        'teacherId': teacherId.toString(),
      };

      final response = await apiClient.get(
        '/attendance/courses?${Uri(queryParameters: query).query}',
        requiresAuth: true,
      );

      final raw = response is Map<String, dynamic> ? response['data'] : null;
      final items = (raw is List<dynamic> ? raw : const <dynamic>[])
          .whereType<Map<String, dynamic>>()
          .map(StaffAttendanceCourseOption.fromJson)
          .toList();

      return items;
    } on AppException {
      rethrow;
    }
  }

  Future<List<EnrolledStudent>> getEnrolledStudents(int slotContextId) async {
    try {
      final response = await apiClient.get(
        '/attendance/enrolled/$slotContextId',
        requiresAuth: true,
      );

      final raw = response is Map<String, dynamic> ? response['data'] : null;
      final items = (raw is List<dynamic> ? raw : const <dynamic>[])
          .whereType<Map<String, dynamic>>()
          .map(EnrolledStudent.fromJson)
          .toList();

      return items;
    } on AppException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getStudentAttendanceStatus() async {
    try {
      final response = await apiClient.get(
        '/attendance/mobile/student/my-status',
        requiresAuth: true,
      );

      return _extractData(response);
    } on AppException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getSessionBySlotAndDate({
    required int scheduleSlotId,
    required DateTime attendanceDate,
  }) async {
    try {
      final response = await apiClient.get(
        '/attendance/session/by-slot/$scheduleSlotId?date=${Uri.encodeComponent(_toUtcDateOnly(attendanceDate).toIso8601String())}',
        requiresAuth: true,
      );

      final data = _extractData(response);
      return data.isEmpty ? null : data;
    } on AppException {
      rethrow;
    }
  }

  Future<void> syncAttendance({
    required int studentId,
    required DateTime attendanceDate,
    required String status,
    required int courseId,
    required int sessionId,
  }) async {
    try {
      await apiClient.post(
        '/attendance/session/$sessionId/attendances',
        requiresAuth: true,
        body: <String, dynamic>{
          'attendanceSessionId': sessionId,
          'records': [
            {'studentId': studentId, 'status': status.toLowerCase()},
          ],
        },
      );
    } on AppException {
      rethrow;
    }
  }

  Future<AttendanceSyncResult?> executeSyncItem(SyncQueueModel item) async {
    try {
      if (item.actionType == '_sync_meta' || item.actionType == 'delta_sync') {
        debugPrint(
          '[RemoteDataSource] Skipping internal item: ${item.actionType}',
        );
        return null;
      }

      final payload = jsonDecode(item.payloadJson);

      switch (item.actionType) {
        case 'manual_batch':
          return await _submitManualBatchOnline(payload as Map<String, dynamic>);

        case 'qr_scan':
          return await _submitQrOnline(payload as Map<String, dynamic>);

        case 'mark_attendance':
          return await _submitSingleAttendanceOnline(payload as Map<String, dynamic>);

        case 'update_attendance':
          return await _submitSingleAttendanceOnline(payload as Map<String, dynamic>);

        case 'delete_attendance':
          debugPrint(
            '[RemoteDataSource] Backend has no attendance delete endpoint; '
            'leaving item ${item.id} for a future contract.',
          );
          return null;

        default:
          debugPrint(
            '[RemoteDataSource] Unknown sync action "${item.actionType}" '
            'for item ${item.id}; skipping',
          );
          return null;
      }
    } on AppException {
      rethrow;
    }
  }

  Future<AttendanceSyncResult> _submitSingleAttendanceOnline(
    Map<String, dynamic> payload,
  ) async {
    final sessionId = _toInt(
      payload['sessionId'] ?? payload['attendanceSessionId'],
    );
    final studentId = _toInt(payload['studentId']);
    if (sessionId <= 0 || studentId <= 0) {
      throw AppException(
        'Cannot sync attendance without session and student ids.',
      );
    }

    final response = await apiClient.post(
      '/attendance/session/$sessionId/attendances',
      requiresAuth: true,
      body: <String, dynamic>{
        'attendanceSessionId': sessionId,
        'records': [
          {
            'studentId': studentId,
            'status': (payload['status'] ?? 'absent').toString().toLowerCase(),
            if (payload['notes'] != null) 'notes': payload['notes'],
          },
        ],
      },
    );

    return AttendanceSyncResult(
      scheduleSlotId: _toInt(payload['slotId'] ?? payload['courseId']),
      sessionId: sessionId,
      sessionDate: _toDate((payload['attendanceDate'] ?? payload['sessionDate'] ?? '').toString()),
      records: [
        {
          'studentId': studentId,
          'status': (payload['status'] ?? 'absent').toString().toLowerCase(),
        },
      ],
      serverRecords: _extractDataList(response),
    );
  }

  Future<AttendanceSyncResult> _submitManualBatchOnline(Map<String, dynamic> payload) async {
    final slotId = _toInt(payload['slotId']);
    final facultyMemberId = _toInt(payload['facultyMemberId']);
    final startTime = (payload['startTime'] ?? '').toString();
    final endTime = (payload['endTime'] ?? '').toString();
    final attendanceMode = (payload['attendanceMode'] ?? 'Manual').toString();

    final sessionId = await _ensureSession(
      slotId: slotId,
      facultyMemberId: facultyMemberId,
      startTime: startTime,
      endTime: endTime,
      attendanceMode: attendanceMode,
      sessionDateIso: (payload['sessionDate'] ?? '').toString(),
    );

    final records = (payload['records'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((item) {
          final record = <String, dynamic>{
            'studentId': _toInt(item['studentId']),
            'status': (item['status'] ?? 'absent').toString().toLowerCase(),
          };
          if (item['notes'] != null) {
            record['notes'] = item['notes'];
          }
          return record;
        })
        .toList();

    final response = await apiClient.post(
      '/attendance/session/$sessionId/attendances',
      requiresAuth: true,
      body: <String, dynamic>{
        'attendanceSessionId': sessionId,
        'records': records,
      },
    );

    return AttendanceSyncResult(
      scheduleSlotId: slotId,
      sessionId: sessionId,
      sessionDate: _toDate((payload['sessionDate'] ?? '').toString()),
      records: records,
      serverRecords: _extractDataList(response),
    );
  }

  Future<AttendanceSyncResult> _submitQrOnline(Map<String, dynamic> payload) async {
    final slotId = _toInt(payload['slotId']);
    final facultyMemberId = _toInt(payload['facultyMemberId']);
    final startTime = (payload['startTime'] ?? '').toString();
    final endTime = (payload['endTime'] ?? '').toString();
    final attendanceMode = (payload['attendanceMode'] ?? 'QRCode').toString();
    final studentId = _toInt(payload['studentId']);

    final sessionId = await _ensureSession(
      slotId: slotId,
      facultyMemberId: facultyMemberId,
      startTime: startTime,
      endTime: endTime,
      attendanceMode: attendanceMode,
      sessionDateIso: (payload['sessionDate'] ?? '').toString(),
    );

    final response = await apiClient.post(
      '/attendance/session/$sessionId/scan',
      requiresAuth: true,
      body: <String, dynamic>{
        'qrPayload': _normalizedQrPayload(
          payload['qrPayload'],
          studentId: studentId,
        ),
        'status': (payload['status'] ?? 'present').toString().toLowerCase(),
      },
    );

    return AttendanceSyncResult(
      scheduleSlotId: slotId,
      sessionId: sessionId,
      sessionDate: _toDate((payload['sessionDate'] ?? '').toString()),
      records: [
        {
          'studentId': studentId,
          'status': (payload['status'] ?? 'present').toString().toLowerCase(),
        },
      ],
      serverRecords: [_extractData(response)],
    );
  }

  String _normalizedQrPayload(dynamic rawPayload, {required int studentId}) {
    final raw = rawPayload?.toString().trim() ?? '';
    if (raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic> &&
            _toInt(decoded['studentId']) > 0) {
          return raw;
        }
      } catch (_) {}
    }

    if (studentId <= 0) {
      throw AppException('Cannot sync QR attendance without a student id.');
    }

    return jsonEncode(<String, dynamic>{'studentId': studentId});
  }

  Future<int> _ensureSession({
    required int slotId,
    required int facultyMemberId,
    required String startTime,
    required String endTime,
    required String attendanceMode,
    required String sessionDateIso,
  }) async {
    final sessionDate = _toDate(sessionDateIso);
    final sessionLookup = await apiClient.get(
      '/attendance/session/by-slot/$slotId?date=${Uri.encodeComponent(_toUtcDateOnly(sessionDate).toIso8601String())}',
      requiresAuth: true,
    );

    final existing = _extractData(sessionLookup);
    final existingId = _toInt(existing['id']);
    if (existingId > 0) {
      return existingId;
    }

    final createResponse = await apiClient.post(
      '/attendance/session',
      requiresAuth: true,
      body: <String, dynamic>{
        'scheduleSlotId': slotId,
        'facultyMemberId': facultyMemberId,
        'sessionDate': _toUtcDateOnly(sessionDate).toIso8601String(),
        'startTime': _mergeDateWithTime(
          sessionDate,
          startTime,
        ).toIso8601String(),
        'endTime': _mergeDateWithTime(sessionDate, endTime).toIso8601String(),
        'attendanceMode': attendanceMode,
      },
    );

    final created = _extractData(createResponse);
    final createdId = _toInt(created['id']);
    if (createdId <= 0) {
      throw AppException('Failed to create attendance session.');
    }

    return createdId;
  }

  Map<String, dynamic> _extractData(dynamic response) {
    if (response is Map<String, dynamic>) {
      final data = response['data'];
      if (data is Map<String, dynamic>) {
        return data;
      }
    }

    return <String, dynamic>{};
  }

  List<Map<String, dynamic>> _extractDataList(dynamic response) {
    if (response is Map<String, dynamic>) {
      final data = response['data'];
      if (data is List<dynamic>) {
        return data.whereType<Map<String, dynamic>>().toList();
      }
    }

    return const <Map<String, dynamic>>[];
  }

  DateTime _toUtcDateOnly(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day);
  }

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

  DateTime _toDate(String raw) {
    return DateTime.tryParse(raw) ?? DateTime.now();
  }

  DateTime _mergeDateWithTime(DateTime date, String hhmm) {
    final parts = hhmm.split(':');
    final hour = parts.isNotEmpty ? int.tryParse(parts[0]) ?? 0 : 0;
    final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}

class AttendanceSyncResult {
  const AttendanceSyncResult({
    required this.scheduleSlotId,
    required this.sessionId,
    required this.sessionDate,
    required this.records,
    required this.serverRecords,
  });

  final int scheduleSlotId;
  final int sessionId;
  final DateTime sessionDate;
  final List<Map<String, dynamic>> records;
  final List<Map<String, dynamic>> serverRecords;
}
