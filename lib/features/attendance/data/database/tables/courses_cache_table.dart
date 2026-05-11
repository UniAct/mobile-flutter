import 'package:drift/drift.dart';

@TableIndex(
  name: 'idx_courses_cache_semester_teacher',
  columns: {#semesterId, #teacherId},
)
class CoursesCaches extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get semesterId => integer()();
  IntColumn get teacherId => integer()();
  TextColumn get cacheKey => text().unique()();

  TextColumn get payloadJson => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  List<Set<Column>> get uniqueKeys => [
    {cacheKey},
  ];
}
