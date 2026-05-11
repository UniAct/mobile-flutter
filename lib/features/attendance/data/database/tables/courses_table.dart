import 'package:drift/drift.dart';

@TableIndex(
  name: 'idx_courses_university',
  columns: {#universityId, #courseCode},
)
@TableIndex(
  name: 'idx_courses_program_semester',
  columns: {#programId, #semesterId},
)
class Courses extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Unique course identifier from university system
  TextColumn get universityCourseId => text().unique()();

  TextColumn get courseCode => text()();
  TextColumn get courseName => text()();
  TextColumn get creditHours => text().nullable()();

  IntColumn get universityId => integer()();
  IntColumn get programId => integer()();
  IntColumn get semesterId => integer()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
