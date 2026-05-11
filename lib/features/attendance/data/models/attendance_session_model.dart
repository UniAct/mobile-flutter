import 'package:drift/drift.dart';

@DataClassName('AttendanceSessionData')
class AttendanceSessions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get scheduleSlotId => integer()();
  IntColumn get facultyMemberId => integer()();
  DateTimeColumn get sessionDate => dateTime()();

  TextColumn get startTime => text()();
  TextColumn get endTime => text()();
  TextColumn get attendanceMode => text()(); // 'QRCode', 'Manual', 'Biometric'

  RealColumn get actualDuration => real().nullable()();
  TextColumn get notes => text().nullable()();

  TextColumn get offlineUuid => text().unique()();
  TextColumn get deviceId => text().nullable()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  DateTimeColumn get syncedAt => dateTime().nullable()();
}
