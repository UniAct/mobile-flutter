import 'package:drift/drift.dart';

@TableIndex(name: 'idx_students_cache_slot', columns: {#slotContextId})
class StudentsCaches extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get slotContextId => integer()();
  TextColumn get cacheKey => text().unique()();

  TextColumn get payloadJson => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  List<Set<Column>> get uniqueKeys => [
    {cacheKey},
  ];
}
