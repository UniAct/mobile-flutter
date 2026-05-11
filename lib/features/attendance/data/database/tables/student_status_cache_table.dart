import 'package:drift/drift.dart';

class StudentAttendanceStatuses extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get cacheKey => text().unique()();
  IntColumn get studentId => integer()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  List<Set<Column>> get uniqueKeys => [
    {cacheKey},
  ];
}
