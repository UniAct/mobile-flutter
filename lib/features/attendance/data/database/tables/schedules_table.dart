import 'package:drift/drift.dart';

@TableIndex(name: 'idx_schedules_course_day', columns: {#courseId, #dayOfWeek})
@TableIndex(name: 'idx_schedules_slot', columns: {#universitySlotId})
@TableIndex(
  name: 'idx_schedules_faculty',
  columns: {#facultyMemberId, #semesterId},
)
class Schedules extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Slot identifier from university system
  TextColumn get universitySlotId => text().unique()();

  IntColumn get courseId => integer()();
  IntColumn get facultyMemberId => integer()();
  IntColumn get semesterId => integer()();

  IntColumn get dayOfWeek => integer()(); // 1=Mon, 2=Tue...
  TextColumn get startTime => text()(); // "HH:mm" format
  TextColumn get endTime => text()(); // "HH:mm" format

  TextColumn get roomNumber => text().nullable()();
  TextColumn get building => text().nullable()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {universitySlotId},
  ];
}
