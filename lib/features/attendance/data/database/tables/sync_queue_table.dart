import 'package:drift/drift.dart';

@TableIndex(name: 'idx_sync_queues_status', columns: {#syncStatus})
@TableIndex(name: 'idx_sync_queues_created', columns: {#createdAt})
@TableIndex(name: 'idx_sync_queues_entity', columns: {#entityType, #entityId})
@TableIndex(
  name: 'idx_sync_queues_device_priority',
  columns: {#deviceId, #priority},
)
@TableIndex(name: 'idx_sync_queues_next_retry', columns: {#nextRetryAt})
class SyncQueues extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get actionType =>
      text()(); // 'create', 'update', 'delete', 'sync_attendance'
  TextColumn get entityType =>
      text()(); // 'attendance', 'session', 'student', 'qr_mapping'
  IntColumn get entityId => integer()();

  TextColumn get payloadJson => text()();
  IntColumn get priority => integer().withDefault(
    const Constant(0),
  )(); // 0=normal, 1=high, 2=critical

  TextColumn get deviceId => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get syncStatus => text().withDefault(
    const Constant('pending'),
  )(); // 'pending', 'syncing', 'synced', 'failed', 'cancelled'
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get lastRetryAt => dateTime().nullable()();
  DateTimeColumn get nextRetryAt => dateTime().nullable()();
  DateTimeColumn get syncedAt => dateTime().nullable()();

  RealColumn get durationMs => real().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {entityType, entityId, syncStatus}, // Prevent duplicate pending items
  ];
}
