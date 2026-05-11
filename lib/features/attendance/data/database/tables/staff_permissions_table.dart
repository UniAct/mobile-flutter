import 'package:drift/drift.dart';

@TableIndex(name: 'idx_staff_permissions_user', columns: {#userId})
@TableIndex(name: 'idx_staff_permissions_course', columns: {#courseId})
@TableIndex(name: 'idx_staff_permissions_semester', columns: {#semesterId})
class StaffPermissions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer()();
  IntColumn get courseId => integer()();
  IntColumn get semesterId => integer()();

  /// Permission bits: can_edit, can_delete, can_view_reports, can_export
  TextColumn get permissionsJson =>
      text()(); // {"can_edit": true, "can_delete": false, ...}

  TextColumn get deviceId => text().nullable()();
  TextColumn get offlineUuid => text().unique()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get grantedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get revokedAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
