import 'package:drift/drift.dart';

@DataClassName('CourseData')
class Courses extends Table {
  IntColumn get id => integer().autoIncrement()();

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
