import 'package:drift/drift.dart';

@TableIndex(name: 'idx_qr_mappings_student', columns: {#studentId})
@TableIndex(name: 'idx_qr_mappings_active', columns: {#isActive, #expiresAt})
@TableIndex(name: 'idx_qr_mappings_device', columns: {#deviceId})
class QrMappings extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get studentId => integer()();
  TextColumn get qrPayload => text()();
  TextColumn get qrHash => text()(); // SHA256 of payload for quick lookups

  TextColumn get deviceId => text()();
  DateTimeColumn get generatedAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get expiresAt => dateTime()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get lastUsedAt => dateTime().nullable()();
  IntColumn get usageCount => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {qrPayload},
    {qrHash},
  ];
}
