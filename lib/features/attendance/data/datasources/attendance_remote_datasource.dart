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
    try {
      final queryParams = <String, String>{
        'entity': entityType,
        'limit': limit.toString(),
        if (since != null) 'since': since.toIso8601String(),
      };

      final response = await apiClient.get(
        '/sync/delta?${Uri(queryParameters: queryParams).query}',
        requiresAuth: true,
      );

      final data = response is Map<String, dynamic> ? response['data'] : null;
      if (data is Map<String, dynamic>) {
        final entityData = data[entityType];
        if (entityData is List) {
          return {
            entityType: entityData.whereType<Map<String, dynamic>>().toList(),
          };
        }
      }

      return {entityType: []};
    } on AppException {
      rethrow;
    }
  }

  // ─────────────────────────────────────────────
  // BULK SYNC ENDPOINTS
  // ─────────────────────────────────────────────

  /// Batch create/update attendance records (for delta sync)
  Future<void> syncAttendanceBatch(List<Map<String, dynamic>> records) async {
    try {
      await apiClient.post(
        '/sync/attendance/batch',
        requiresAuth: true,
        body: {'records': records},
      );
    } on AppException {
      rethrow;
    }
  }

  /// Batch sync students (for initial/full sync)
  Future<Map<String, dynamic>> syncStudentsBatch({
    required List<Map<String, dynamic>> students,
    required DateTime lastSync,
  }) async {
    try {
      final response = await apiClient.post(
        '/sync/students/batch',
        requiresAuth: true,
        body: {'students': students, 'lastSync': lastSync.toIso8601String()},
      );

      return response is Map<String, dynamic> ? response : <String, dynamic>{};
    } on AppException {
      rethrow;
    }
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
    try {
      final idsCsv = entityIds.join(',');
      final response = await apiClient.get(
        '/sync/check-conflicts?type=$entityType&ids=$idsCsv',
        requiresAuth: true,
      );

      final data = response is Map<String, dynamic> ? response['data'] : null;
      if (data is Map<String, dynamic>) {
        final conflicts = <String, Map<String, DateTime>>{};
        data.forEach((key, value) {
          if (value is Map<String, dynamic> && value['serverVersion'] != null) {
            conflicts[key] = {
              'server': DateTime.parse(value['serverVersion'].toString()),
              'client':
                  localVersions[entityIds[int.parse(key)]] ?? DateTime.now(),
            };
          }
        });
        return conflicts;
      }

      return <String, Map<String, DateTime>>{};
    } on AppException {
      rethrow;
    }
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
      final payload = {
        'studentId': studentId,
        'attendanceDate': attendanceDate.toIso8601String(),
        'status': status,
        'courseId': courseId,
        'sessionId': sessionId,
      };

      await apiClient.post(
        '/attendance/sync',
        requiresAuth: true,
        body: payload,
      );
    } on AppException {
      rethrow;
    }
  }

  Future<void> executeSyncItem(SyncQueueModel item) async {
    try {
      if (item.actionType == '_sync_meta' || item.actionType == 'delta_sync') {
        debugPrint(
          '[RemoteDataSource] Skipping internal item: ${item.actionType}',
        );
        return;
      }

      final payload = jsonDecode(item.payloadJson);

      switch (item.actionType) {
        case 'manual_batch':
          await _submitManualBatchOnline(payload as Map<String, dynamic>);
          break;

        case 'qr_scan':
          await _submitQrOnline(payload as Map<String, dynamic>);
          break;

        case 'mark_attendance':
          await apiClient.post(
            '/attendance/records',
            requiresAuth: true,
            body: payload,
          );
          break;

        case 'update_attendance':
          await apiClient.put(
            '/attendance/records/${item.entityId}',
            requiresAuth: true,
            body: payload,
          );
          break;

        case 'delete_attendance':
          await apiClient.delete(
            '/attendance/records/${item.entityId}',
            requiresAuth: true,
          );
          break;

        default:
          debugPrint(
            '[RemoteDataSource] Unknown sync action "${item.actionType}" '
            'for item ${item.id}; skipping',
          );
          return;
      }
    } on AppException {
      rethrow;
    }
  }

  Future<void> _submitManualBatchOnline(Map<String, dynamic> payload) async {
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

    await apiClient.post(
      '/attendance/session/$sessionId/attendances',
      requiresAuth: true,
      body: <String, dynamic>{
        'attendanceSessionId': sessionId,
        'records': records,
      },
    );
  }

  Future<void> _submitQrOnline(Map<String, dynamic> payload) async {
    final slotId = _toInt(payload['slotId']);
    final facultyMemberId = _toInt(payload['facultyMemberId']);
    final startTime = (payload['startTime'] ?? '').toString();
    final endTime = (payload['endTime'] ?? '').toString();
    final attendanceMode = (payload['attendanceMode'] ?? 'QRCode').toString();

    final sessionId = await _ensureSession(
      slotId: slotId,
      facultyMemberId: facultyMemberId,
      startTime: startTime,
      endTime: endTime,
      attendanceMode: attendanceMode,
      sessionDateIso: (payload['sessionDate'] ?? '').toString(),
    );

    await apiClient.post(
      '/attendance/session/$sessionId/scan',
      requiresAuth: true,
      body: <String, dynamic>{
        'qrPayload': (payload['qrPayload'] ?? '').toString(),
        'status': (payload['status'] ?? 'present').toString().toLowerCase(),
      },
    );
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
