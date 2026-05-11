import 'package:drift/drift.dart';

@TableIndex(name: 'idx_students_qr', columns: {#qrCode})
@TableIndex(
  name: 'idx_students_university_program',
  columns: {#universityId, #programId},
)
class Students extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Unique identifier from university system
  TextColumn get universityStudentId => text().unique()();

  /// QR code payload string (for instant lookup)
  TextColumn get qrCode => text().unique()();

  TextColumn get fullName => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();

  IntColumn get universityId => integer()();
  IntColumn get programId => integer()();
  IntColumn get currentSemester => integer().nullable()();

  TextColumn get deviceId => text().nullable()();
  TextColumn get offlineUuid => text().unique()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  DateTimeColumn get lastSeenAt => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {offlineUuid},
  ];
}
