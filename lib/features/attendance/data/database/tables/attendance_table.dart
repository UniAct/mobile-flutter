import 'package:drift/drift.dart';

@TableIndex(name: 'idx_attendances_student', columns: {#studentId})
@TableIndex(name: 'idx_attendances_date', columns: {#attendanceDate})
@TableIndex(name: 'idx_attendances_course_session', columns: {#courseId, #sessionId})
@TableIndex(name: 'idx_attendances_pending', columns: {#pendingSync})
@TableIndex(name: 'idx_attendances_session_student', columns: {#attendanceSessionId, #studentId})
@TableIndex(name: 'idx_attendances_offline_uuid', columns: {#offlineUuid})
@TableIndex(name: 'idx_attendances_device_student', columns: {#deviceId, #studentId})
class Attendances extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get studentId => integer()();
  IntColumn get courseId => integer()();
  IntColumn get sessionId => integer()();
  IntColumn get attendanceSessionId => integer().nullable()();

  DateTimeColumn get attendanceDate => dateTime()();
  TextColumn get status => text()(); // 'present', 'absent', 'late', 'excused'

  TextColumn get offlineUuid => text().unique()();
  TextColumn get deviceId => text()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();
  TextColumn get syncError => text().nullable()();

  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  TextColumn get verificationMethod => text().nullable()(); // 'qr', 'manual', 'biometric'
  TextColumn get verifiedBy => text().nullable()(); // staff member ID if manually entered
  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  DateTimeColumn get syncedAt => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {offlineUuid},
        {studentId, attendanceSessionId}, // One attendance per student per session
      ];
}
