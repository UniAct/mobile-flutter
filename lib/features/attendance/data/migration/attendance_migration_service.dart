import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:mobile_flutter/features/attendance/data/datasources/attendance_local_datasource.dart';
import 'package:mobile_flutter/features/attendance/data/database/attendance_database.dart';

class AttendanceMigrationService {
  AttendanceMigrationService({
    required this.database,
    required this.localDataSource,
  });

  static const String _migrationFlagKey = 'attendance_legacy_migration_done';
  static const String _legacyDatabaseName = 'uniact_mobile.db';

  final AttendanceDatabase database;
  final AttendanceLocalDataSource localDataSource;

  Future<void> migrateIfNeeded() async {
    await SchedulerBinding.instance.endOfFrame;
    await Future.microtask(() => _runMigration());
  }

  Future<void> _runMigration() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_migrationFlagKey) == true) {
      return;
    }

    final legacyDatabase = await _openLegacyDatabaseIfPresent();
    if (legacyDatabase == null) {
      await prefs.setBool(_migrationFlagKey, true);
      return;
    }

    try {
      await _migrateCaches(legacyDatabase);
      await _migrateStudentStatus(legacyDatabase);
      await _migrateSessionSnapshots(legacyDatabase);
      await _migrateOfflineQueue(legacyDatabase);
      await prefs.setBool(_migrationFlagKey, true);
    } finally {
      await legacyDatabase.close();
    }
  }

  Future<sqflite.Database?> _openLegacyDatabaseIfPresent() async {
    final databasesPath = await sqflite.getDatabasesPath();
    final legacyPath = p.join(databasesPath, _legacyDatabaseName);
    if (!await File(legacyPath).exists()) {
      return null;
    }

    if (!kIsWeb &&
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      databaseFactory = databaseFactoryFfi;
    }

    return sqflite.openDatabase(legacyPath, readOnly: true);
  }

  Future<void> _migrateCaches(sqflite.Database legacyDatabase) async {
    final courseRows = await legacyDatabase.query('attendance_course_cache');
    for (final row in courseRows) {
      final payload = (row['payload'] ?? '[]').toString();
      await localDataSource.saveCoursesCacheJson(
        semesterId: _toInt(row['semester_id']),
        teacherId: _toInt(row['teacher_id']),
        cacheKey: (row['cache_key'] ?? '').toString(),
        payloadJson: payload,
      );
    }

    final rosterRows = await legacyDatabase.query('attendance_roster_cache');
    for (final row in rosterRows) {
      final payload = (row['payload'] ?? '[]').toString();
      await localDataSource.saveStudentsCacheJson(
        slotContextId: _toInt(row['slot_context_id']),
        cacheKey: (row['slot_context_id'] ?? '').toString(),
        payloadJson: payload,
      );
    }
  }

  Future<void> _migrateStudentStatus(sqflite.Database legacyDatabase) async {
    final rows = await legacyDatabase.query('attendance_student_status_cache');
    for (final row in rows) {
      final cacheKey = (row['cache_key'] ?? '').toString();
      final payloadRaw = (row['payload'] ?? '{}').toString();
      final raw = jsonDecode(payloadRaw);
      if (raw is Map<String, dynamic>) {
        await localDataSource.saveStudentAttendanceStatus(
          cacheKey: cacheKey,
          studentId: _toInt(raw['studentId']),
          status: raw,
        );
      }
    }
  }

  Future<void> _migrateSessionSnapshots(sqflite.Database legacyDatabase) async {
    final rows = await legacyDatabase.query('attendance_session_cache');

    for (final row in rows) {
      final payloadRaw = (row['payload'] ?? '{}').toString();
      final raw = jsonDecode(payloadRaw);
      if (raw is! Map<String, dynamic>) {
        continue;
      }

      final scheduleSlotId = _toInt(
        raw['scheduleSlotId'] ?? row['schedule_slot_id'],
      );
      final sessionDate =
          DateTime.tryParse(
            (raw['sessionDate'] ?? row['session_date'] ?? '').toString(),
          ) ??
          DateTime.now();

      final attendance =
          (raw['attendance'] as List<dynamic>? ?? const <dynamic>[])
              .whereType<Map<String, dynamic>>()
              .toList();

      for (final item in attendance) {
        final studentId = _toInt(item['studentId']);
        if (studentId <= 0) {
          continue;
        }

        await localDataSource.saveAttendance(
          studentId: studentId,
          attendanceDate: sessionDate,
          status: (item['status'] ?? 'absent').toString(),
          courseId: scheduleSlotId,
          sessionId: scheduleSlotId,
        );
      }

      await localDataSource.saveSessionSnapshot(
        scheduleSlotId: scheduleSlotId,
        attendanceDate: sessionDate,
        session: raw,
      );
    }
  }

  Future<void> _migrateOfflineQueue(sqflite.Database legacyDatabase) async {
    final rows = await legacyDatabase.query(
      'offline_attendance_queue',
      orderBy: 'id ASC',
    );
    for (final row in rows) {
      final payloadRaw = (row['payload'] ?? '{}').toString();
      final raw = jsonDecode(payloadRaw);
      if (raw is! Map<String, dynamic>) {
        continue;
      }

      await localDataSource.enqueueSyncItem(
        actionType: (row['action_type'] ?? '').toString(),
        entityType: 'attendance_session',
        entityId: _toInt(raw['slotId'] ?? 0),
        payload: raw,
      );
    }
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
}
