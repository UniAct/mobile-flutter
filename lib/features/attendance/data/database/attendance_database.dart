import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'encrypted_connection.dart';
import 'tables/attendance_table.dart';
import 'tables/sync_queue_table.dart';
import 'tables/courses_cache_table.dart';
import 'tables/students_cache_table.dart';
import 'tables/session_snapshot_table.dart';
import 'tables/student_status_cache_table.dart';
import 'tables/students_table.dart';
import 'tables/courses_table.dart';
import 'tables/schedules_table.dart';
import 'tables/attendance_sessions_table.dart';
import 'tables/staff_permissions_table.dart';
import 'tables/qr_mappings_table.dart';

part 'attendance_database.g.dart';

@DriftDatabase(
  tables: [
    Attendances,
    SyncQueues,
    CoursesCaches,
    StudentsCaches,
    SessionSnapshots,
    StudentAttendanceStatuses,
    Students,
    Courses,
    Schedules,
    AttendanceSessions,
    StaffPermissions,
    QrMappings,
  ],
)
class AttendanceDatabase extends _$AttendanceDatabase {
  AttendanceDatabase._internal(super.e);

  /// Factory constructor to open encrypted database
  ///
  /// Passphrase derived from: SHA256(userId:deviceId:appSalt)
  /// Must be at least 16 characters for AES-256
  static Future<AttendanceDatabase> openEncrypted({
    required String passphrase,
  }) async {
    // Ensure passphrase meets minimum length requirement for SQLCipher
    if (passphrase.length < 16) {
      throw ArgumentError(
        'Encryption passphrase must be at least 16 characters',
      );
    }

    final connection = await EncryptedDatabaseConnection.open(passphrase);
    return AttendanceDatabase._internal(connection.executor);
  }

  /// Open unencrypted (development/debug only)
  static Future<AttendanceDatabase> openUnencrypted() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'attendance_dev.db'));
    return AttendanceDatabase._internal(NativeDatabase(file));
  }

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON;');
        await customStatement('PRAGMA journal_mode = WAL;');
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(sessionSnapshots);
          await m.createTable(studentAttendanceStatuses);
        }
        if (from < 3) {
          // Phase 3: Core SSOT tables
          await m.createTable(students);
          await m.createTable(courses);
          await m.createTable(schedules);
          await m.createTable(attendanceSessions);
          await m.createTable(staffPermissions);
          await m.createTable(qrMappings);

          // Enhance existing tables with new columns
          await m.addColumn(attendances, attendances.deviceId);
          await m.addColumn(attendances, attendances.offlineUuid);
          await m.addColumn(attendances, attendances.isSynced);
          await m.addColumn(attendances, attendances.attendanceSessionId);
          await m.addColumn(attendances, attendances.verificationMethod);
          await m.addColumn(attendances, attendances.verifiedBy);
          await m.addColumn(attendances, attendances.isDeleted);
          await m.addColumn(attendances, attendances.deletedAt);
          await m.addColumn(attendances, attendances.syncedAt);

          await m.addColumn(syncQueues, syncQueues.deviceId);
          await m.addColumn(syncQueues, syncQueues.priority);
          await m.addColumn(syncQueues, syncQueues.durationMs);
          await m.addColumn(syncQueues, syncQueues.nextRetryAt);
        }
      },
    );
  }
}
