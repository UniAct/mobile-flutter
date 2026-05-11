import 'package:drift/drift.dart';

@DataClassName('ScheduleData')
class Schedules extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get universitySlotId => text().unique()();

  IntColumn get courseId => integer()();
  IntColumn get facultyMemberId => integer()();
  IntColumn get semesterId => integer()();

  IntColumn get dayOfWeek => integer()(); // 1=Mon ... 7=Sun
  TextColumn get startTime => text()(); // "HH:mm"
  TextColumn get endTime => text()();

  TextColumn get roomNumber => text().nullable()();
  TextColumn get building => text().nullable()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
