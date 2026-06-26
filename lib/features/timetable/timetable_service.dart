import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile_flutter/core/api/api_client.dart';
import 'package:mobile_flutter/core/storage/local_storage.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';
import 'package:mobile_flutter/features/timetable/timetable_models.dart';

class TimetableService {
  TimetableService({ApiClient? apiClient, LocalStorage? localStorage})
    : _apiClient = apiClient ?? ApiClient(),
      _localStorage = localStorage ?? LocalStorage();

  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  Future<TimetableData> getTimetable() async {
    try {
      final response = await _apiClient.get('/attendance/mobile/timetable');
      final data = _extractData(response);
      return _cacheAndReturn(data);
    } on AppException catch (e) {
      if (_isRouteNotFound(e)) {
        try {
          final fallback = await _getDeployedBackendFallback();
          return _cacheAndReturn(fallback);
        } catch (fallbackError) {
          debugPrint('[TimetableService] Fallback failed: $fallbackError');
        }
      }

      if (e.isNetworkError) {
        final cached = await getCachedTimetable();
        if (cached != null) {
          return cached;
        }

        throw AppException(
          'You are offline and no cached timetable is available yet.',
          isNetworkError: true,
        );
      }
      rethrow;
    } catch (_) {
      final cached = await getCachedTimetable();
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  Future<TimetableData> _cacheAndReturn(Map<String, dynamic> data) async {
    final timetable = TimetableData.fromJson(data);

    try {
      await _localStorage.saveTimetableCache(jsonEncode(data));
    } catch (e) {
      debugPrint('[TimetableService] Cache write failed (non-fatal): $e');
    }

    return timetable;
  }

  Future<Map<String, dynamic>> _getDeployedBackendFallback() async {
    final payload = await _decodeTokenPayload();
    final isStudent = payload['isStudent'] == true;

    if (isStudent) {
      final program = (payload['program'] as Map<String, dynamic>?) ?? {};
      final programLevel =
          (payload['programLevel'] as Map<String, dynamic>?) ?? {};
      final semester = (payload['semester'] as Map<String, dynamic>?) ?? {};
      final programId = _toPositiveInt(program['id']);
      final academicLevel = _toPositiveInt(programLevel['level']);
      final semesterId = _toPositiveInt(semester['id']);
      final facultyId = programId == null
          ? null
          : await _resolveFacultyId(programId);

      if (programId != null &&
          academicLevel != null &&
          semesterId != null &&
          facultyId != null) {
        final response = await _apiClient.get(
          '/schedule?programId=$programId&academicLevel=$academicLevel&facultyId=$facultyId',
          headers: {'semester-id': semesterId.toString()},
        );
        final data = _extractData(response);
        final slots = (data['scheduleSlots'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map((item) => TimetableItem.fromScheduleJson(item))
            .toList();

        return {
          'role': 'student',
          'semesterId': semesterId,
          'timetable': _itemsToJson(slots),
        };
      }
    }

    final dashboardResponse = await _apiClient.get(
      '/attendance/mobile/dashboard',
    );
    final dashboard = _extractData(dashboardResponse);
    final role = (dashboard['role'] ?? (isStudent ? 'student' : 'staff'))
        .toString();
    final dashboardItems =
        (dashboard['todaySchedule'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(
              (item) => TimetableItem.fromDashboardJson(
                item,
                isStudent: role.toLowerCase() == 'student',
              ),
            )
            .toList();

    return {
      'role': role,
      'semesterId': dashboard['semesterId'] ?? 0,
      'timetable': _itemsToJson(dashboardItems),
    };
  }

  Future<int?> _resolveFacultyId(int programId) async {
    final response = await _apiClient.get('/program/$programId');
    final data = _extractData(response);
    final program = (data['program'] as Map<String, dynamic>?) ?? data;
    return _toPositiveInt(program['facultyId']);
  }

  Future<Map<String, dynamic>> _decodeTokenPayload() async {
    final token = await _localStorage.getToken();
    if (token == null || token.isEmpty) {
      return <String, dynamic>{};
    }

    final parts = token.split('.');
    if (parts.length != 3) {
      return <String, dynamic>{};
    }

    final normalized = base64Url.normalize(parts[1]);
    final payload = utf8.decode(base64Url.decode(normalized));
    final decoded = jsonDecode(payload);
    return decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
  }

  List<Map<String, dynamic>> _itemsToJson(List<TimetableItem> items) {
    return items
        .map(
          (item) => {
            'id': item.id,
            'dayOfWeek': item.dayOfWeek,
            'startTime': item.startTime,
            'endTime': item.endTime,
            'type': item.type,
            'registrationStatus': item.registrationStatus,
            'course': {
              'id': item.course.id,
              'code': item.course.code,
              'name': item.course.name,
              'credits': item.course.credits,
            },
            'classroom': item.classroom == null
                ? null
                : {
                    'label': item.classroom!.label,
                    'capacity': item.classroom!.capacity,
                  },
            'teacher': item.teacher == null
                ? null
                : {'name': item.teacher!.name, 'email': item.teacher!.email},
            'programContexts': item.programContexts
                .map(
                  (context) => {
                    'program': {'name': context.programName},
                    'academicLevel': context.academicLevel,
                    'enrolledStudents': context.enrolledStudents,
                  },
                )
                .toList(),
            'allowedCapacity': item.allowedCapacity,
            'enrolledSeats': item.enrolledSeats,
          },
        )
        .toList();
  }

  int? _toPositiveInt(dynamic value) {
    if (value is int && value > 0) {
      return value;
    }

    final parsed = int.tryParse(value?.toString() ?? '');
    return parsed != null && parsed > 0 ? parsed : null;
  }

  bool _isRouteNotFound(AppException exception) {
    final message = exception.message.toLowerCase();
    return exception.statusCode == 404 &&
        message.contains('route') &&
        message.contains('not found');
  }

  Future<TimetableData?> getCachedTimetable() async {
    try {
      final jsonString = await _localStorage.getTimetableCache();
      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }

      final decoded = jsonDecode(jsonString);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }

      return TimetableData.fromJson(decoded);
    } catch (e) {
      debugPrint('[TimetableService] Cache read failed: $e');
      return null;
    }
  }

  Map<String, dynamic> _extractData(dynamic response) {
    if (response is Map<String, dynamic>) {
      final data = response['data'];
      if (data is Map<String, dynamic>) {
        return data;
      }
      return response;
    }

    return <String, dynamic>{};
  }
}
