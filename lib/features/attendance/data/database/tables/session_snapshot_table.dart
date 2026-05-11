import 'package:drift/drift.dart';

@TableIndex(
  name: 'idx_session_slot_date',
  columns: {#scheduleSlotId, #attendanceDate},
)
class SessionSnapshots extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get cacheKey => text().unique()();
  IntColumn get scheduleSlotId => integer()();
  DateTimeColumn get attendanceDate => dateTime()();

  TextColumn get payloadJson => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  List<Set<Column>> get uniqueKeys => [
    {cacheKey},
  ];
}
