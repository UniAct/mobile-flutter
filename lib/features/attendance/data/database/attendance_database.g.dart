// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_database.dart';

// ignore_for_file: type=lint
class $AttendancesTable extends Attendances
    with TableInfo<$AttendancesTable, Attendance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseIdMeta = const VerificationMeta(
    'courseId',
  );
  @override
  late final GeneratedColumn<int> courseId = GeneratedColumn<int>(
    'course_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attendanceSessionIdMeta =
      const VerificationMeta('attendanceSessionId');
  @override
  late final GeneratedColumn<int> attendanceSessionId = GeneratedColumn<int>(
    'attendance_session_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attendanceDateMeta = const VerificationMeta(
    'attendanceDate',
  );
  @override
  late final GeneratedColumn<DateTime> attendanceDate =
      GeneratedColumn<DateTime>(
        'attendance_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _offlineUuidMeta = const VerificationMeta(
    'offlineUuid',
  );
  @override
  late final GeneratedColumn<String> offlineUuid = GeneratedColumn<String>(
    'offline_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _syncErrorMeta = const VerificationMeta(
    'syncError',
  );
  @override
  late final GeneratedColumn<String> syncError = GeneratedColumn<String>(
    'sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _verificationMethodMeta =
      const VerificationMeta('verificationMethod');
  @override
  late final GeneratedColumn<String> verificationMethod =
      GeneratedColumn<String>(
        'verification_method',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _verifiedByMeta = const VerificationMeta(
    'verifiedBy',
  );
  @override
  late final GeneratedColumn<String> verifiedBy = GeneratedColumn<String>(
    'verified_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    courseId,
    sessionId,
    attendanceSessionId,
    attendanceDate,
    status,
    offlineUuid,
    deviceId,
    isSynced,
    pendingSync,
    syncError,
    isDeleted,
    verificationMethod,
    verifiedBy,
    notes,
    createdAt,
    updatedAt,
    deletedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendances';
  @override
  VerificationContext validateIntegrity(
    Insertable<Attendance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('attendance_session_id')) {
      context.handle(
        _attendanceSessionIdMeta,
        attendanceSessionId.isAcceptableOrUnknown(
          data['attendance_session_id']!,
          _attendanceSessionIdMeta,
        ),
      );
    }
    if (data.containsKey('attendance_date')) {
      context.handle(
        _attendanceDateMeta,
        attendanceDate.isAcceptableOrUnknown(
          data['attendance_date']!,
          _attendanceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attendanceDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('offline_uuid')) {
      context.handle(
        _offlineUuidMeta,
        offlineUuid.isAcceptableOrUnknown(
          data['offline_uuid']!,
          _offlineUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_offlineUuidMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    if (data.containsKey('sync_error')) {
      context.handle(
        _syncErrorMeta,
        syncError.isAcceptableOrUnknown(data['sync_error']!, _syncErrorMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('verification_method')) {
      context.handle(
        _verificationMethodMeta,
        verificationMethod.isAcceptableOrUnknown(
          data['verification_method']!,
          _verificationMethodMeta,
        ),
      );
    }
    if (data.containsKey('verified_by')) {
      context.handle(
        _verifiedByMeta,
        verifiedBy.isAcceptableOrUnknown(data['verified_by']!, _verifiedByMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {offlineUuid},
    {studentId, attendanceSessionId},
  ];
  @override
  Attendance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attendance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      courseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      attendanceSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attendance_session_id'],
      ),
      attendanceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}attendance_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      offlineUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}offline_uuid'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
      syncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_error'],
      ),
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      verificationMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verification_method'],
      ),
      verifiedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verified_by'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $AttendancesTable createAlias(String alias) {
    return $AttendancesTable(attachedDatabase, alias);
  }
}

class Attendance extends DataClass implements Insertable<Attendance> {
  final int id;
  final int studentId;
  final int courseId;
  final int sessionId;
  final int? attendanceSessionId;
  final DateTime attendanceDate;
  final String status;
  final String offlineUuid;
  final String deviceId;
  final bool isSynced;
  final bool pendingSync;
  final String? syncError;
  final bool isDeleted;
  final String? verificationMethod;
  final String? verifiedBy;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final DateTime? syncedAt;
  const Attendance({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.sessionId,
    this.attendanceSessionId,
    required this.attendanceDate,
    required this.status,
    required this.offlineUuid,
    required this.deviceId,
    required this.isSynced,
    required this.pendingSync,
    this.syncError,
    required this.isDeleted,
    this.verificationMethod,
    this.verifiedBy,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['course_id'] = Variable<int>(courseId);
    map['session_id'] = Variable<int>(sessionId);
    if (!nullToAbsent || attendanceSessionId != null) {
      map['attendance_session_id'] = Variable<int>(attendanceSessionId);
    }
    map['attendance_date'] = Variable<DateTime>(attendanceDate);
    map['status'] = Variable<String>(status);
    map['offline_uuid'] = Variable<String>(offlineUuid);
    map['device_id'] = Variable<String>(deviceId);
    map['is_synced'] = Variable<bool>(isSynced);
    map['pending_sync'] = Variable<bool>(pendingSync);
    if (!nullToAbsent || syncError != null) {
      map['sync_error'] = Variable<String>(syncError);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || verificationMethod != null) {
      map['verification_method'] = Variable<String>(verificationMethod);
    }
    if (!nullToAbsent || verifiedBy != null) {
      map['verified_by'] = Variable<String>(verifiedBy);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  AttendancesCompanion toCompanion(bool nullToAbsent) {
    return AttendancesCompanion(
      id: Value(id),
      studentId: Value(studentId),
      courseId: Value(courseId),
      sessionId: Value(sessionId),
      attendanceSessionId: attendanceSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(attendanceSessionId),
      attendanceDate: Value(attendanceDate),
      status: Value(status),
      offlineUuid: Value(offlineUuid),
      deviceId: Value(deviceId),
      isSynced: Value(isSynced),
      pendingSync: Value(pendingSync),
      syncError: syncError == null && nullToAbsent
          ? const Value.absent()
          : Value(syncError),
      isDeleted: Value(isDeleted),
      verificationMethod: verificationMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(verificationMethod),
      verifiedBy: verifiedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(verifiedBy),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory Attendance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attendance(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      courseId: serializer.fromJson<int>(json['courseId']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      attendanceSessionId: serializer.fromJson<int?>(
        json['attendanceSessionId'],
      ),
      attendanceDate: serializer.fromJson<DateTime>(json['attendanceDate']),
      status: serializer.fromJson<String>(json['status']),
      offlineUuid: serializer.fromJson<String>(json['offlineUuid']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
      syncError: serializer.fromJson<String?>(json['syncError']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      verificationMethod: serializer.fromJson<String?>(
        json['verificationMethod'],
      ),
      verifiedBy: serializer.fromJson<String?>(json['verifiedBy']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'courseId': serializer.toJson<int>(courseId),
      'sessionId': serializer.toJson<int>(sessionId),
      'attendanceSessionId': serializer.toJson<int?>(attendanceSessionId),
      'attendanceDate': serializer.toJson<DateTime>(attendanceDate),
      'status': serializer.toJson<String>(status),
      'offlineUuid': serializer.toJson<String>(offlineUuid),
      'deviceId': serializer.toJson<String>(deviceId),
      'isSynced': serializer.toJson<bool>(isSynced),
      'pendingSync': serializer.toJson<bool>(pendingSync),
      'syncError': serializer.toJson<String?>(syncError),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'verificationMethod': serializer.toJson<String?>(verificationMethod),
      'verifiedBy': serializer.toJson<String?>(verifiedBy),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  Attendance copyWith({
    int? id,
    int? studentId,
    int? courseId,
    int? sessionId,
    Value<int?> attendanceSessionId = const Value.absent(),
    DateTime? attendanceDate,
    String? status,
    String? offlineUuid,
    String? deviceId,
    bool? isSynced,
    bool? pendingSync,
    Value<String?> syncError = const Value.absent(),
    bool? isDeleted,
    Value<String?> verificationMethod = const Value.absent(),
    Value<String?> verifiedBy = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => Attendance(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    courseId: courseId ?? this.courseId,
    sessionId: sessionId ?? this.sessionId,
    attendanceSessionId: attendanceSessionId.present
        ? attendanceSessionId.value
        : this.attendanceSessionId,
    attendanceDate: attendanceDate ?? this.attendanceDate,
    status: status ?? this.status,
    offlineUuid: offlineUuid ?? this.offlineUuid,
    deviceId: deviceId ?? this.deviceId,
    isSynced: isSynced ?? this.isSynced,
    pendingSync: pendingSync ?? this.pendingSync,
    syncError: syncError.present ? syncError.value : this.syncError,
    isDeleted: isDeleted ?? this.isDeleted,
    verificationMethod: verificationMethod.present
        ? verificationMethod.value
        : this.verificationMethod,
    verifiedBy: verifiedBy.present ? verifiedBy.value : this.verifiedBy,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  Attendance copyWithCompanion(AttendancesCompanion data) {
    return Attendance(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      attendanceSessionId: data.attendanceSessionId.present
          ? data.attendanceSessionId.value
          : this.attendanceSessionId,
      attendanceDate: data.attendanceDate.present
          ? data.attendanceDate.value
          : this.attendanceDate,
      status: data.status.present ? data.status.value : this.status,
      offlineUuid: data.offlineUuid.present
          ? data.offlineUuid.value
          : this.offlineUuid,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
      syncError: data.syncError.present ? data.syncError.value : this.syncError,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      verificationMethod: data.verificationMethod.present
          ? data.verificationMethod.value
          : this.verificationMethod,
      verifiedBy: data.verifiedBy.present
          ? data.verifiedBy.value
          : this.verifiedBy,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attendance(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('courseId: $courseId, ')
          ..write('sessionId: $sessionId, ')
          ..write('attendanceSessionId: $attendanceSessionId, ')
          ..write('attendanceDate: $attendanceDate, ')
          ..write('status: $status, ')
          ..write('offlineUuid: $offlineUuid, ')
          ..write('deviceId: $deviceId, ')
          ..write('isSynced: $isSynced, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('syncError: $syncError, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('verificationMethod: $verificationMethod, ')
          ..write('verifiedBy: $verifiedBy, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    courseId,
    sessionId,
    attendanceSessionId,
    attendanceDate,
    status,
    offlineUuid,
    deviceId,
    isSynced,
    pendingSync,
    syncError,
    isDeleted,
    verificationMethod,
    verifiedBy,
    notes,
    createdAt,
    updatedAt,
    deletedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attendance &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.courseId == this.courseId &&
          other.sessionId == this.sessionId &&
          other.attendanceSessionId == this.attendanceSessionId &&
          other.attendanceDate == this.attendanceDate &&
          other.status == this.status &&
          other.offlineUuid == this.offlineUuid &&
          other.deviceId == this.deviceId &&
          other.isSynced == this.isSynced &&
          other.pendingSync == this.pendingSync &&
          other.syncError == this.syncError &&
          other.isDeleted == this.isDeleted &&
          other.verificationMethod == this.verificationMethod &&
          other.verifiedBy == this.verifiedBy &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncedAt == this.syncedAt);
}

class AttendancesCompanion extends UpdateCompanion<Attendance> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> courseId;
  final Value<int> sessionId;
  final Value<int?> attendanceSessionId;
  final Value<DateTime> attendanceDate;
  final Value<String> status;
  final Value<String> offlineUuid;
  final Value<String> deviceId;
  final Value<bool> isSynced;
  final Value<bool> pendingSync;
  final Value<String?> syncError;
  final Value<bool> isDeleted;
  final Value<String?> verificationMethod;
  final Value<String?> verifiedBy;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<DateTime?> syncedAt;
  const AttendancesCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.courseId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.attendanceSessionId = const Value.absent(),
    this.attendanceDate = const Value.absent(),
    this.status = const Value.absent(),
    this.offlineUuid = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.syncError = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.verificationMethod = const Value.absent(),
    this.verifiedBy = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  AttendancesCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int courseId,
    required int sessionId,
    this.attendanceSessionId = const Value.absent(),
    required DateTime attendanceDate,
    required String status,
    required String offlineUuid,
    required String deviceId,
    this.isSynced = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.syncError = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.verificationMethod = const Value.absent(),
    this.verifiedBy = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  }) : studentId = Value(studentId),
       courseId = Value(courseId),
       sessionId = Value(sessionId),
       attendanceDate = Value(attendanceDate),
       status = Value(status),
       offlineUuid = Value(offlineUuid),
       deviceId = Value(deviceId);
  static Insertable<Attendance> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? courseId,
    Expression<int>? sessionId,
    Expression<int>? attendanceSessionId,
    Expression<DateTime>? attendanceDate,
    Expression<String>? status,
    Expression<String>? offlineUuid,
    Expression<String>? deviceId,
    Expression<bool>? isSynced,
    Expression<bool>? pendingSync,
    Expression<String>? syncError,
    Expression<bool>? isDeleted,
    Expression<String>? verificationMethod,
    Expression<String>? verifiedBy,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (courseId != null) 'course_id': courseId,
      if (sessionId != null) 'session_id': sessionId,
      if (attendanceSessionId != null)
        'attendance_session_id': attendanceSessionId,
      if (attendanceDate != null) 'attendance_date': attendanceDate,
      if (status != null) 'status': status,
      if (offlineUuid != null) 'offline_uuid': offlineUuid,
      if (deviceId != null) 'device_id': deviceId,
      if (isSynced != null) 'is_synced': isSynced,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (syncError != null) 'sync_error': syncError,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (verificationMethod != null) 'verification_method': verificationMethod,
      if (verifiedBy != null) 'verified_by': verifiedBy,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  AttendancesCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<int>? courseId,
    Value<int>? sessionId,
    Value<int?>? attendanceSessionId,
    Value<DateTime>? attendanceDate,
    Value<String>? status,
    Value<String>? offlineUuid,
    Value<String>? deviceId,
    Value<bool>? isSynced,
    Value<bool>? pendingSync,
    Value<String?>? syncError,
    Value<bool>? isDeleted,
    Value<String?>? verificationMethod,
    Value<String?>? verifiedBy,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<DateTime?>? syncedAt,
  }) {
    return AttendancesCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      courseId: courseId ?? this.courseId,
      sessionId: sessionId ?? this.sessionId,
      attendanceSessionId: attendanceSessionId ?? this.attendanceSessionId,
      attendanceDate: attendanceDate ?? this.attendanceDate,
      status: status ?? this.status,
      offlineUuid: offlineUuid ?? this.offlineUuid,
      deviceId: deviceId ?? this.deviceId,
      isSynced: isSynced ?? this.isSynced,
      pendingSync: pendingSync ?? this.pendingSync,
      syncError: syncError ?? this.syncError,
      isDeleted: isDeleted ?? this.isDeleted,
      verificationMethod: verificationMethod ?? this.verificationMethod,
      verifiedBy: verifiedBy ?? this.verifiedBy,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<int>(courseId.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (attendanceSessionId.present) {
      map['attendance_session_id'] = Variable<int>(attendanceSessionId.value);
    }
    if (attendanceDate.present) {
      map['attendance_date'] = Variable<DateTime>(attendanceDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (offlineUuid.present) {
      map['offline_uuid'] = Variable<String>(offlineUuid.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (syncError.present) {
      map['sync_error'] = Variable<String>(syncError.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (verificationMethod.present) {
      map['verification_method'] = Variable<String>(verificationMethod.value);
    }
    if (verifiedBy.present) {
      map['verified_by'] = Variable<String>(verifiedBy.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendancesCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('courseId: $courseId, ')
          ..write('sessionId: $sessionId, ')
          ..write('attendanceSessionId: $attendanceSessionId, ')
          ..write('attendanceDate: $attendanceDate, ')
          ..write('status: $status, ')
          ..write('offlineUuid: $offlineUuid, ')
          ..write('deviceId: $deviceId, ')
          ..write('isSynced: $isSynced, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('syncError: $syncError, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('verificationMethod: $verificationMethod, ')
          ..write('verifiedBy: $verifiedBy, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncQueuesTable extends SyncQueues
    with TableInfo<$SyncQueuesTable, SyncQueue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _actionTypeMeta = const VerificationMeta(
    'actionType',
  );
  @override
  late final GeneratedColumn<String> actionType = GeneratedColumn<String>(
    'action_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastRetryAtMeta = const VerificationMeta(
    'lastRetryAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastRetryAt = GeneratedColumn<DateTime>(
    'last_retry_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextRetryAtMeta = const VerificationMeta(
    'nextRetryAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextRetryAt = GeneratedColumn<DateTime>(
    'next_retry_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<double> durationMs = GeneratedColumn<double>(
    'duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    actionType,
    entityType,
    entityId,
    payloadJson,
    priority,
    deviceId,
    createdAt,
    updatedAt,
    syncStatus,
    retryCount,
    lastError,
    lastRetryAt,
    nextRetryAt,
    syncedAt,
    durationMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queues';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('action_type')) {
      context.handle(
        _actionTypeMeta,
        actionType.isAcceptableOrUnknown(data['action_type']!, _actionTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_actionTypeMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('last_retry_at')) {
      context.handle(
        _lastRetryAtMeta,
        lastRetryAt.isAcceptableOrUnknown(
          data['last_retry_at']!,
          _lastRetryAtMeta,
        ),
      );
    }
    if (data.containsKey('next_retry_at')) {
      context.handle(
        _nextRetryAtMeta,
        nextRetryAt.isAcceptableOrUnknown(
          data['next_retry_at']!,
          _nextRetryAtMeta,
        ),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {entityType, entityId, syncStatus},
  ];
  @override
  SyncQueue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueue(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      actionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_type'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entity_id'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      lastRetryAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_retry_at'],
      ),
      nextRetryAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_retry_at'],
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}duration_ms'],
      ),
    );
  }

  @override
  $SyncQueuesTable createAlias(String alias) {
    return $SyncQueuesTable(attachedDatabase, alias);
  }
}

class SyncQueue extends DataClass implements Insertable<SyncQueue> {
  final int id;
  final String actionType;
  final String entityType;
  final int entityId;
  final String payloadJson;
  final int priority;
  final String deviceId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final int retryCount;
  final String? lastError;
  final DateTime? lastRetryAt;
  final DateTime? nextRetryAt;
  final DateTime? syncedAt;
  final double? durationMs;
  const SyncQueue({
    required this.id,
    required this.actionType,
    required this.entityType,
    required this.entityId,
    required this.payloadJson,
    required this.priority,
    required this.deviceId,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.retryCount,
    this.lastError,
    this.lastRetryAt,
    this.nextRetryAt,
    this.syncedAt,
    this.durationMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['action_type'] = Variable<String>(actionType);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<int>(entityId);
    map['payload_json'] = Variable<String>(payloadJson);
    map['priority'] = Variable<int>(priority);
    map['device_id'] = Variable<String>(deviceId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    if (!nullToAbsent || lastRetryAt != null) {
      map['last_retry_at'] = Variable<DateTime>(lastRetryAt);
    }
    if (!nullToAbsent || nextRetryAt != null) {
      map['next_retry_at'] = Variable<DateTime>(nextRetryAt);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<double>(durationMs);
    }
    return map;
  }

  SyncQueuesCompanion toCompanion(bool nullToAbsent) {
    return SyncQueuesCompanion(
      id: Value(id),
      actionType: Value(actionType),
      entityType: Value(entityType),
      entityId: Value(entityId),
      payloadJson: Value(payloadJson),
      priority: Value(priority),
      deviceId: Value(deviceId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      lastRetryAt: lastRetryAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRetryAt),
      nextRetryAt: nextRetryAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextRetryAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
    );
  }

  factory SyncQueue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueue(
      id: serializer.fromJson<int>(json['id']),
      actionType: serializer.fromJson<String>(json['actionType']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<int>(json['entityId']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      priority: serializer.fromJson<int>(json['priority']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      lastRetryAt: serializer.fromJson<DateTime?>(json['lastRetryAt']),
      nextRetryAt: serializer.fromJson<DateTime?>(json['nextRetryAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      durationMs: serializer.fromJson<double?>(json['durationMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'actionType': serializer.toJson<String>(actionType),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<int>(entityId),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'priority': serializer.toJson<int>(priority),
      'deviceId': serializer.toJson<String>(deviceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
      'lastRetryAt': serializer.toJson<DateTime?>(lastRetryAt),
      'nextRetryAt': serializer.toJson<DateTime?>(nextRetryAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'durationMs': serializer.toJson<double?>(durationMs),
    };
  }

  SyncQueue copyWith({
    int? id,
    String? actionType,
    String? entityType,
    int? entityId,
    String? payloadJson,
    int? priority,
    String? deviceId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
    Value<DateTime?> lastRetryAt = const Value.absent(),
    Value<DateTime?> nextRetryAt = const Value.absent(),
    Value<DateTime?> syncedAt = const Value.absent(),
    Value<double?> durationMs = const Value.absent(),
  }) => SyncQueue(
    id: id ?? this.id,
    actionType: actionType ?? this.actionType,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    payloadJson: payloadJson ?? this.payloadJson,
    priority: priority ?? this.priority,
    deviceId: deviceId ?? this.deviceId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    lastRetryAt: lastRetryAt.present ? lastRetryAt.value : this.lastRetryAt,
    nextRetryAt: nextRetryAt.present ? nextRetryAt.value : this.nextRetryAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
    durationMs: durationMs.present ? durationMs.value : this.durationMs,
  );
  SyncQueue copyWithCompanion(SyncQueuesCompanion data) {
    return SyncQueue(
      id: data.id.present ? data.id.value : this.id,
      actionType: data.actionType.present
          ? data.actionType.value
          : this.actionType,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      priority: data.priority.present ? data.priority.value : this.priority,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      lastRetryAt: data.lastRetryAt.present
          ? data.lastRetryAt.value
          : this.lastRetryAt,
      nextRetryAt: data.nextRetryAt.present
          ? data.nextRetryAt.value
          : this.nextRetryAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueue(')
          ..write('id: $id, ')
          ..write('actionType: $actionType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('priority: $priority, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('lastRetryAt: $lastRetryAt, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('durationMs: $durationMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    actionType,
    entityType,
    entityId,
    payloadJson,
    priority,
    deviceId,
    createdAt,
    updatedAt,
    syncStatus,
    retryCount,
    lastError,
    lastRetryAt,
    nextRetryAt,
    syncedAt,
    durationMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueue &&
          other.id == this.id &&
          other.actionType == this.actionType &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.payloadJson == this.payloadJson &&
          other.priority == this.priority &&
          other.deviceId == this.deviceId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError &&
          other.lastRetryAt == this.lastRetryAt &&
          other.nextRetryAt == this.nextRetryAt &&
          other.syncedAt == this.syncedAt &&
          other.durationMs == this.durationMs);
}

class SyncQueuesCompanion extends UpdateCompanion<SyncQueue> {
  final Value<int> id;
  final Value<String> actionType;
  final Value<String> entityType;
  final Value<int> entityId;
  final Value<String> payloadJson;
  final Value<int> priority;
  final Value<String> deviceId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<DateTime?> lastRetryAt;
  final Value<DateTime?> nextRetryAt;
  final Value<DateTime?> syncedAt;
  final Value<double?> durationMs;
  const SyncQueuesCompanion({
    this.id = const Value.absent(),
    this.actionType = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.priority = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastRetryAt = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.durationMs = const Value.absent(),
  });
  SyncQueuesCompanion.insert({
    this.id = const Value.absent(),
    required String actionType,
    required String entityType,
    required int entityId,
    required String payloadJson,
    this.priority = const Value.absent(),
    required String deviceId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastRetryAt = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.durationMs = const Value.absent(),
  }) : actionType = Value(actionType),
       entityType = Value(entityType),
       entityId = Value(entityId),
       payloadJson = Value(payloadJson),
       deviceId = Value(deviceId);
  static Insertable<SyncQueue> custom({
    Expression<int>? id,
    Expression<String>? actionType,
    Expression<String>? entityType,
    Expression<int>? entityId,
    Expression<String>? payloadJson,
    Expression<int>? priority,
    Expression<String>? deviceId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<DateTime>? lastRetryAt,
    Expression<DateTime>? nextRetryAt,
    Expression<DateTime>? syncedAt,
    Expression<double>? durationMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (actionType != null) 'action_type': actionType,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (priority != null) 'priority': priority,
      if (deviceId != null) 'device_id': deviceId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (lastRetryAt != null) 'last_retry_at': lastRetryAt,
      if (nextRetryAt != null) 'next_retry_at': nextRetryAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (durationMs != null) 'duration_ms': durationMs,
    });
  }

  SyncQueuesCompanion copyWith({
    Value<int>? id,
    Value<String>? actionType,
    Value<String>? entityType,
    Value<int>? entityId,
    Value<String>? payloadJson,
    Value<int>? priority,
    Value<String>? deviceId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<DateTime?>? lastRetryAt,
    Value<DateTime?>? nextRetryAt,
    Value<DateTime?>? syncedAt,
    Value<double?>? durationMs,
  }) {
    return SyncQueuesCompanion(
      id: id ?? this.id,
      actionType: actionType ?? this.actionType,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      payloadJson: payloadJson ?? this.payloadJson,
      priority: priority ?? this.priority,
      deviceId: deviceId ?? this.deviceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      lastRetryAt: lastRetryAt ?? this.lastRetryAt,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
      syncedAt: syncedAt ?? this.syncedAt,
      durationMs: durationMs ?? this.durationMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (actionType.present) {
      map['action_type'] = Variable<String>(actionType.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (lastRetryAt.present) {
      map['last_retry_at'] = Variable<DateTime>(lastRetryAt.value);
    }
    if (nextRetryAt.present) {
      map['next_retry_at'] = Variable<DateTime>(nextRetryAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<double>(durationMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueuesCompanion(')
          ..write('id: $id, ')
          ..write('actionType: $actionType, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('priority: $priority, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('lastRetryAt: $lastRetryAt, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('durationMs: $durationMs')
          ..write(')'))
        .toString();
  }
}

class $CoursesCachesTable extends CoursesCaches
    with TableInfo<$CoursesCachesTable, CoursesCache> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesCachesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _semesterIdMeta = const VerificationMeta(
    'semesterId',
  );
  @override
  late final GeneratedColumn<int> semesterId = GeneratedColumn<int>(
    'semester_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teacherIdMeta = const VerificationMeta(
    'teacherId',
  );
  @override
  late final GeneratedColumn<int> teacherId = GeneratedColumn<int>(
    'teacher_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cacheKeyMeta = const VerificationMeta(
    'cacheKey',
  );
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
    'cache_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    semesterId,
    teacherId,
    cacheKey,
    payloadJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses_caches';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoursesCache> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('semester_id')) {
      context.handle(
        _semesterIdMeta,
        semesterId.isAcceptableOrUnknown(data['semester_id']!, _semesterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_semesterIdMeta);
    }
    if (data.containsKey('teacher_id')) {
      context.handle(
        _teacherIdMeta,
        teacherId.isAcceptableOrUnknown(data['teacher_id']!, _teacherIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teacherIdMeta);
    }
    if (data.containsKey('cache_key')) {
      context.handle(
        _cacheKeyMeta,
        cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {cacheKey},
  ];
  @override
  CoursesCache map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoursesCache(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      semesterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}semester_id'],
      )!,
      teacherId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}teacher_id'],
      )!,
      cacheKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cache_key'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CoursesCachesTable createAlias(String alias) {
    return $CoursesCachesTable(attachedDatabase, alias);
  }
}

class CoursesCache extends DataClass implements Insertable<CoursesCache> {
  final int id;
  final int semesterId;
  final int teacherId;
  final String cacheKey;
  final String payloadJson;
  final DateTime updatedAt;
  const CoursesCache({
    required this.id,
    required this.semesterId,
    required this.teacherId,
    required this.cacheKey,
    required this.payloadJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['semester_id'] = Variable<int>(semesterId);
    map['teacher_id'] = Variable<int>(teacherId);
    map['cache_key'] = Variable<String>(cacheKey);
    map['payload_json'] = Variable<String>(payloadJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CoursesCachesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCachesCompanion(
      id: Value(id),
      semesterId: Value(semesterId),
      teacherId: Value(teacherId),
      cacheKey: Value(cacheKey),
      payloadJson: Value(payloadJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory CoursesCache.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoursesCache(
      id: serializer.fromJson<int>(json['id']),
      semesterId: serializer.fromJson<int>(json['semesterId']),
      teacherId: serializer.fromJson<int>(json['teacherId']),
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'semesterId': serializer.toJson<int>(semesterId),
      'teacherId': serializer.toJson<int>(teacherId),
      'cacheKey': serializer.toJson<String>(cacheKey),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CoursesCache copyWith({
    int? id,
    int? semesterId,
    int? teacherId,
    String? cacheKey,
    String? payloadJson,
    DateTime? updatedAt,
  }) => CoursesCache(
    id: id ?? this.id,
    semesterId: semesterId ?? this.semesterId,
    teacherId: teacherId ?? this.teacherId,
    cacheKey: cacheKey ?? this.cacheKey,
    payloadJson: payloadJson ?? this.payloadJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CoursesCache copyWithCompanion(CoursesCachesCompanion data) {
    return CoursesCache(
      id: data.id.present ? data.id.value : this.id,
      semesterId: data.semesterId.present
          ? data.semesterId.value
          : this.semesterId,
      teacherId: data.teacherId.present ? data.teacherId.value : this.teacherId,
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCache(')
          ..write('id: $id, ')
          ..write('semesterId: $semesterId, ')
          ..write('teacherId: $teacherId, ')
          ..write('cacheKey: $cacheKey, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, semesterId, teacherId, cacheKey, payloadJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoursesCache &&
          other.id == this.id &&
          other.semesterId == this.semesterId &&
          other.teacherId == this.teacherId &&
          other.cacheKey == this.cacheKey &&
          other.payloadJson == this.payloadJson &&
          other.updatedAt == this.updatedAt);
}

class CoursesCachesCompanion extends UpdateCompanion<CoursesCache> {
  final Value<int> id;
  final Value<int> semesterId;
  final Value<int> teacherId;
  final Value<String> cacheKey;
  final Value<String> payloadJson;
  final Value<DateTime> updatedAt;
  const CoursesCachesCompanion({
    this.id = const Value.absent(),
    this.semesterId = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.cacheKey = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CoursesCachesCompanion.insert({
    this.id = const Value.absent(),
    required int semesterId,
    required int teacherId,
    required String cacheKey,
    required String payloadJson,
    this.updatedAt = const Value.absent(),
  }) : semesterId = Value(semesterId),
       teacherId = Value(teacherId),
       cacheKey = Value(cacheKey),
       payloadJson = Value(payloadJson);
  static Insertable<CoursesCache> custom({
    Expression<int>? id,
    Expression<int>? semesterId,
    Expression<int>? teacherId,
    Expression<String>? cacheKey,
    Expression<String>? payloadJson,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (semesterId != null) 'semester_id': semesterId,
      if (teacherId != null) 'teacher_id': teacherId,
      if (cacheKey != null) 'cache_key': cacheKey,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CoursesCachesCompanion copyWith({
    Value<int>? id,
    Value<int>? semesterId,
    Value<int>? teacherId,
    Value<String>? cacheKey,
    Value<String>? payloadJson,
    Value<DateTime>? updatedAt,
  }) {
    return CoursesCachesCompanion(
      id: id ?? this.id,
      semesterId: semesterId ?? this.semesterId,
      teacherId: teacherId ?? this.teacherId,
      cacheKey: cacheKey ?? this.cacheKey,
      payloadJson: payloadJson ?? this.payloadJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (semesterId.present) {
      map['semester_id'] = Variable<int>(semesterId.value);
    }
    if (teacherId.present) {
      map['teacher_id'] = Variable<int>(teacherId.value);
    }
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCachesCompanion(')
          ..write('id: $id, ')
          ..write('semesterId: $semesterId, ')
          ..write('teacherId: $teacherId, ')
          ..write('cacheKey: $cacheKey, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StudentsCachesTable extends StudentsCaches
    with TableInfo<$StudentsCachesTable, StudentsCache> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsCachesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _slotContextIdMeta = const VerificationMeta(
    'slotContextId',
  );
  @override
  late final GeneratedColumn<int> slotContextId = GeneratedColumn<int>(
    'slot_context_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cacheKeyMeta = const VerificationMeta(
    'cacheKey',
  );
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
    'cache_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slotContextId,
    cacheKey,
    payloadJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students_caches';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentsCache> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slot_context_id')) {
      context.handle(
        _slotContextIdMeta,
        slotContextId.isAcceptableOrUnknown(
          data['slot_context_id']!,
          _slotContextIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_slotContextIdMeta);
    }
    if (data.containsKey('cache_key')) {
      context.handle(
        _cacheKeyMeta,
        cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {cacheKey},
  ];
  @override
  StudentsCache map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentsCache(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slotContextId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot_context_id'],
      )!,
      cacheKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cache_key'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StudentsCachesTable createAlias(String alias) {
    return $StudentsCachesTable(attachedDatabase, alias);
  }
}

class StudentsCache extends DataClass implements Insertable<StudentsCache> {
  final int id;
  final int slotContextId;
  final String cacheKey;
  final String payloadJson;
  final DateTime updatedAt;
  const StudentsCache({
    required this.id,
    required this.slotContextId,
    required this.cacheKey,
    required this.payloadJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slot_context_id'] = Variable<int>(slotContextId);
    map['cache_key'] = Variable<String>(cacheKey);
    map['payload_json'] = Variable<String>(payloadJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudentsCachesCompanion toCompanion(bool nullToAbsent) {
    return StudentsCachesCompanion(
      id: Value(id),
      slotContextId: Value(slotContextId),
      cacheKey: Value(cacheKey),
      payloadJson: Value(payloadJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory StudentsCache.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentsCache(
      id: serializer.fromJson<int>(json['id']),
      slotContextId: serializer.fromJson<int>(json['slotContextId']),
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slotContextId': serializer.toJson<int>(slotContextId),
      'cacheKey': serializer.toJson<String>(cacheKey),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StudentsCache copyWith({
    int? id,
    int? slotContextId,
    String? cacheKey,
    String? payloadJson,
    DateTime? updatedAt,
  }) => StudentsCache(
    id: id ?? this.id,
    slotContextId: slotContextId ?? this.slotContextId,
    cacheKey: cacheKey ?? this.cacheKey,
    payloadJson: payloadJson ?? this.payloadJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StudentsCache copyWithCompanion(StudentsCachesCompanion data) {
    return StudentsCache(
      id: data.id.present ? data.id.value : this.id,
      slotContextId: data.slotContextId.present
          ? data.slotContextId.value
          : this.slotContextId,
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCache(')
          ..write('id: $id, ')
          ..write('slotContextId: $slotContextId, ')
          ..write('cacheKey: $cacheKey, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, slotContextId, cacheKey, payloadJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentsCache &&
          other.id == this.id &&
          other.slotContextId == this.slotContextId &&
          other.cacheKey == this.cacheKey &&
          other.payloadJson == this.payloadJson &&
          other.updatedAt == this.updatedAt);
}

class StudentsCachesCompanion extends UpdateCompanion<StudentsCache> {
  final Value<int> id;
  final Value<int> slotContextId;
  final Value<String> cacheKey;
  final Value<String> payloadJson;
  final Value<DateTime> updatedAt;
  const StudentsCachesCompanion({
    this.id = const Value.absent(),
    this.slotContextId = const Value.absent(),
    this.cacheKey = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudentsCachesCompanion.insert({
    this.id = const Value.absent(),
    required int slotContextId,
    required String cacheKey,
    required String payloadJson,
    this.updatedAt = const Value.absent(),
  }) : slotContextId = Value(slotContextId),
       cacheKey = Value(cacheKey),
       payloadJson = Value(payloadJson);
  static Insertable<StudentsCache> custom({
    Expression<int>? id,
    Expression<int>? slotContextId,
    Expression<String>? cacheKey,
    Expression<String>? payloadJson,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slotContextId != null) 'slot_context_id': slotContextId,
      if (cacheKey != null) 'cache_key': cacheKey,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudentsCachesCompanion copyWith({
    Value<int>? id,
    Value<int>? slotContextId,
    Value<String>? cacheKey,
    Value<String>? payloadJson,
    Value<DateTime>? updatedAt,
  }) {
    return StudentsCachesCompanion(
      id: id ?? this.id,
      slotContextId: slotContextId ?? this.slotContextId,
      cacheKey: cacheKey ?? this.cacheKey,
      payloadJson: payloadJson ?? this.payloadJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slotContextId.present) {
      map['slot_context_id'] = Variable<int>(slotContextId.value);
    }
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCachesCompanion(')
          ..write('id: $id, ')
          ..write('slotContextId: $slotContextId, ')
          ..write('cacheKey: $cacheKey, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SessionSnapshotsTable extends SessionSnapshots
    with TableInfo<$SessionSnapshotsTable, SessionSnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cacheKeyMeta = const VerificationMeta(
    'cacheKey',
  );
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
    'cache_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduleSlotIdMeta = const VerificationMeta(
    'scheduleSlotId',
  );
  @override
  late final GeneratedColumn<int> scheduleSlotId = GeneratedColumn<int>(
    'schedule_slot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attendanceDateMeta = const VerificationMeta(
    'attendanceDate',
  );
  @override
  late final GeneratedColumn<DateTime> attendanceDate =
      GeneratedColumn<DateTime>(
        'attendance_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cacheKey,
    scheduleSlotId,
    attendanceDate,
    payloadJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionSnapshot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cache_key')) {
      context.handle(
        _cacheKeyMeta,
        cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('schedule_slot_id')) {
      context.handle(
        _scheduleSlotIdMeta,
        scheduleSlotId.isAcceptableOrUnknown(
          data['schedule_slot_id']!,
          _scheduleSlotIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleSlotIdMeta);
    }
    if (data.containsKey('attendance_date')) {
      context.handle(
        _attendanceDateMeta,
        attendanceDate.isAcceptableOrUnknown(
          data['attendance_date']!,
          _attendanceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attendanceDateMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {cacheKey},
  ];
  @override
  SessionSnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionSnapshot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cacheKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cache_key'],
      )!,
      scheduleSlotId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schedule_slot_id'],
      )!,
      attendanceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}attendance_date'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SessionSnapshotsTable createAlias(String alias) {
    return $SessionSnapshotsTable(attachedDatabase, alias);
  }
}

class SessionSnapshot extends DataClass implements Insertable<SessionSnapshot> {
  final int id;
  final String cacheKey;
  final int scheduleSlotId;
  final DateTime attendanceDate;
  final String payloadJson;
  final DateTime updatedAt;
  const SessionSnapshot({
    required this.id,
    required this.cacheKey,
    required this.scheduleSlotId,
    required this.attendanceDate,
    required this.payloadJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cache_key'] = Variable<String>(cacheKey);
    map['schedule_slot_id'] = Variable<int>(scheduleSlotId);
    map['attendance_date'] = Variable<DateTime>(attendanceDate);
    map['payload_json'] = Variable<String>(payloadJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SessionSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return SessionSnapshotsCompanion(
      id: Value(id),
      cacheKey: Value(cacheKey),
      scheduleSlotId: Value(scheduleSlotId),
      attendanceDate: Value(attendanceDate),
      payloadJson: Value(payloadJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory SessionSnapshot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionSnapshot(
      id: serializer.fromJson<int>(json['id']),
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      scheduleSlotId: serializer.fromJson<int>(json['scheduleSlotId']),
      attendanceDate: serializer.fromJson<DateTime>(json['attendanceDate']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cacheKey': serializer.toJson<String>(cacheKey),
      'scheduleSlotId': serializer.toJson<int>(scheduleSlotId),
      'attendanceDate': serializer.toJson<DateTime>(attendanceDate),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SessionSnapshot copyWith({
    int? id,
    String? cacheKey,
    int? scheduleSlotId,
    DateTime? attendanceDate,
    String? payloadJson,
    DateTime? updatedAt,
  }) => SessionSnapshot(
    id: id ?? this.id,
    cacheKey: cacheKey ?? this.cacheKey,
    scheduleSlotId: scheduleSlotId ?? this.scheduleSlotId,
    attendanceDate: attendanceDate ?? this.attendanceDate,
    payloadJson: payloadJson ?? this.payloadJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SessionSnapshot copyWithCompanion(SessionSnapshotsCompanion data) {
    return SessionSnapshot(
      id: data.id.present ? data.id.value : this.id,
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      scheduleSlotId: data.scheduleSlotId.present
          ? data.scheduleSlotId.value
          : this.scheduleSlotId,
      attendanceDate: data.attendanceDate.present
          ? data.attendanceDate.value
          : this.attendanceDate,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionSnapshot(')
          ..write('id: $id, ')
          ..write('cacheKey: $cacheKey, ')
          ..write('scheduleSlotId: $scheduleSlotId, ')
          ..write('attendanceDate: $attendanceDate, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cacheKey,
    scheduleSlotId,
    attendanceDate,
    payloadJson,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionSnapshot &&
          other.id == this.id &&
          other.cacheKey == this.cacheKey &&
          other.scheduleSlotId == this.scheduleSlotId &&
          other.attendanceDate == this.attendanceDate &&
          other.payloadJson == this.payloadJson &&
          other.updatedAt == this.updatedAt);
}

class SessionSnapshotsCompanion extends UpdateCompanion<SessionSnapshot> {
  final Value<int> id;
  final Value<String> cacheKey;
  final Value<int> scheduleSlotId;
  final Value<DateTime> attendanceDate;
  final Value<String> payloadJson;
  final Value<DateTime> updatedAt;
  const SessionSnapshotsCompanion({
    this.id = const Value.absent(),
    this.cacheKey = const Value.absent(),
    this.scheduleSlotId = const Value.absent(),
    this.attendanceDate = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SessionSnapshotsCompanion.insert({
    this.id = const Value.absent(),
    required String cacheKey,
    required int scheduleSlotId,
    required DateTime attendanceDate,
    required String payloadJson,
    this.updatedAt = const Value.absent(),
  }) : cacheKey = Value(cacheKey),
       scheduleSlotId = Value(scheduleSlotId),
       attendanceDate = Value(attendanceDate),
       payloadJson = Value(payloadJson);
  static Insertable<SessionSnapshot> custom({
    Expression<int>? id,
    Expression<String>? cacheKey,
    Expression<int>? scheduleSlotId,
    Expression<DateTime>? attendanceDate,
    Expression<String>? payloadJson,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cacheKey != null) 'cache_key': cacheKey,
      if (scheduleSlotId != null) 'schedule_slot_id': scheduleSlotId,
      if (attendanceDate != null) 'attendance_date': attendanceDate,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SessionSnapshotsCompanion copyWith({
    Value<int>? id,
    Value<String>? cacheKey,
    Value<int>? scheduleSlotId,
    Value<DateTime>? attendanceDate,
    Value<String>? payloadJson,
    Value<DateTime>? updatedAt,
  }) {
    return SessionSnapshotsCompanion(
      id: id ?? this.id,
      cacheKey: cacheKey ?? this.cacheKey,
      scheduleSlotId: scheduleSlotId ?? this.scheduleSlotId,
      attendanceDate: attendanceDate ?? this.attendanceDate,
      payloadJson: payloadJson ?? this.payloadJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (scheduleSlotId.present) {
      map['schedule_slot_id'] = Variable<int>(scheduleSlotId.value);
    }
    if (attendanceDate.present) {
      map['attendance_date'] = Variable<DateTime>(attendanceDate.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('cacheKey: $cacheKey, ')
          ..write('scheduleSlotId: $scheduleSlotId, ')
          ..write('attendanceDate: $attendanceDate, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StudentAttendanceStatusesTable extends StudentAttendanceStatuses
    with TableInfo<$StudentAttendanceStatusesTable, StudentAttendanceStatuse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentAttendanceStatusesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cacheKeyMeta = const VerificationMeta(
    'cacheKey',
  );
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
    'cache_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cacheKey,
    studentId,
    payloadJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_attendance_statuses';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentAttendanceStatuse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cache_key')) {
      context.handle(
        _cacheKeyMeta,
        cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {cacheKey},
  ];
  @override
  StudentAttendanceStatuse map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentAttendanceStatuse(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cacheKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cache_key'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StudentAttendanceStatusesTable createAlias(String alias) {
    return $StudentAttendanceStatusesTable(attachedDatabase, alias);
  }
}

class StudentAttendanceStatuse extends DataClass
    implements Insertable<StudentAttendanceStatuse> {
  final int id;
  final String cacheKey;
  final int studentId;
  final String payloadJson;
  final DateTime updatedAt;
  const StudentAttendanceStatuse({
    required this.id,
    required this.cacheKey,
    required this.studentId,
    required this.payloadJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cache_key'] = Variable<String>(cacheKey);
    map['student_id'] = Variable<int>(studentId);
    map['payload_json'] = Variable<String>(payloadJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudentAttendanceStatusesCompanion toCompanion(bool nullToAbsent) {
    return StudentAttendanceStatusesCompanion(
      id: Value(id),
      cacheKey: Value(cacheKey),
      studentId: Value(studentId),
      payloadJson: Value(payloadJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory StudentAttendanceStatuse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentAttendanceStatuse(
      id: serializer.fromJson<int>(json['id']),
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      studentId: serializer.fromJson<int>(json['studentId']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cacheKey': serializer.toJson<String>(cacheKey),
      'studentId': serializer.toJson<int>(studentId),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StudentAttendanceStatuse copyWith({
    int? id,
    String? cacheKey,
    int? studentId,
    String? payloadJson,
    DateTime? updatedAt,
  }) => StudentAttendanceStatuse(
    id: id ?? this.id,
    cacheKey: cacheKey ?? this.cacheKey,
    studentId: studentId ?? this.studentId,
    payloadJson: payloadJson ?? this.payloadJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StudentAttendanceStatuse copyWithCompanion(
    StudentAttendanceStatusesCompanion data,
  ) {
    return StudentAttendanceStatuse(
      id: data.id.present ? data.id.value : this.id,
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentAttendanceStatuse(')
          ..write('id: $id, ')
          ..write('cacheKey: $cacheKey, ')
          ..write('studentId: $studentId, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, cacheKey, studentId, payloadJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentAttendanceStatuse &&
          other.id == this.id &&
          other.cacheKey == this.cacheKey &&
          other.studentId == this.studentId &&
          other.payloadJson == this.payloadJson &&
          other.updatedAt == this.updatedAt);
}

class StudentAttendanceStatusesCompanion
    extends UpdateCompanion<StudentAttendanceStatuse> {
  final Value<int> id;
  final Value<String> cacheKey;
  final Value<int> studentId;
  final Value<String> payloadJson;
  final Value<DateTime> updatedAt;
  const StudentAttendanceStatusesCompanion({
    this.id = const Value.absent(),
    this.cacheKey = const Value.absent(),
    this.studentId = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudentAttendanceStatusesCompanion.insert({
    this.id = const Value.absent(),
    required String cacheKey,
    required int studentId,
    required String payloadJson,
    this.updatedAt = const Value.absent(),
  }) : cacheKey = Value(cacheKey),
       studentId = Value(studentId),
       payloadJson = Value(payloadJson);
  static Insertable<StudentAttendanceStatuse> custom({
    Expression<int>? id,
    Expression<String>? cacheKey,
    Expression<int>? studentId,
    Expression<String>? payloadJson,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cacheKey != null) 'cache_key': cacheKey,
      if (studentId != null) 'student_id': studentId,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudentAttendanceStatusesCompanion copyWith({
    Value<int>? id,
    Value<String>? cacheKey,
    Value<int>? studentId,
    Value<String>? payloadJson,
    Value<DateTime>? updatedAt,
  }) {
    return StudentAttendanceStatusesCompanion(
      id: id ?? this.id,
      cacheKey: cacheKey ?? this.cacheKey,
      studentId: studentId ?? this.studentId,
      payloadJson: payloadJson ?? this.payloadJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentAttendanceStatusesCompanion(')
          ..write('id: $id, ')
          ..write('cacheKey: $cacheKey, ')
          ..write('studentId: $studentId, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _universityStudentIdMeta =
      const VerificationMeta('universityStudentId');
  @override
  late final GeneratedColumn<String> universityStudentId =
      GeneratedColumn<String>(
        'university_student_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      );
  static const VerificationMeta _qrCodeMeta = const VerificationMeta('qrCode');
  @override
  late final GeneratedColumn<String> qrCode = GeneratedColumn<String>(
    'qr_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _universityIdMeta = const VerificationMeta(
    'universityId',
  );
  @override
  late final GeneratedColumn<int> universityId = GeneratedColumn<int>(
    'university_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _programIdMeta = const VerificationMeta(
    'programId',
  );
  @override
  late final GeneratedColumn<int> programId = GeneratedColumn<int>(
    'program_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentSemesterMeta = const VerificationMeta(
    'currentSemester',
  );
  @override
  late final GeneratedColumn<int> currentSemester = GeneratedColumn<int>(
    'current_semester',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _offlineUuidMeta = const VerificationMeta(
    'offlineUuid',
  );
  @override
  late final GeneratedColumn<String> offlineUuid = GeneratedColumn<String>(
    'offline_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSeenAtMeta = const VerificationMeta(
    'lastSeenAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSeenAt = GeneratedColumn<DateTime>(
    'last_seen_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    universityStudentId,
    qrCode,
    fullName,
    email,
    phone,
    universityId,
    programId,
    currentSemester,
    deviceId,
    offlineUuid,
    isActive,
    isDeleted,
    createdAt,
    updatedAt,
    deletedAt,
    lastSeenAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(
    Insertable<Student> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('university_student_id')) {
      context.handle(
        _universityStudentIdMeta,
        universityStudentId.isAcceptableOrUnknown(
          data['university_student_id']!,
          _universityStudentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_universityStudentIdMeta);
    }
    if (data.containsKey('qr_code')) {
      context.handle(
        _qrCodeMeta,
        qrCode.isAcceptableOrUnknown(data['qr_code']!, _qrCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_qrCodeMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('university_id')) {
      context.handle(
        _universityIdMeta,
        universityId.isAcceptableOrUnknown(
          data['university_id']!,
          _universityIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_universityIdMeta);
    }
    if (data.containsKey('program_id')) {
      context.handle(
        _programIdMeta,
        programId.isAcceptableOrUnknown(data['program_id']!, _programIdMeta),
      );
    } else if (isInserting) {
      context.missing(_programIdMeta);
    }
    if (data.containsKey('current_semester')) {
      context.handle(
        _currentSemesterMeta,
        currentSemester.isAcceptableOrUnknown(
          data['current_semester']!,
          _currentSemesterMeta,
        ),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('offline_uuid')) {
      context.handle(
        _offlineUuidMeta,
        offlineUuid.isAcceptableOrUnknown(
          data['offline_uuid']!,
          _offlineUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_offlineUuidMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('last_seen_at')) {
      context.handle(
        _lastSeenAtMeta,
        lastSeenAt.isAcceptableOrUnknown(
          data['last_seen_at']!,
          _lastSeenAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {offlineUuid},
  ];
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      universityStudentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}university_student_id'],
      )!,
      qrCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qr_code'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      universityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}university_id'],
      )!,
      programId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}program_id'],
      )!,
      currentSemester: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_semester'],
      ),
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      offlineUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}offline_uuid'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      lastSeenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_seen_at'],
      ),
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  final int id;

  /// Unique identifier from university system
  final String universityStudentId;

  /// QR code payload string (for instant lookup)
  final String qrCode;
  final String fullName;
  final String? email;
  final String? phone;
  final int universityId;
  final int programId;
  final int? currentSemester;
  final String? deviceId;
  final String offlineUuid;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final DateTime? lastSeenAt;
  const Student({
    required this.id,
    required this.universityStudentId,
    required this.qrCode,
    required this.fullName,
    this.email,
    this.phone,
    required this.universityId,
    required this.programId,
    this.currentSemester,
    this.deviceId,
    required this.offlineUuid,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.lastSeenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['university_student_id'] = Variable<String>(universityStudentId);
    map['qr_code'] = Variable<String>(qrCode);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['university_id'] = Variable<int>(universityId);
    map['program_id'] = Variable<int>(programId);
    if (!nullToAbsent || currentSemester != null) {
      map['current_semester'] = Variable<int>(currentSemester);
    }
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['offline_uuid'] = Variable<String>(offlineUuid);
    map['is_active'] = Variable<bool>(isActive);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || lastSeenAt != null) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt);
    }
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      universityStudentId: Value(universityStudentId),
      qrCode: Value(qrCode),
      fullName: Value(fullName),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      universityId: Value(universityId),
      programId: Value(programId),
      currentSemester: currentSemester == null && nullToAbsent
          ? const Value.absent()
          : Value(currentSemester),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      offlineUuid: Value(offlineUuid),
      isActive: Value(isActive),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      lastSeenAt: lastSeenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeenAt),
    );
  }

  factory Student.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<int>(json['id']),
      universityStudentId: serializer.fromJson<String>(
        json['universityStudentId'],
      ),
      qrCode: serializer.fromJson<String>(json['qrCode']),
      fullName: serializer.fromJson<String>(json['fullName']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      universityId: serializer.fromJson<int>(json['universityId']),
      programId: serializer.fromJson<int>(json['programId']),
      currentSemester: serializer.fromJson<int?>(json['currentSemester']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      offlineUuid: serializer.fromJson<String>(json['offlineUuid']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      lastSeenAt: serializer.fromJson<DateTime?>(json['lastSeenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'universityStudentId': serializer.toJson<String>(universityStudentId),
      'qrCode': serializer.toJson<String>(qrCode),
      'fullName': serializer.toJson<String>(fullName),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'universityId': serializer.toJson<int>(universityId),
      'programId': serializer.toJson<int>(programId),
      'currentSemester': serializer.toJson<int?>(currentSemester),
      'deviceId': serializer.toJson<String?>(deviceId),
      'offlineUuid': serializer.toJson<String>(offlineUuid),
      'isActive': serializer.toJson<bool>(isActive),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'lastSeenAt': serializer.toJson<DateTime?>(lastSeenAt),
    };
  }

  Student copyWith({
    int? id,
    String? universityStudentId,
    String? qrCode,
    String? fullName,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    int? universityId,
    int? programId,
    Value<int?> currentSemester = const Value.absent(),
    Value<String?> deviceId = const Value.absent(),
    String? offlineUuid,
    bool? isActive,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<DateTime?> lastSeenAt = const Value.absent(),
  }) => Student(
    id: id ?? this.id,
    universityStudentId: universityStudentId ?? this.universityStudentId,
    qrCode: qrCode ?? this.qrCode,
    fullName: fullName ?? this.fullName,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    universityId: universityId ?? this.universityId,
    programId: programId ?? this.programId,
    currentSemester: currentSemester.present
        ? currentSemester.value
        : this.currentSemester,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    offlineUuid: offlineUuid ?? this.offlineUuid,
    isActive: isActive ?? this.isActive,
    isDeleted: isDeleted ?? this.isDeleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    lastSeenAt: lastSeenAt.present ? lastSeenAt.value : this.lastSeenAt,
  );
  Student copyWithCompanion(StudentsCompanion data) {
    return Student(
      id: data.id.present ? data.id.value : this.id,
      universityStudentId: data.universityStudentId.present
          ? data.universityStudentId.value
          : this.universityStudentId,
      qrCode: data.qrCode.present ? data.qrCode.value : this.qrCode,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      universityId: data.universityId.present
          ? data.universityId.value
          : this.universityId,
      programId: data.programId.present ? data.programId.value : this.programId,
      currentSemester: data.currentSemester.present
          ? data.currentSemester.value
          : this.currentSemester,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      offlineUuid: data.offlineUuid.present
          ? data.offlineUuid.value
          : this.offlineUuid,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      lastSeenAt: data.lastSeenAt.present
          ? data.lastSeenAt.value
          : this.lastSeenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('universityStudentId: $universityStudentId, ')
          ..write('qrCode: $qrCode, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('universityId: $universityId, ')
          ..write('programId: $programId, ')
          ..write('currentSemester: $currentSemester, ')
          ..write('deviceId: $deviceId, ')
          ..write('offlineUuid: $offlineUuid, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('lastSeenAt: $lastSeenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    universityStudentId,
    qrCode,
    fullName,
    email,
    phone,
    universityId,
    programId,
    currentSemester,
    deviceId,
    offlineUuid,
    isActive,
    isDeleted,
    createdAt,
    updatedAt,
    deletedAt,
    lastSeenAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == this.id &&
          other.universityStudentId == this.universityStudentId &&
          other.qrCode == this.qrCode &&
          other.fullName == this.fullName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.universityId == this.universityId &&
          other.programId == this.programId &&
          other.currentSemester == this.currentSemester &&
          other.deviceId == this.deviceId &&
          other.offlineUuid == this.offlineUuid &&
          other.isActive == this.isActive &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.lastSeenAt == this.lastSeenAt);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> universityStudentId;
  final Value<String> qrCode;
  final Value<String> fullName;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<int> universityId;
  final Value<int> programId;
  final Value<int?> currentSemester;
  final Value<String?> deviceId;
  final Value<String> offlineUuid;
  final Value<bool> isActive;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<DateTime?> lastSeenAt;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.universityStudentId = const Value.absent(),
    this.qrCode = const Value.absent(),
    this.fullName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.universityId = const Value.absent(),
    this.programId = const Value.absent(),
    this.currentSemester = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.offlineUuid = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String universityStudentId,
    required String qrCode,
    required String fullName,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    required int universityId,
    required int programId,
    this.currentSemester = const Value.absent(),
    this.deviceId = const Value.absent(),
    required String offlineUuid,
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
  }) : universityStudentId = Value(universityStudentId),
       qrCode = Value(qrCode),
       fullName = Value(fullName),
       universityId = Value(universityId),
       programId = Value(programId),
       offlineUuid = Value(offlineUuid);
  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? universityStudentId,
    Expression<String>? qrCode,
    Expression<String>? fullName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<int>? universityId,
    Expression<int>? programId,
    Expression<int>? currentSemester,
    Expression<String>? deviceId,
    Expression<String>? offlineUuid,
    Expression<bool>? isActive,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<DateTime>? lastSeenAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (universityStudentId != null)
        'university_student_id': universityStudentId,
      if (qrCode != null) 'qr_code': qrCode,
      if (fullName != null) 'full_name': fullName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (universityId != null) 'university_id': universityId,
      if (programId != null) 'program_id': programId,
      if (currentSemester != null) 'current_semester': currentSemester,
      if (deviceId != null) 'device_id': deviceId,
      if (offlineUuid != null) 'offline_uuid': offlineUuid,
      if (isActive != null) 'is_active': isActive,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (lastSeenAt != null) 'last_seen_at': lastSeenAt,
    });
  }

  StudentsCompanion copyWith({
    Value<int>? id,
    Value<String>? universityStudentId,
    Value<String>? qrCode,
    Value<String>? fullName,
    Value<String?>? email,
    Value<String?>? phone,
    Value<int>? universityId,
    Value<int>? programId,
    Value<int?>? currentSemester,
    Value<String?>? deviceId,
    Value<String>? offlineUuid,
    Value<bool>? isActive,
    Value<bool>? isDeleted,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<DateTime?>? lastSeenAt,
  }) {
    return StudentsCompanion(
      id: id ?? this.id,
      universityStudentId: universityStudentId ?? this.universityStudentId,
      qrCode: qrCode ?? this.qrCode,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      universityId: universityId ?? this.universityId,
      programId: programId ?? this.programId,
      currentSemester: currentSemester ?? this.currentSemester,
      deviceId: deviceId ?? this.deviceId,
      offlineUuid: offlineUuid ?? this.offlineUuid,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (universityStudentId.present) {
      map['university_student_id'] = Variable<String>(
        universityStudentId.value,
      );
    }
    if (qrCode.present) {
      map['qr_code'] = Variable<String>(qrCode.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (universityId.present) {
      map['university_id'] = Variable<int>(universityId.value);
    }
    if (programId.present) {
      map['program_id'] = Variable<int>(programId.value);
    }
    if (currentSemester.present) {
      map['current_semester'] = Variable<int>(currentSemester.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (offlineUuid.present) {
      map['offline_uuid'] = Variable<String>(offlineUuid.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (lastSeenAt.present) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('universityStudentId: $universityStudentId, ')
          ..write('qrCode: $qrCode, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('universityId: $universityId, ')
          ..write('programId: $programId, ')
          ..write('currentSemester: $currentSemester, ')
          ..write('deviceId: $deviceId, ')
          ..write('offlineUuid: $offlineUuid, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('lastSeenAt: $lastSeenAt')
          ..write(')'))
        .toString();
  }
}

class $CoursesTable extends Courses with TableInfo<$CoursesTable, Course> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _universityCourseIdMeta =
      const VerificationMeta('universityCourseId');
  @override
  late final GeneratedColumn<String> universityCourseId =
      GeneratedColumn<String>(
        'university_course_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      );
  static const VerificationMeta _courseCodeMeta = const VerificationMeta(
    'courseCode',
  );
  @override
  late final GeneratedColumn<String> courseCode = GeneratedColumn<String>(
    'course_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseNameMeta = const VerificationMeta(
    'courseName',
  );
  @override
  late final GeneratedColumn<String> courseName = GeneratedColumn<String>(
    'course_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditHoursMeta = const VerificationMeta(
    'creditHours',
  );
  @override
  late final GeneratedColumn<String> creditHours = GeneratedColumn<String>(
    'credit_hours',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _universityIdMeta = const VerificationMeta(
    'universityId',
  );
  @override
  late final GeneratedColumn<int> universityId = GeneratedColumn<int>(
    'university_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _programIdMeta = const VerificationMeta(
    'programId',
  );
  @override
  late final GeneratedColumn<int> programId = GeneratedColumn<int>(
    'program_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _semesterIdMeta = const VerificationMeta(
    'semesterId',
  );
  @override
  late final GeneratedColumn<int> semesterId = GeneratedColumn<int>(
    'semester_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    universityCourseId,
    courseCode,
    courseName,
    creditHours,
    universityId,
    programId,
    semesterId,
    isActive,
    isDeleted,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Course> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('university_course_id')) {
      context.handle(
        _universityCourseIdMeta,
        universityCourseId.isAcceptableOrUnknown(
          data['university_course_id']!,
          _universityCourseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_universityCourseIdMeta);
    }
    if (data.containsKey('course_code')) {
      context.handle(
        _courseCodeMeta,
        courseCode.isAcceptableOrUnknown(data['course_code']!, _courseCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_courseCodeMeta);
    }
    if (data.containsKey('course_name')) {
      context.handle(
        _courseNameMeta,
        courseName.isAcceptableOrUnknown(data['course_name']!, _courseNameMeta),
      );
    } else if (isInserting) {
      context.missing(_courseNameMeta);
    }
    if (data.containsKey('credit_hours')) {
      context.handle(
        _creditHoursMeta,
        creditHours.isAcceptableOrUnknown(
          data['credit_hours']!,
          _creditHoursMeta,
        ),
      );
    }
    if (data.containsKey('university_id')) {
      context.handle(
        _universityIdMeta,
        universityId.isAcceptableOrUnknown(
          data['university_id']!,
          _universityIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_universityIdMeta);
    }
    if (data.containsKey('program_id')) {
      context.handle(
        _programIdMeta,
        programId.isAcceptableOrUnknown(data['program_id']!, _programIdMeta),
      );
    } else if (isInserting) {
      context.missing(_programIdMeta);
    }
    if (data.containsKey('semester_id')) {
      context.handle(
        _semesterIdMeta,
        semesterId.isAcceptableOrUnknown(data['semester_id']!, _semesterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_semesterIdMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Course map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Course(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      universityCourseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}university_course_id'],
      )!,
      courseCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_code'],
      )!,
      courseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_name'],
      )!,
      creditHours: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}credit_hours'],
      ),
      universityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}university_id'],
      )!,
      programId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}program_id'],
      )!,
      semesterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}semester_id'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }
}

class Course extends DataClass implements Insertable<Course> {
  final int id;

  /// Unique course identifier from university system
  final String universityCourseId;
  final String courseCode;
  final String courseName;
  final String? creditHours;
  final int universityId;
  final int programId;
  final int semesterId;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Course({
    required this.id,
    required this.universityCourseId,
    required this.courseCode,
    required this.courseName,
    this.creditHours,
    required this.universityId,
    required this.programId,
    required this.semesterId,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['university_course_id'] = Variable<String>(universityCourseId);
    map['course_code'] = Variable<String>(courseCode);
    map['course_name'] = Variable<String>(courseName);
    if (!nullToAbsent || creditHours != null) {
      map['credit_hours'] = Variable<String>(creditHours);
    }
    map['university_id'] = Variable<int>(universityId);
    map['program_id'] = Variable<int>(programId);
    map['semester_id'] = Variable<int>(semesterId);
    map['is_active'] = Variable<bool>(isActive);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      id: Value(id),
      universityCourseId: Value(universityCourseId),
      courseCode: Value(courseCode),
      courseName: Value(courseName),
      creditHours: creditHours == null && nullToAbsent
          ? const Value.absent()
          : Value(creditHours),
      universityId: Value(universityId),
      programId: Value(programId),
      semesterId: Value(semesterId),
      isActive: Value(isActive),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Course.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Course(
      id: serializer.fromJson<int>(json['id']),
      universityCourseId: serializer.fromJson<String>(
        json['universityCourseId'],
      ),
      courseCode: serializer.fromJson<String>(json['courseCode']),
      courseName: serializer.fromJson<String>(json['courseName']),
      creditHours: serializer.fromJson<String?>(json['creditHours']),
      universityId: serializer.fromJson<int>(json['universityId']),
      programId: serializer.fromJson<int>(json['programId']),
      semesterId: serializer.fromJson<int>(json['semesterId']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'universityCourseId': serializer.toJson<String>(universityCourseId),
      'courseCode': serializer.toJson<String>(courseCode),
      'courseName': serializer.toJson<String>(courseName),
      'creditHours': serializer.toJson<String?>(creditHours),
      'universityId': serializer.toJson<int>(universityId),
      'programId': serializer.toJson<int>(programId),
      'semesterId': serializer.toJson<int>(semesterId),
      'isActive': serializer.toJson<bool>(isActive),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Course copyWith({
    int? id,
    String? universityCourseId,
    String? courseCode,
    String? courseName,
    Value<String?> creditHours = const Value.absent(),
    int? universityId,
    int? programId,
    int? semesterId,
    bool? isActive,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Course(
    id: id ?? this.id,
    universityCourseId: universityCourseId ?? this.universityCourseId,
    courseCode: courseCode ?? this.courseCode,
    courseName: courseName ?? this.courseName,
    creditHours: creditHours.present ? creditHours.value : this.creditHours,
    universityId: universityId ?? this.universityId,
    programId: programId ?? this.programId,
    semesterId: semesterId ?? this.semesterId,
    isActive: isActive ?? this.isActive,
    isDeleted: isDeleted ?? this.isDeleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Course copyWithCompanion(CoursesCompanion data) {
    return Course(
      id: data.id.present ? data.id.value : this.id,
      universityCourseId: data.universityCourseId.present
          ? data.universityCourseId.value
          : this.universityCourseId,
      courseCode: data.courseCode.present
          ? data.courseCode.value
          : this.courseCode,
      courseName: data.courseName.present
          ? data.courseName.value
          : this.courseName,
      creditHours: data.creditHours.present
          ? data.creditHours.value
          : this.creditHours,
      universityId: data.universityId.present
          ? data.universityId.value
          : this.universityId,
      programId: data.programId.present ? data.programId.value : this.programId,
      semesterId: data.semesterId.present
          ? data.semesterId.value
          : this.semesterId,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Course(')
          ..write('id: $id, ')
          ..write('universityCourseId: $universityCourseId, ')
          ..write('courseCode: $courseCode, ')
          ..write('courseName: $courseName, ')
          ..write('creditHours: $creditHours, ')
          ..write('universityId: $universityId, ')
          ..write('programId: $programId, ')
          ..write('semesterId: $semesterId, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    universityCourseId,
    courseCode,
    courseName,
    creditHours,
    universityId,
    programId,
    semesterId,
    isActive,
    isDeleted,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          other.id == this.id &&
          other.universityCourseId == this.universityCourseId &&
          other.courseCode == this.courseCode &&
          other.courseName == this.courseName &&
          other.creditHours == this.creditHours &&
          other.universityId == this.universityId &&
          other.programId == this.programId &&
          other.semesterId == this.semesterId &&
          other.isActive == this.isActive &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class CoursesCompanion extends UpdateCompanion<Course> {
  final Value<int> id;
  final Value<String> universityCourseId;
  final Value<String> courseCode;
  final Value<String> courseName;
  final Value<String?> creditHours;
  final Value<int> universityId;
  final Value<int> programId;
  final Value<int> semesterId;
  final Value<bool> isActive;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.universityCourseId = const Value.absent(),
    this.courseCode = const Value.absent(),
    this.courseName = const Value.absent(),
    this.creditHours = const Value.absent(),
    this.universityId = const Value.absent(),
    this.programId = const Value.absent(),
    this.semesterId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  CoursesCompanion.insert({
    this.id = const Value.absent(),
    required String universityCourseId,
    required String courseCode,
    required String courseName,
    this.creditHours = const Value.absent(),
    required int universityId,
    required int programId,
    required int semesterId,
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : universityCourseId = Value(universityCourseId),
       courseCode = Value(courseCode),
       courseName = Value(courseName),
       universityId = Value(universityId),
       programId = Value(programId),
       semesterId = Value(semesterId);
  static Insertable<Course> custom({
    Expression<int>? id,
    Expression<String>? universityCourseId,
    Expression<String>? courseCode,
    Expression<String>? courseName,
    Expression<String>? creditHours,
    Expression<int>? universityId,
    Expression<int>? programId,
    Expression<int>? semesterId,
    Expression<bool>? isActive,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (universityCourseId != null)
        'university_course_id': universityCourseId,
      if (courseCode != null) 'course_code': courseCode,
      if (courseName != null) 'course_name': courseName,
      if (creditHours != null) 'credit_hours': creditHours,
      if (universityId != null) 'university_id': universityId,
      if (programId != null) 'program_id': programId,
      if (semesterId != null) 'semester_id': semesterId,
      if (isActive != null) 'is_active': isActive,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  CoursesCompanion copyWith({
    Value<int>? id,
    Value<String>? universityCourseId,
    Value<String>? courseCode,
    Value<String>? courseName,
    Value<String?>? creditHours,
    Value<int>? universityId,
    Value<int>? programId,
    Value<int>? semesterId,
    Value<bool>? isActive,
    Value<bool>? isDeleted,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return CoursesCompanion(
      id: id ?? this.id,
      universityCourseId: universityCourseId ?? this.universityCourseId,
      courseCode: courseCode ?? this.courseCode,
      courseName: courseName ?? this.courseName,
      creditHours: creditHours ?? this.creditHours,
      universityId: universityId ?? this.universityId,
      programId: programId ?? this.programId,
      semesterId: semesterId ?? this.semesterId,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (universityCourseId.present) {
      map['university_course_id'] = Variable<String>(universityCourseId.value);
    }
    if (courseCode.present) {
      map['course_code'] = Variable<String>(courseCode.value);
    }
    if (courseName.present) {
      map['course_name'] = Variable<String>(courseName.value);
    }
    if (creditHours.present) {
      map['credit_hours'] = Variable<String>(creditHours.value);
    }
    if (universityId.present) {
      map['university_id'] = Variable<int>(universityId.value);
    }
    if (programId.present) {
      map['program_id'] = Variable<int>(programId.value);
    }
    if (semesterId.present) {
      map['semester_id'] = Variable<int>(semesterId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('id: $id, ')
          ..write('universityCourseId: $universityCourseId, ')
          ..write('courseCode: $courseCode, ')
          ..write('courseName: $courseName, ')
          ..write('creditHours: $creditHours, ')
          ..write('universityId: $universityId, ')
          ..write('programId: $programId, ')
          ..write('semesterId: $semesterId, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $SchedulesTable extends Schedules
    with TableInfo<$SchedulesTable, Schedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _universitySlotIdMeta = const VerificationMeta(
    'universitySlotId',
  );
  @override
  late final GeneratedColumn<String> universitySlotId = GeneratedColumn<String>(
    'university_slot_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _courseIdMeta = const VerificationMeta(
    'courseId',
  );
  @override
  late final GeneratedColumn<int> courseId = GeneratedColumn<int>(
    'course_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _facultyMemberIdMeta = const VerificationMeta(
    'facultyMemberId',
  );
  @override
  late final GeneratedColumn<int> facultyMemberId = GeneratedColumn<int>(
    'faculty_member_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _semesterIdMeta = const VerificationMeta(
    'semesterId',
  );
  @override
  late final GeneratedColumn<int> semesterId = GeneratedColumn<int>(
    'semester_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayOfWeekMeta = const VerificationMeta(
    'dayOfWeek',
  );
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
    'day_of_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roomNumberMeta = const VerificationMeta(
    'roomNumber',
  );
  @override
  late final GeneratedColumn<String> roomNumber = GeneratedColumn<String>(
    'room_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _buildingMeta = const VerificationMeta(
    'building',
  );
  @override
  late final GeneratedColumn<String> building = GeneratedColumn<String>(
    'building',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    universitySlotId,
    courseId,
    facultyMemberId,
    semesterId,
    dayOfWeek,
    startTime,
    endTime,
    roomNumber,
    building,
    isActive,
    isDeleted,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<Schedule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('university_slot_id')) {
      context.handle(
        _universitySlotIdMeta,
        universitySlotId.isAcceptableOrUnknown(
          data['university_slot_id']!,
          _universitySlotIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_universitySlotIdMeta);
    }
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('faculty_member_id')) {
      context.handle(
        _facultyMemberIdMeta,
        facultyMemberId.isAcceptableOrUnknown(
          data['faculty_member_id']!,
          _facultyMemberIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_facultyMemberIdMeta);
    }
    if (data.containsKey('semester_id')) {
      context.handle(
        _semesterIdMeta,
        semesterId.isAcceptableOrUnknown(data['semester_id']!, _semesterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_semesterIdMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
        _dayOfWeekMeta,
        dayOfWeek.isAcceptableOrUnknown(data['day_of_week']!, _dayOfWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('room_number')) {
      context.handle(
        _roomNumberMeta,
        roomNumber.isAcceptableOrUnknown(data['room_number']!, _roomNumberMeta),
      );
    }
    if (data.containsKey('building')) {
      context.handle(
        _buildingMeta,
        building.isAcceptableOrUnknown(data['building']!, _buildingMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {universitySlotId},
  ];
  @override
  Schedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Schedule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      universitySlotId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}university_slot_id'],
      )!,
      courseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_id'],
      )!,
      facultyMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}faculty_member_id'],
      )!,
      semesterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}semester_id'],
      )!,
      dayOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_week'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_time'],
      )!,
      roomNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room_number'],
      ),
      building: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}building'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $SchedulesTable createAlias(String alias) {
    return $SchedulesTable(attachedDatabase, alias);
  }
}

class Schedule extends DataClass implements Insertable<Schedule> {
  final int id;

  /// Slot identifier from university system
  final String universitySlotId;
  final int courseId;
  final int facultyMemberId;
  final int semesterId;
  final int dayOfWeek;
  final String startTime;
  final String endTime;
  final String? roomNumber;
  final String? building;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Schedule({
    required this.id,
    required this.universitySlotId,
    required this.courseId,
    required this.facultyMemberId,
    required this.semesterId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.roomNumber,
    this.building,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['university_slot_id'] = Variable<String>(universitySlotId);
    map['course_id'] = Variable<int>(courseId);
    map['faculty_member_id'] = Variable<int>(facultyMemberId);
    map['semester_id'] = Variable<int>(semesterId);
    map['day_of_week'] = Variable<int>(dayOfWeek);
    map['start_time'] = Variable<String>(startTime);
    map['end_time'] = Variable<String>(endTime);
    if (!nullToAbsent || roomNumber != null) {
      map['room_number'] = Variable<String>(roomNumber);
    }
    if (!nullToAbsent || building != null) {
      map['building'] = Variable<String>(building);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  SchedulesCompanion toCompanion(bool nullToAbsent) {
    return SchedulesCompanion(
      id: Value(id),
      universitySlotId: Value(universitySlotId),
      courseId: Value(courseId),
      facultyMemberId: Value(facultyMemberId),
      semesterId: Value(semesterId),
      dayOfWeek: Value(dayOfWeek),
      startTime: Value(startTime),
      endTime: Value(endTime),
      roomNumber: roomNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(roomNumber),
      building: building == null && nullToAbsent
          ? const Value.absent()
          : Value(building),
      isActive: Value(isActive),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Schedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Schedule(
      id: serializer.fromJson<int>(json['id']),
      universitySlotId: serializer.fromJson<String>(json['universitySlotId']),
      courseId: serializer.fromJson<int>(json['courseId']),
      facultyMemberId: serializer.fromJson<int>(json['facultyMemberId']),
      semesterId: serializer.fromJson<int>(json['semesterId']),
      dayOfWeek: serializer.fromJson<int>(json['dayOfWeek']),
      startTime: serializer.fromJson<String>(json['startTime']),
      endTime: serializer.fromJson<String>(json['endTime']),
      roomNumber: serializer.fromJson<String?>(json['roomNumber']),
      building: serializer.fromJson<String?>(json['building']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'universitySlotId': serializer.toJson<String>(universitySlotId),
      'courseId': serializer.toJson<int>(courseId),
      'facultyMemberId': serializer.toJson<int>(facultyMemberId),
      'semesterId': serializer.toJson<int>(semesterId),
      'dayOfWeek': serializer.toJson<int>(dayOfWeek),
      'startTime': serializer.toJson<String>(startTime),
      'endTime': serializer.toJson<String>(endTime),
      'roomNumber': serializer.toJson<String?>(roomNumber),
      'building': serializer.toJson<String?>(building),
      'isActive': serializer.toJson<bool>(isActive),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Schedule copyWith({
    int? id,
    String? universitySlotId,
    int? courseId,
    int? facultyMemberId,
    int? semesterId,
    int? dayOfWeek,
    String? startTime,
    String? endTime,
    Value<String?> roomNumber = const Value.absent(),
    Value<String?> building = const Value.absent(),
    bool? isActive,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Schedule(
    id: id ?? this.id,
    universitySlotId: universitySlotId ?? this.universitySlotId,
    courseId: courseId ?? this.courseId,
    facultyMemberId: facultyMemberId ?? this.facultyMemberId,
    semesterId: semesterId ?? this.semesterId,
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    roomNumber: roomNumber.present ? roomNumber.value : this.roomNumber,
    building: building.present ? building.value : this.building,
    isActive: isActive ?? this.isActive,
    isDeleted: isDeleted ?? this.isDeleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Schedule copyWithCompanion(SchedulesCompanion data) {
    return Schedule(
      id: data.id.present ? data.id.value : this.id,
      universitySlotId: data.universitySlotId.present
          ? data.universitySlotId.value
          : this.universitySlotId,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      facultyMemberId: data.facultyMemberId.present
          ? data.facultyMemberId.value
          : this.facultyMemberId,
      semesterId: data.semesterId.present
          ? data.semesterId.value
          : this.semesterId,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      roomNumber: data.roomNumber.present
          ? data.roomNumber.value
          : this.roomNumber,
      building: data.building.present ? data.building.value : this.building,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Schedule(')
          ..write('id: $id, ')
          ..write('universitySlotId: $universitySlotId, ')
          ..write('courseId: $courseId, ')
          ..write('facultyMemberId: $facultyMemberId, ')
          ..write('semesterId: $semesterId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('roomNumber: $roomNumber, ')
          ..write('building: $building, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    universitySlotId,
    courseId,
    facultyMemberId,
    semesterId,
    dayOfWeek,
    startTime,
    endTime,
    roomNumber,
    building,
    isActive,
    isDeleted,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Schedule &&
          other.id == this.id &&
          other.universitySlotId == this.universitySlotId &&
          other.courseId == this.courseId &&
          other.facultyMemberId == this.facultyMemberId &&
          other.semesterId == this.semesterId &&
          other.dayOfWeek == this.dayOfWeek &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.roomNumber == this.roomNumber &&
          other.building == this.building &&
          other.isActive == this.isActive &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class SchedulesCompanion extends UpdateCompanion<Schedule> {
  final Value<int> id;
  final Value<String> universitySlotId;
  final Value<int> courseId;
  final Value<int> facultyMemberId;
  final Value<int> semesterId;
  final Value<int> dayOfWeek;
  final Value<String> startTime;
  final Value<String> endTime;
  final Value<String?> roomNumber;
  final Value<String?> building;
  final Value<bool> isActive;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const SchedulesCompanion({
    this.id = const Value.absent(),
    this.universitySlotId = const Value.absent(),
    this.courseId = const Value.absent(),
    this.facultyMemberId = const Value.absent(),
    this.semesterId = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.roomNumber = const Value.absent(),
    this.building = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  SchedulesCompanion.insert({
    this.id = const Value.absent(),
    required String universitySlotId,
    required int courseId,
    required int facultyMemberId,
    required int semesterId,
    required int dayOfWeek,
    required String startTime,
    required String endTime,
    this.roomNumber = const Value.absent(),
    this.building = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : universitySlotId = Value(universitySlotId),
       courseId = Value(courseId),
       facultyMemberId = Value(facultyMemberId),
       semesterId = Value(semesterId),
       dayOfWeek = Value(dayOfWeek),
       startTime = Value(startTime),
       endTime = Value(endTime);
  static Insertable<Schedule> custom({
    Expression<int>? id,
    Expression<String>? universitySlotId,
    Expression<int>? courseId,
    Expression<int>? facultyMemberId,
    Expression<int>? semesterId,
    Expression<int>? dayOfWeek,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<String>? roomNumber,
    Expression<String>? building,
    Expression<bool>? isActive,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (universitySlotId != null) 'university_slot_id': universitySlotId,
      if (courseId != null) 'course_id': courseId,
      if (facultyMemberId != null) 'faculty_member_id': facultyMemberId,
      if (semesterId != null) 'semester_id': semesterId,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (roomNumber != null) 'room_number': roomNumber,
      if (building != null) 'building': building,
      if (isActive != null) 'is_active': isActive,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  SchedulesCompanion copyWith({
    Value<int>? id,
    Value<String>? universitySlotId,
    Value<int>? courseId,
    Value<int>? facultyMemberId,
    Value<int>? semesterId,
    Value<int>? dayOfWeek,
    Value<String>? startTime,
    Value<String>? endTime,
    Value<String?>? roomNumber,
    Value<String?>? building,
    Value<bool>? isActive,
    Value<bool>? isDeleted,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return SchedulesCompanion(
      id: id ?? this.id,
      universitySlotId: universitySlotId ?? this.universitySlotId,
      courseId: courseId ?? this.courseId,
      facultyMemberId: facultyMemberId ?? this.facultyMemberId,
      semesterId: semesterId ?? this.semesterId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      roomNumber: roomNumber ?? this.roomNumber,
      building: building ?? this.building,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (universitySlotId.present) {
      map['university_slot_id'] = Variable<String>(universitySlotId.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<int>(courseId.value);
    }
    if (facultyMemberId.present) {
      map['faculty_member_id'] = Variable<int>(facultyMemberId.value);
    }
    if (semesterId.present) {
      map['semester_id'] = Variable<int>(semesterId.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (roomNumber.present) {
      map['room_number'] = Variable<String>(roomNumber.value);
    }
    if (building.present) {
      map['building'] = Variable<String>(building.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchedulesCompanion(')
          ..write('id: $id, ')
          ..write('universitySlotId: $universitySlotId, ')
          ..write('courseId: $courseId, ')
          ..write('facultyMemberId: $facultyMemberId, ')
          ..write('semesterId: $semesterId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('roomNumber: $roomNumber, ')
          ..write('building: $building, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $AttendanceSessionsTable extends AttendanceSessions
    with TableInfo<$AttendanceSessionsTable, AttendanceSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scheduleSlotIdMeta = const VerificationMeta(
    'scheduleSlotId',
  );
  @override
  late final GeneratedColumn<int> scheduleSlotId = GeneratedColumn<int>(
    'schedule_slot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _facultyMemberIdMeta = const VerificationMeta(
    'facultyMemberId',
  );
  @override
  late final GeneratedColumn<int> facultyMemberId = GeneratedColumn<int>(
    'faculty_member_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionDateMeta = const VerificationMeta(
    'sessionDate',
  );
  @override
  late final GeneratedColumn<DateTime> sessionDate = GeneratedColumn<DateTime>(
    'session_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attendanceModeMeta = const VerificationMeta(
    'attendanceMode',
  );
  @override
  late final GeneratedColumn<String> attendanceMode = GeneratedColumn<String>(
    'attendance_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualDurationMeta = const VerificationMeta(
    'actualDuration',
  );
  @override
  late final GeneratedColumn<double> actualDuration = GeneratedColumn<double>(
    'actual_duration',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _offlineUuidMeta = const VerificationMeta(
    'offlineUuid',
  );
  @override
  late final GeneratedColumn<String> offlineUuid = GeneratedColumn<String>(
    'offline_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    scheduleSlotId,
    facultyMemberId,
    sessionDate,
    startTime,
    endTime,
    attendanceMode,
    actualDuration,
    notes,
    offlineUuid,
    deviceId,
    isSynced,
    isDeleted,
    createdAt,
    updatedAt,
    deletedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('schedule_slot_id')) {
      context.handle(
        _scheduleSlotIdMeta,
        scheduleSlotId.isAcceptableOrUnknown(
          data['schedule_slot_id']!,
          _scheduleSlotIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleSlotIdMeta);
    }
    if (data.containsKey('faculty_member_id')) {
      context.handle(
        _facultyMemberIdMeta,
        facultyMemberId.isAcceptableOrUnknown(
          data['faculty_member_id']!,
          _facultyMemberIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_facultyMemberIdMeta);
    }
    if (data.containsKey('session_date')) {
      context.handle(
        _sessionDateMeta,
        sessionDate.isAcceptableOrUnknown(
          data['session_date']!,
          _sessionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionDateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('attendance_mode')) {
      context.handle(
        _attendanceModeMeta,
        attendanceMode.isAcceptableOrUnknown(
          data['attendance_mode']!,
          _attendanceModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attendanceModeMeta);
    }
    if (data.containsKey('actual_duration')) {
      context.handle(
        _actualDurationMeta,
        actualDuration.isAcceptableOrUnknown(
          data['actual_duration']!,
          _actualDurationMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('offline_uuid')) {
      context.handle(
        _offlineUuidMeta,
        offlineUuid.isAcceptableOrUnknown(
          data['offline_uuid']!,
          _offlineUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_offlineUuidMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {scheduleSlotId, sessionDate},
    {offlineUuid},
  ];
  @override
  AttendanceSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      scheduleSlotId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schedule_slot_id'],
      )!,
      facultyMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}faculty_member_id'],
      )!,
      sessionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}session_date'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_time'],
      )!,
      attendanceMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attendance_mode'],
      )!,
      actualDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}actual_duration'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      offlineUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}offline_uuid'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $AttendanceSessionsTable createAlias(String alias) {
    return $AttendanceSessionsTable(attachedDatabase, alias);
  }
}

class AttendanceSession extends DataClass
    implements Insertable<AttendanceSession> {
  final int id;
  final int scheduleSlotId;
  final int facultyMemberId;
  final DateTime sessionDate;
  final String startTime;
  final String endTime;
  final String attendanceMode;
  final double? actualDuration;
  final String? notes;
  final String offlineUuid;
  final String? deviceId;
  final bool isSynced;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final DateTime? syncedAt;
  const AttendanceSession({
    required this.id,
    required this.scheduleSlotId,
    required this.facultyMemberId,
    required this.sessionDate,
    required this.startTime,
    required this.endTime,
    required this.attendanceMode,
    this.actualDuration,
    this.notes,
    required this.offlineUuid,
    this.deviceId,
    required this.isSynced,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['schedule_slot_id'] = Variable<int>(scheduleSlotId);
    map['faculty_member_id'] = Variable<int>(facultyMemberId);
    map['session_date'] = Variable<DateTime>(sessionDate);
    map['start_time'] = Variable<String>(startTime);
    map['end_time'] = Variable<String>(endTime);
    map['attendance_mode'] = Variable<String>(attendanceMode);
    if (!nullToAbsent || actualDuration != null) {
      map['actual_duration'] = Variable<double>(actualDuration);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['offline_uuid'] = Variable<String>(offlineUuid);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  AttendanceSessionsCompanion toCompanion(bool nullToAbsent) {
    return AttendanceSessionsCompanion(
      id: Value(id),
      scheduleSlotId: Value(scheduleSlotId),
      facultyMemberId: Value(facultyMemberId),
      sessionDate: Value(sessionDate),
      startTime: Value(startTime),
      endTime: Value(endTime),
      attendanceMode: Value(attendanceMode),
      actualDuration: actualDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(actualDuration),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      offlineUuid: Value(offlineUuid),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      isSynced: Value(isSynced),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory AttendanceSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceSession(
      id: serializer.fromJson<int>(json['id']),
      scheduleSlotId: serializer.fromJson<int>(json['scheduleSlotId']),
      facultyMemberId: serializer.fromJson<int>(json['facultyMemberId']),
      sessionDate: serializer.fromJson<DateTime>(json['sessionDate']),
      startTime: serializer.fromJson<String>(json['startTime']),
      endTime: serializer.fromJson<String>(json['endTime']),
      attendanceMode: serializer.fromJson<String>(json['attendanceMode']),
      actualDuration: serializer.fromJson<double?>(json['actualDuration']),
      notes: serializer.fromJson<String?>(json['notes']),
      offlineUuid: serializer.fromJson<String>(json['offlineUuid']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scheduleSlotId': serializer.toJson<int>(scheduleSlotId),
      'facultyMemberId': serializer.toJson<int>(facultyMemberId),
      'sessionDate': serializer.toJson<DateTime>(sessionDate),
      'startTime': serializer.toJson<String>(startTime),
      'endTime': serializer.toJson<String>(endTime),
      'attendanceMode': serializer.toJson<String>(attendanceMode),
      'actualDuration': serializer.toJson<double?>(actualDuration),
      'notes': serializer.toJson<String?>(notes),
      'offlineUuid': serializer.toJson<String>(offlineUuid),
      'deviceId': serializer.toJson<String?>(deviceId),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  AttendanceSession copyWith({
    int? id,
    int? scheduleSlotId,
    int? facultyMemberId,
    DateTime? sessionDate,
    String? startTime,
    String? endTime,
    String? attendanceMode,
    Value<double?> actualDuration = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? offlineUuid,
    Value<String?> deviceId = const Value.absent(),
    bool? isSynced,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => AttendanceSession(
    id: id ?? this.id,
    scheduleSlotId: scheduleSlotId ?? this.scheduleSlotId,
    facultyMemberId: facultyMemberId ?? this.facultyMemberId,
    sessionDate: sessionDate ?? this.sessionDate,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    attendanceMode: attendanceMode ?? this.attendanceMode,
    actualDuration: actualDuration.present
        ? actualDuration.value
        : this.actualDuration,
    notes: notes.present ? notes.value : this.notes,
    offlineUuid: offlineUuid ?? this.offlineUuid,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    isSynced: isSynced ?? this.isSynced,
    isDeleted: isDeleted ?? this.isDeleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  AttendanceSession copyWithCompanion(AttendanceSessionsCompanion data) {
    return AttendanceSession(
      id: data.id.present ? data.id.value : this.id,
      scheduleSlotId: data.scheduleSlotId.present
          ? data.scheduleSlotId.value
          : this.scheduleSlotId,
      facultyMemberId: data.facultyMemberId.present
          ? data.facultyMemberId.value
          : this.facultyMemberId,
      sessionDate: data.sessionDate.present
          ? data.sessionDate.value
          : this.sessionDate,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      attendanceMode: data.attendanceMode.present
          ? data.attendanceMode.value
          : this.attendanceMode,
      actualDuration: data.actualDuration.present
          ? data.actualDuration.value
          : this.actualDuration,
      notes: data.notes.present ? data.notes.value : this.notes,
      offlineUuid: data.offlineUuid.present
          ? data.offlineUuid.value
          : this.offlineUuid,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceSession(')
          ..write('id: $id, ')
          ..write('scheduleSlotId: $scheduleSlotId, ')
          ..write('facultyMemberId: $facultyMemberId, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('attendanceMode: $attendanceMode, ')
          ..write('actualDuration: $actualDuration, ')
          ..write('notes: $notes, ')
          ..write('offlineUuid: $offlineUuid, ')
          ..write('deviceId: $deviceId, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    scheduleSlotId,
    facultyMemberId,
    sessionDate,
    startTime,
    endTime,
    attendanceMode,
    actualDuration,
    notes,
    offlineUuid,
    deviceId,
    isSynced,
    isDeleted,
    createdAt,
    updatedAt,
    deletedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceSession &&
          other.id == this.id &&
          other.scheduleSlotId == this.scheduleSlotId &&
          other.facultyMemberId == this.facultyMemberId &&
          other.sessionDate == this.sessionDate &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.attendanceMode == this.attendanceMode &&
          other.actualDuration == this.actualDuration &&
          other.notes == this.notes &&
          other.offlineUuid == this.offlineUuid &&
          other.deviceId == this.deviceId &&
          other.isSynced == this.isSynced &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncedAt == this.syncedAt);
}

class AttendanceSessionsCompanion extends UpdateCompanion<AttendanceSession> {
  final Value<int> id;
  final Value<int> scheduleSlotId;
  final Value<int> facultyMemberId;
  final Value<DateTime> sessionDate;
  final Value<String> startTime;
  final Value<String> endTime;
  final Value<String> attendanceMode;
  final Value<double?> actualDuration;
  final Value<String?> notes;
  final Value<String> offlineUuid;
  final Value<String?> deviceId;
  final Value<bool> isSynced;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<DateTime?> syncedAt;
  const AttendanceSessionsCompanion({
    this.id = const Value.absent(),
    this.scheduleSlotId = const Value.absent(),
    this.facultyMemberId = const Value.absent(),
    this.sessionDate = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.attendanceMode = const Value.absent(),
    this.actualDuration = const Value.absent(),
    this.notes = const Value.absent(),
    this.offlineUuid = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  AttendanceSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int scheduleSlotId,
    required int facultyMemberId,
    required DateTime sessionDate,
    required String startTime,
    required String endTime,
    required String attendanceMode,
    this.actualDuration = const Value.absent(),
    this.notes = const Value.absent(),
    required String offlineUuid,
    this.deviceId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  }) : scheduleSlotId = Value(scheduleSlotId),
       facultyMemberId = Value(facultyMemberId),
       sessionDate = Value(sessionDate),
       startTime = Value(startTime),
       endTime = Value(endTime),
       attendanceMode = Value(attendanceMode),
       offlineUuid = Value(offlineUuid);
  static Insertable<AttendanceSession> custom({
    Expression<int>? id,
    Expression<int>? scheduleSlotId,
    Expression<int>? facultyMemberId,
    Expression<DateTime>? sessionDate,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<String>? attendanceMode,
    Expression<double>? actualDuration,
    Expression<String>? notes,
    Expression<String>? offlineUuid,
    Expression<String>? deviceId,
    Expression<bool>? isSynced,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scheduleSlotId != null) 'schedule_slot_id': scheduleSlotId,
      if (facultyMemberId != null) 'faculty_member_id': facultyMemberId,
      if (sessionDate != null) 'session_date': sessionDate,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (attendanceMode != null) 'attendance_mode': attendanceMode,
      if (actualDuration != null) 'actual_duration': actualDuration,
      if (notes != null) 'notes': notes,
      if (offlineUuid != null) 'offline_uuid': offlineUuid,
      if (deviceId != null) 'device_id': deviceId,
      if (isSynced != null) 'is_synced': isSynced,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  AttendanceSessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? scheduleSlotId,
    Value<int>? facultyMemberId,
    Value<DateTime>? sessionDate,
    Value<String>? startTime,
    Value<String>? endTime,
    Value<String>? attendanceMode,
    Value<double?>? actualDuration,
    Value<String?>? notes,
    Value<String>? offlineUuid,
    Value<String?>? deviceId,
    Value<bool>? isSynced,
    Value<bool>? isDeleted,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<DateTime?>? syncedAt,
  }) {
    return AttendanceSessionsCompanion(
      id: id ?? this.id,
      scheduleSlotId: scheduleSlotId ?? this.scheduleSlotId,
      facultyMemberId: facultyMemberId ?? this.facultyMemberId,
      sessionDate: sessionDate ?? this.sessionDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      attendanceMode: attendanceMode ?? this.attendanceMode,
      actualDuration: actualDuration ?? this.actualDuration,
      notes: notes ?? this.notes,
      offlineUuid: offlineUuid ?? this.offlineUuid,
      deviceId: deviceId ?? this.deviceId,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scheduleSlotId.present) {
      map['schedule_slot_id'] = Variable<int>(scheduleSlotId.value);
    }
    if (facultyMemberId.present) {
      map['faculty_member_id'] = Variable<int>(facultyMemberId.value);
    }
    if (sessionDate.present) {
      map['session_date'] = Variable<DateTime>(sessionDate.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (attendanceMode.present) {
      map['attendance_mode'] = Variable<String>(attendanceMode.value);
    }
    if (actualDuration.present) {
      map['actual_duration'] = Variable<double>(actualDuration.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (offlineUuid.present) {
      map['offline_uuid'] = Variable<String>(offlineUuid.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceSessionsCompanion(')
          ..write('id: $id, ')
          ..write('scheduleSlotId: $scheduleSlotId, ')
          ..write('facultyMemberId: $facultyMemberId, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('attendanceMode: $attendanceMode, ')
          ..write('actualDuration: $actualDuration, ')
          ..write('notes: $notes, ')
          ..write('offlineUuid: $offlineUuid, ')
          ..write('deviceId: $deviceId, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $StaffPermissionsTable extends StaffPermissions
    with TableInfo<$StaffPermissionsTable, StaffPermission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StaffPermissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseIdMeta = const VerificationMeta(
    'courseId',
  );
  @override
  late final GeneratedColumn<int> courseId = GeneratedColumn<int>(
    'course_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _semesterIdMeta = const VerificationMeta(
    'semesterId',
  );
  @override
  late final GeneratedColumn<int> semesterId = GeneratedColumn<int>(
    'semester_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _permissionsJsonMeta = const VerificationMeta(
    'permissionsJson',
  );
  @override
  late final GeneratedColumn<String> permissionsJson = GeneratedColumn<String>(
    'permissions_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _offlineUuidMeta = const VerificationMeta(
    'offlineUuid',
  );
  @override
  late final GeneratedColumn<String> offlineUuid = GeneratedColumn<String>(
    'offline_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _grantedAtMeta = const VerificationMeta(
    'grantedAt',
  );
  @override
  late final GeneratedColumn<DateTime> grantedAt = GeneratedColumn<DateTime>(
    'granted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _revokedAtMeta = const VerificationMeta(
    'revokedAt',
  );
  @override
  late final GeneratedColumn<DateTime> revokedAt = GeneratedColumn<DateTime>(
    'revoked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    courseId,
    semesterId,
    permissionsJson,
    deviceId,
    offlineUuid,
    isActive,
    isDeleted,
    grantedAt,
    revokedAt,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'staff_permissions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StaffPermission> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('semester_id')) {
      context.handle(
        _semesterIdMeta,
        semesterId.isAcceptableOrUnknown(data['semester_id']!, _semesterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_semesterIdMeta);
    }
    if (data.containsKey('permissions_json')) {
      context.handle(
        _permissionsJsonMeta,
        permissionsJson.isAcceptableOrUnknown(
          data['permissions_json']!,
          _permissionsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_permissionsJsonMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('offline_uuid')) {
      context.handle(
        _offlineUuidMeta,
        offlineUuid.isAcceptableOrUnknown(
          data['offline_uuid']!,
          _offlineUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_offlineUuidMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('granted_at')) {
      context.handle(
        _grantedAtMeta,
        grantedAt.isAcceptableOrUnknown(data['granted_at']!, _grantedAtMeta),
      );
    }
    if (data.containsKey('revoked_at')) {
      context.handle(
        _revokedAtMeta,
        revokedAt.isAcceptableOrUnknown(data['revoked_at']!, _revokedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StaffPermission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StaffPermission(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      courseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}course_id'],
      )!,
      semesterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}semester_id'],
      )!,
      permissionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}permissions_json'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      offlineUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}offline_uuid'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      grantedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}granted_at'],
      )!,
      revokedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}revoked_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $StaffPermissionsTable createAlias(String alias) {
    return $StaffPermissionsTable(attachedDatabase, alias);
  }
}

class StaffPermission extends DataClass implements Insertable<StaffPermission> {
  final int id;
  final int userId;
  final int courseId;
  final int semesterId;

  /// Permission bits: can_edit, can_delete, can_view_reports, can_export
  final String permissionsJson;
  final String? deviceId;
  final String offlineUuid;
  final bool isActive;
  final bool isDeleted;
  final DateTime grantedAt;
  final DateTime? revokedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const StaffPermission({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.semesterId,
    required this.permissionsJson,
    this.deviceId,
    required this.offlineUuid,
    required this.isActive,
    required this.isDeleted,
    required this.grantedAt,
    this.revokedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['course_id'] = Variable<int>(courseId);
    map['semester_id'] = Variable<int>(semesterId);
    map['permissions_json'] = Variable<String>(permissionsJson);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['offline_uuid'] = Variable<String>(offlineUuid);
    map['is_active'] = Variable<bool>(isActive);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['granted_at'] = Variable<DateTime>(grantedAt);
    if (!nullToAbsent || revokedAt != null) {
      map['revoked_at'] = Variable<DateTime>(revokedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  StaffPermissionsCompanion toCompanion(bool nullToAbsent) {
    return StaffPermissionsCompanion(
      id: Value(id),
      userId: Value(userId),
      courseId: Value(courseId),
      semesterId: Value(semesterId),
      permissionsJson: Value(permissionsJson),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      offlineUuid: Value(offlineUuid),
      isActive: Value(isActive),
      isDeleted: Value(isDeleted),
      grantedAt: Value(grantedAt),
      revokedAt: revokedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(revokedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory StaffPermission.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StaffPermission(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      courseId: serializer.fromJson<int>(json['courseId']),
      semesterId: serializer.fromJson<int>(json['semesterId']),
      permissionsJson: serializer.fromJson<String>(json['permissionsJson']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      offlineUuid: serializer.fromJson<String>(json['offlineUuid']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      grantedAt: serializer.fromJson<DateTime>(json['grantedAt']),
      revokedAt: serializer.fromJson<DateTime?>(json['revokedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'courseId': serializer.toJson<int>(courseId),
      'semesterId': serializer.toJson<int>(semesterId),
      'permissionsJson': serializer.toJson<String>(permissionsJson),
      'deviceId': serializer.toJson<String?>(deviceId),
      'offlineUuid': serializer.toJson<String>(offlineUuid),
      'isActive': serializer.toJson<bool>(isActive),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'grantedAt': serializer.toJson<DateTime>(grantedAt),
      'revokedAt': serializer.toJson<DateTime?>(revokedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  StaffPermission copyWith({
    int? id,
    int? userId,
    int? courseId,
    int? semesterId,
    String? permissionsJson,
    Value<String?> deviceId = const Value.absent(),
    String? offlineUuid,
    bool? isActive,
    bool? isDeleted,
    DateTime? grantedAt,
    Value<DateTime?> revokedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => StaffPermission(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    courseId: courseId ?? this.courseId,
    semesterId: semesterId ?? this.semesterId,
    permissionsJson: permissionsJson ?? this.permissionsJson,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    offlineUuid: offlineUuid ?? this.offlineUuid,
    isActive: isActive ?? this.isActive,
    isDeleted: isDeleted ?? this.isDeleted,
    grantedAt: grantedAt ?? this.grantedAt,
    revokedAt: revokedAt.present ? revokedAt.value : this.revokedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  StaffPermission copyWithCompanion(StaffPermissionsCompanion data) {
    return StaffPermission(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      semesterId: data.semesterId.present
          ? data.semesterId.value
          : this.semesterId,
      permissionsJson: data.permissionsJson.present
          ? data.permissionsJson.value
          : this.permissionsJson,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      offlineUuid: data.offlineUuid.present
          ? data.offlineUuid.value
          : this.offlineUuid,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      grantedAt: data.grantedAt.present ? data.grantedAt.value : this.grantedAt,
      revokedAt: data.revokedAt.present ? data.revokedAt.value : this.revokedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StaffPermission(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('courseId: $courseId, ')
          ..write('semesterId: $semesterId, ')
          ..write('permissionsJson: $permissionsJson, ')
          ..write('deviceId: $deviceId, ')
          ..write('offlineUuid: $offlineUuid, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('grantedAt: $grantedAt, ')
          ..write('revokedAt: $revokedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    courseId,
    semesterId,
    permissionsJson,
    deviceId,
    offlineUuid,
    isActive,
    isDeleted,
    grantedAt,
    revokedAt,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StaffPermission &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.courseId == this.courseId &&
          other.semesterId == this.semesterId &&
          other.permissionsJson == this.permissionsJson &&
          other.deviceId == this.deviceId &&
          other.offlineUuid == this.offlineUuid &&
          other.isActive == this.isActive &&
          other.isDeleted == this.isDeleted &&
          other.grantedAt == this.grantedAt &&
          other.revokedAt == this.revokedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class StaffPermissionsCompanion extends UpdateCompanion<StaffPermission> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> courseId;
  final Value<int> semesterId;
  final Value<String> permissionsJson;
  final Value<String?> deviceId;
  final Value<String> offlineUuid;
  final Value<bool> isActive;
  final Value<bool> isDeleted;
  final Value<DateTime> grantedAt;
  final Value<DateTime?> revokedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const StaffPermissionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.courseId = const Value.absent(),
    this.semesterId = const Value.absent(),
    this.permissionsJson = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.offlineUuid = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.grantedAt = const Value.absent(),
    this.revokedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  StaffPermissionsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required int courseId,
    required int semesterId,
    required String permissionsJson,
    this.deviceId = const Value.absent(),
    required String offlineUuid,
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.grantedAt = const Value.absent(),
    this.revokedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : userId = Value(userId),
       courseId = Value(courseId),
       semesterId = Value(semesterId),
       permissionsJson = Value(permissionsJson),
       offlineUuid = Value(offlineUuid);
  static Insertable<StaffPermission> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? courseId,
    Expression<int>? semesterId,
    Expression<String>? permissionsJson,
    Expression<String>? deviceId,
    Expression<String>? offlineUuid,
    Expression<bool>? isActive,
    Expression<bool>? isDeleted,
    Expression<DateTime>? grantedAt,
    Expression<DateTime>? revokedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (courseId != null) 'course_id': courseId,
      if (semesterId != null) 'semester_id': semesterId,
      if (permissionsJson != null) 'permissions_json': permissionsJson,
      if (deviceId != null) 'device_id': deviceId,
      if (offlineUuid != null) 'offline_uuid': offlineUuid,
      if (isActive != null) 'is_active': isActive,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (grantedAt != null) 'granted_at': grantedAt,
      if (revokedAt != null) 'revoked_at': revokedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  StaffPermissionsCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<int>? courseId,
    Value<int>? semesterId,
    Value<String>? permissionsJson,
    Value<String?>? deviceId,
    Value<String>? offlineUuid,
    Value<bool>? isActive,
    Value<bool>? isDeleted,
    Value<DateTime>? grantedAt,
    Value<DateTime?>? revokedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return StaffPermissionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      semesterId: semesterId ?? this.semesterId,
      permissionsJson: permissionsJson ?? this.permissionsJson,
      deviceId: deviceId ?? this.deviceId,
      offlineUuid: offlineUuid ?? this.offlineUuid,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      grantedAt: grantedAt ?? this.grantedAt,
      revokedAt: revokedAt ?? this.revokedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<int>(courseId.value);
    }
    if (semesterId.present) {
      map['semester_id'] = Variable<int>(semesterId.value);
    }
    if (permissionsJson.present) {
      map['permissions_json'] = Variable<String>(permissionsJson.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (offlineUuid.present) {
      map['offline_uuid'] = Variable<String>(offlineUuid.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (grantedAt.present) {
      map['granted_at'] = Variable<DateTime>(grantedAt.value);
    }
    if (revokedAt.present) {
      map['revoked_at'] = Variable<DateTime>(revokedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StaffPermissionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('courseId: $courseId, ')
          ..write('semesterId: $semesterId, ')
          ..write('permissionsJson: $permissionsJson, ')
          ..write('deviceId: $deviceId, ')
          ..write('offlineUuid: $offlineUuid, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('grantedAt: $grantedAt, ')
          ..write('revokedAt: $revokedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $QrMappingsTable extends QrMappings
    with TableInfo<$QrMappingsTable, QrMapping> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QrMappingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qrPayloadMeta = const VerificationMeta(
    'qrPayload',
  );
  @override
  late final GeneratedColumn<String> qrPayload = GeneratedColumn<String>(
    'qr_payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qrHashMeta = const VerificationMeta('qrHash');
  @override
  late final GeneratedColumn<String> qrHash = GeneratedColumn<String>(
    'qr_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastUsedAtMeta = const VerificationMeta(
    'lastUsedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsedAt = GeneratedColumn<DateTime>(
    'last_used_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usageCountMeta = const VerificationMeta(
    'usageCount',
  );
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
    'usage_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    studentId,
    qrPayload,
    qrHash,
    deviceId,
    generatedAt,
    expiresAt,
    isActive,
    isDeleted,
    lastUsedAt,
    usageCount,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'qr_mappings';
  @override
  VerificationContext validateIntegrity(
    Insertable<QrMapping> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('qr_payload')) {
      context.handle(
        _qrPayloadMeta,
        qrPayload.isAcceptableOrUnknown(data['qr_payload']!, _qrPayloadMeta),
      );
    } else if (isInserting) {
      context.missing(_qrPayloadMeta);
    }
    if (data.containsKey('qr_hash')) {
      context.handle(
        _qrHashMeta,
        qrHash.isAcceptableOrUnknown(data['qr_hash']!, _qrHashMeta),
      );
    } else if (isInserting) {
      context.missing(_qrHashMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
        _lastUsedAtMeta,
        lastUsedAt.isAcceptableOrUnknown(
          data['last_used_at']!,
          _lastUsedAtMeta,
        ),
      );
    }
    if (data.containsKey('usage_count')) {
      context.handle(
        _usageCountMeta,
        usageCount.isAcceptableOrUnknown(data['usage_count']!, _usageCountMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {qrPayload},
    {qrHash},
  ];
  @override
  QrMapping map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QrMapping(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}student_id'],
      )!,
      qrPayload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qr_payload'],
      )!,
      qrHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qr_hash'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      lastUsedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used_at'],
      ),
      usageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $QrMappingsTable createAlias(String alias) {
    return $QrMappingsTable(attachedDatabase, alias);
  }
}

class QrMapping extends DataClass implements Insertable<QrMapping> {
  final int id;
  final int studentId;
  final String qrPayload;
  final String qrHash;
  final String deviceId;
  final DateTime generatedAt;
  final DateTime expiresAt;
  final bool isActive;
  final bool isDeleted;
  final DateTime? lastUsedAt;
  final int usageCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const QrMapping({
    required this.id,
    required this.studentId,
    required this.qrPayload,
    required this.qrHash,
    required this.deviceId,
    required this.generatedAt,
    required this.expiresAt,
    required this.isActive,
    required this.isDeleted,
    this.lastUsedAt,
    required this.usageCount,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['qr_payload'] = Variable<String>(qrPayload);
    map['qr_hash'] = Variable<String>(qrHash);
    map['device_id'] = Variable<String>(deviceId);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    map['is_active'] = Variable<bool>(isActive);
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || lastUsedAt != null) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt);
    }
    map['usage_count'] = Variable<int>(usageCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  QrMappingsCompanion toCompanion(bool nullToAbsent) {
    return QrMappingsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      qrPayload: Value(qrPayload),
      qrHash: Value(qrHash),
      deviceId: Value(deviceId),
      generatedAt: Value(generatedAt),
      expiresAt: Value(expiresAt),
      isActive: Value(isActive),
      isDeleted: Value(isDeleted),
      lastUsedAt: lastUsedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsedAt),
      usageCount: Value(usageCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory QrMapping.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QrMapping(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      qrPayload: serializer.fromJson<String>(json['qrPayload']),
      qrHash: serializer.fromJson<String>(json['qrHash']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      lastUsedAt: serializer.fromJson<DateTime?>(json['lastUsedAt']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'qrPayload': serializer.toJson<String>(qrPayload),
      'qrHash': serializer.toJson<String>(qrHash),
      'deviceId': serializer.toJson<String>(deviceId),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'isActive': serializer.toJson<bool>(isActive),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'lastUsedAt': serializer.toJson<DateTime?>(lastUsedAt),
      'usageCount': serializer.toJson<int>(usageCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  QrMapping copyWith({
    int? id,
    int? studentId,
    String? qrPayload,
    String? qrHash,
    String? deviceId,
    DateTime? generatedAt,
    DateTime? expiresAt,
    bool? isActive,
    bool? isDeleted,
    Value<DateTime?> lastUsedAt = const Value.absent(),
    int? usageCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => QrMapping(
    id: id ?? this.id,
    studentId: studentId ?? this.studentId,
    qrPayload: qrPayload ?? this.qrPayload,
    qrHash: qrHash ?? this.qrHash,
    deviceId: deviceId ?? this.deviceId,
    generatedAt: generatedAt ?? this.generatedAt,
    expiresAt: expiresAt ?? this.expiresAt,
    isActive: isActive ?? this.isActive,
    isDeleted: isDeleted ?? this.isDeleted,
    lastUsedAt: lastUsedAt.present ? lastUsedAt.value : this.lastUsedAt,
    usageCount: usageCount ?? this.usageCount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  QrMapping copyWithCompanion(QrMappingsCompanion data) {
    return QrMapping(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      qrPayload: data.qrPayload.present ? data.qrPayload.value : this.qrPayload,
      qrHash: data.qrHash.present ? data.qrHash.value : this.qrHash,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      lastUsedAt: data.lastUsedAt.present
          ? data.lastUsedAt.value
          : this.lastUsedAt,
      usageCount: data.usageCount.present
          ? data.usageCount.value
          : this.usageCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QrMapping(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('qrPayload: $qrPayload, ')
          ..write('qrHash: $qrHash, ')
          ..write('deviceId: $deviceId, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('usageCount: $usageCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    studentId,
    qrPayload,
    qrHash,
    deviceId,
    generatedAt,
    expiresAt,
    isActive,
    isDeleted,
    lastUsedAt,
    usageCount,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QrMapping &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.qrPayload == this.qrPayload &&
          other.qrHash == this.qrHash &&
          other.deviceId == this.deviceId &&
          other.generatedAt == this.generatedAt &&
          other.expiresAt == this.expiresAt &&
          other.isActive == this.isActive &&
          other.isDeleted == this.isDeleted &&
          other.lastUsedAt == this.lastUsedAt &&
          other.usageCount == this.usageCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class QrMappingsCompanion extends UpdateCompanion<QrMapping> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<String> qrPayload;
  final Value<String> qrHash;
  final Value<String> deviceId;
  final Value<DateTime> generatedAt;
  final Value<DateTime> expiresAt;
  final Value<bool> isActive;
  final Value<bool> isDeleted;
  final Value<DateTime?> lastUsedAt;
  final Value<int> usageCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const QrMappingsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.qrPayload = const Value.absent(),
    this.qrHash = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  QrMappingsCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required String qrPayload,
    required String qrHash,
    required String deviceId,
    this.generatedAt = const Value.absent(),
    required DateTime expiresAt,
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  }) : studentId = Value(studentId),
       qrPayload = Value(qrPayload),
       qrHash = Value(qrHash),
       deviceId = Value(deviceId),
       expiresAt = Value(expiresAt);
  static Insertable<QrMapping> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<String>? qrPayload,
    Expression<String>? qrHash,
    Expression<String>? deviceId,
    Expression<DateTime>? generatedAt,
    Expression<DateTime>? expiresAt,
    Expression<bool>? isActive,
    Expression<bool>? isDeleted,
    Expression<DateTime>? lastUsedAt,
    Expression<int>? usageCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (qrPayload != null) 'qr_payload': qrPayload,
      if (qrHash != null) 'qr_hash': qrHash,
      if (deviceId != null) 'device_id': deviceId,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (isActive != null) 'is_active': isActive,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
      if (usageCount != null) 'usage_count': usageCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  QrMappingsCompanion copyWith({
    Value<int>? id,
    Value<int>? studentId,
    Value<String>? qrPayload,
    Value<String>? qrHash,
    Value<String>? deviceId,
    Value<DateTime>? generatedAt,
    Value<DateTime>? expiresAt,
    Value<bool>? isActive,
    Value<bool>? isDeleted,
    Value<DateTime?>? lastUsedAt,
    Value<int>? usageCount,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
  }) {
    return QrMappingsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      qrPayload: qrPayload ?? this.qrPayload,
      qrHash: qrHash ?? this.qrHash,
      deviceId: deviceId ?? this.deviceId,
      generatedAt: generatedAt ?? this.generatedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      usageCount: usageCount ?? this.usageCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (qrPayload.present) {
      map['qr_payload'] = Variable<String>(qrPayload.value);
    }
    if (qrHash.present) {
      map['qr_hash'] = Variable<String>(qrHash.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QrMappingsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('qrPayload: $qrPayload, ')
          ..write('qrHash: $qrHash, ')
          ..write('deviceId: $deviceId, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('usageCount: $usageCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AttendanceDatabase extends GeneratedDatabase {
  _$AttendanceDatabase(QueryExecutor e) : super(e);
  $AttendanceDatabaseManager get managers => $AttendanceDatabaseManager(this);
  late final $AttendancesTable attendances = $AttendancesTable(this);
  late final $SyncQueuesTable syncQueues = $SyncQueuesTable(this);
  late final $CoursesCachesTable coursesCaches = $CoursesCachesTable(this);
  late final $StudentsCachesTable studentsCaches = $StudentsCachesTable(this);
  late final $SessionSnapshotsTable sessionSnapshots = $SessionSnapshotsTable(
    this,
  );
  late final $StudentAttendanceStatusesTable studentAttendanceStatuses =
      $StudentAttendanceStatusesTable(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $CoursesTable courses = $CoursesTable(this);
  late final $SchedulesTable schedules = $SchedulesTable(this);
  late final $AttendanceSessionsTable attendanceSessions =
      $AttendanceSessionsTable(this);
  late final $StaffPermissionsTable staffPermissions = $StaffPermissionsTable(
    this,
  );
  late final $QrMappingsTable qrMappings = $QrMappingsTable(this);
  late final Index idxAttendancesStudent = Index(
    'idx_attendances_student',
    'CREATE INDEX idx_attendances_student ON attendances (student_id)',
  );
  late final Index idxAttendancesDate = Index(
    'idx_attendances_date',
    'CREATE INDEX idx_attendances_date ON attendances (attendance_date)',
  );
  late final Index idxAttendancesCourseSession = Index(
    'idx_attendances_course_session',
    'CREATE INDEX idx_attendances_course_session ON attendances (course_id, session_id)',
  );
  late final Index idxAttendancesPending = Index(
    'idx_attendances_pending',
    'CREATE INDEX idx_attendances_pending ON attendances (pending_sync)',
  );
  late final Index idxAttendancesSessionStudent = Index(
    'idx_attendances_session_student',
    'CREATE INDEX idx_attendances_session_student ON attendances (attendance_session_id, student_id)',
  );
  late final Index idxAttendancesOfflineUuid = Index(
    'idx_attendances_offline_uuid',
    'CREATE INDEX idx_attendances_offline_uuid ON attendances (offline_uuid)',
  );
  late final Index idxAttendancesDeviceStudent = Index(
    'idx_attendances_device_student',
    'CREATE INDEX idx_attendances_device_student ON attendances (device_id, student_id)',
  );
  late final Index idxSyncQueuesStatus = Index(
    'idx_sync_queues_status',
    'CREATE INDEX idx_sync_queues_status ON sync_queues (sync_status)',
  );
  late final Index idxSyncQueuesCreated = Index(
    'idx_sync_queues_created',
    'CREATE INDEX idx_sync_queues_created ON sync_queues (created_at)',
  );
  late final Index idxSyncQueuesEntity = Index(
    'idx_sync_queues_entity',
    'CREATE INDEX idx_sync_queues_entity ON sync_queues (entity_type, entity_id)',
  );
  late final Index idxSyncQueuesDevicePriority = Index(
    'idx_sync_queues_device_priority',
    'CREATE INDEX idx_sync_queues_device_priority ON sync_queues (device_id, priority)',
  );
  late final Index idxSyncQueuesNextRetry = Index(
    'idx_sync_queues_next_retry',
    'CREATE INDEX idx_sync_queues_next_retry ON sync_queues (next_retry_at)',
  );
  late final Index idxCoursesCacheSemesterTeacher = Index(
    'idx_courses_cache_semester_teacher',
    'CREATE INDEX idx_courses_cache_semester_teacher ON courses_caches (semester_id, teacher_id)',
  );
  late final Index idxStudentsCacheSlot = Index(
    'idx_students_cache_slot',
    'CREATE INDEX idx_students_cache_slot ON students_caches (slot_context_id)',
  );
  late final Index idxSessionSlotDate = Index(
    'idx_session_slot_date',
    'CREATE INDEX idx_session_slot_date ON session_snapshots (schedule_slot_id, attendance_date)',
  );
  late final Index idxStudentsQr = Index(
    'idx_students_qr',
    'CREATE INDEX idx_students_qr ON students (qr_code)',
  );
  late final Index idxStudentsUniversityProgram = Index(
    'idx_students_university_program',
    'CREATE INDEX idx_students_university_program ON students (university_id, program_id)',
  );
  late final Index idxCoursesUniversity = Index(
    'idx_courses_university',
    'CREATE INDEX idx_courses_university ON courses (university_id, course_code)',
  );
  late final Index idxCoursesProgramSemester = Index(
    'idx_courses_program_semester',
    'CREATE INDEX idx_courses_program_semester ON courses (program_id, semester_id)',
  );
  late final Index idxSchedulesCourseDay = Index(
    'idx_schedules_course_day',
    'CREATE INDEX idx_schedules_course_day ON schedules (course_id, day_of_week)',
  );
  late final Index idxSchedulesSlot = Index(
    'idx_schedules_slot',
    'CREATE INDEX idx_schedules_slot ON schedules (university_slot_id)',
  );
  late final Index idxSchedulesFaculty = Index(
    'idx_schedules_faculty',
    'CREATE INDEX idx_schedules_faculty ON schedules (faculty_member_id, semester_id)',
  );
  late final Index idxAttendanceSessionsSlotDate = Index(
    'idx_attendance_sessions_slot_date',
    'CREATE INDEX idx_attendance_sessions_slot_date ON attendance_sessions (schedule_slot_id, session_date)',
  );
  late final Index idxAttendanceSessionsFaculty = Index(
    'idx_attendance_sessions_faculty',
    'CREATE INDEX idx_attendance_sessions_faculty ON attendance_sessions (faculty_member_id, session_date)',
  );
  late final Index idxAttendanceSessionsMode = Index(
    'idx_attendance_sessions_mode',
    'CREATE INDEX idx_attendance_sessions_mode ON attendance_sessions (attendance_mode)',
  );
  late final Index idxStaffPermissionsUser = Index(
    'idx_staff_permissions_user',
    'CREATE INDEX idx_staff_permissions_user ON staff_permissions (user_id)',
  );
  late final Index idxStaffPermissionsCourse = Index(
    'idx_staff_permissions_course',
    'CREATE INDEX idx_staff_permissions_course ON staff_permissions (course_id)',
  );
  late final Index idxStaffPermissionsSemester = Index(
    'idx_staff_permissions_semester',
    'CREATE INDEX idx_staff_permissions_semester ON staff_permissions (semester_id)',
  );
  late final Index idxQrMappingsStudent = Index(
    'idx_qr_mappings_student',
    'CREATE INDEX idx_qr_mappings_student ON qr_mappings (student_id)',
  );
  late final Index idxQrMappingsActive = Index(
    'idx_qr_mappings_active',
    'CREATE INDEX idx_qr_mappings_active ON qr_mappings (is_active, expires_at)',
  );
  late final Index idxQrMappingsDevice = Index(
    'idx_qr_mappings_device',
    'CREATE INDEX idx_qr_mappings_device ON qr_mappings (device_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    attendances,
    syncQueues,
    coursesCaches,
    studentsCaches,
    sessionSnapshots,
    studentAttendanceStatuses,
    students,
    courses,
    schedules,
    attendanceSessions,
    staffPermissions,
    qrMappings,
    idxAttendancesStudent,
    idxAttendancesDate,
    idxAttendancesCourseSession,
    idxAttendancesPending,
    idxAttendancesSessionStudent,
    idxAttendancesOfflineUuid,
    idxAttendancesDeviceStudent,
    idxSyncQueuesStatus,
    idxSyncQueuesCreated,
    idxSyncQueuesEntity,
    idxSyncQueuesDevicePriority,
    idxSyncQueuesNextRetry,
    idxCoursesCacheSemesterTeacher,
    idxStudentsCacheSlot,
    idxSessionSlotDate,
    idxStudentsQr,
    idxStudentsUniversityProgram,
    idxCoursesUniversity,
    idxCoursesProgramSemester,
    idxSchedulesCourseDay,
    idxSchedulesSlot,
    idxSchedulesFaculty,
    idxAttendanceSessionsSlotDate,
    idxAttendanceSessionsFaculty,
    idxAttendanceSessionsMode,
    idxStaffPermissionsUser,
    idxStaffPermissionsCourse,
    idxStaffPermissionsSemester,
    idxQrMappingsStudent,
    idxQrMappingsActive,
    idxQrMappingsDevice,
  ];
}

typedef $$AttendancesTableCreateCompanionBuilder =
    AttendancesCompanion Function({
      Value<int> id,
      required int studentId,
      required int courseId,
      required int sessionId,
      Value<int?> attendanceSessionId,
      required DateTime attendanceDate,
      required String status,
      required String offlineUuid,
      required String deviceId,
      Value<bool> isSynced,
      Value<bool> pendingSync,
      Value<String?> syncError,
      Value<bool> isDeleted,
      Value<String?> verificationMethod,
      Value<String?> verifiedBy,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<DateTime?> syncedAt,
    });
typedef $$AttendancesTableUpdateCompanionBuilder =
    AttendancesCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<int> courseId,
      Value<int> sessionId,
      Value<int?> attendanceSessionId,
      Value<DateTime> attendanceDate,
      Value<String> status,
      Value<String> offlineUuid,
      Value<String> deviceId,
      Value<bool> isSynced,
      Value<bool> pendingSync,
      Value<String?> syncError,
      Value<bool> isDeleted,
      Value<String?> verificationMethod,
      Value<String?> verifiedBy,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<DateTime?> syncedAt,
    });

class $$AttendancesTableFilterComposer
    extends Composer<_$AttendanceDatabase, $AttendancesTable> {
  $$AttendancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get courseId => $composableBuilder(
    column: $table.courseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attendanceSessionId => $composableBuilder(
    column: $table.attendanceSessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get attendanceDate => $composableBuilder(
    column: $table.attendanceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get offlineUuid => $composableBuilder(
    column: $table.offlineUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verificationMethod => $composableBuilder(
    column: $table.verificationMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verifiedBy => $composableBuilder(
    column: $table.verifiedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttendancesTableOrderingComposer
    extends Composer<_$AttendanceDatabase, $AttendancesTable> {
  $$AttendancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get courseId => $composableBuilder(
    column: $table.courseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attendanceSessionId => $composableBuilder(
    column: $table.attendanceSessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get attendanceDate => $composableBuilder(
    column: $table.attendanceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get offlineUuid => $composableBuilder(
    column: $table.offlineUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verificationMethod => $composableBuilder(
    column: $table.verificationMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verifiedBy => $composableBuilder(
    column: $table.verifiedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttendancesTableAnnotationComposer
    extends Composer<_$AttendanceDatabase, $AttendancesTable> {
  $$AttendancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<int> get courseId =>
      $composableBuilder(column: $table.courseId, builder: (column) => column);

  GeneratedColumn<int> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get attendanceSessionId => $composableBuilder(
    column: $table.attendanceSessionId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get attendanceDate => $composableBuilder(
    column: $table.attendanceDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get offlineUuid => $composableBuilder(
    column: $table.offlineUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncError =>
      $composableBuilder(column: $table.syncError, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get verificationMethod => $composableBuilder(
    column: $table.verificationMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get verifiedBy => $composableBuilder(
    column: $table.verifiedBy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$AttendancesTableTableManager
    extends
        RootTableManager<
          _$AttendanceDatabase,
          $AttendancesTable,
          Attendance,
          $$AttendancesTableFilterComposer,
          $$AttendancesTableOrderingComposer,
          $$AttendancesTableAnnotationComposer,
          $$AttendancesTableCreateCompanionBuilder,
          $$AttendancesTableUpdateCompanionBuilder,
          (
            Attendance,
            BaseReferences<_$AttendanceDatabase, $AttendancesTable, Attendance>,
          ),
          Attendance,
          PrefetchHooks Function()
        > {
  $$AttendancesTableTableManager(
    _$AttendanceDatabase db,
    $AttendancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<int> courseId = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int?> attendanceSessionId = const Value.absent(),
                Value<DateTime> attendanceDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> offlineUuid = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> verificationMethod = const Value.absent(),
                Value<String?> verifiedBy = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => AttendancesCompanion(
                id: id,
                studentId: studentId,
                courseId: courseId,
                sessionId: sessionId,
                attendanceSessionId: attendanceSessionId,
                attendanceDate: attendanceDate,
                status: status,
                offlineUuid: offlineUuid,
                deviceId: deviceId,
                isSynced: isSynced,
                pendingSync: pendingSync,
                syncError: syncError,
                isDeleted: isDeleted,
                verificationMethod: verificationMethod,
                verifiedBy: verifiedBy,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                required int courseId,
                required int sessionId,
                Value<int?> attendanceSessionId = const Value.absent(),
                required DateTime attendanceDate,
                required String status,
                required String offlineUuid,
                required String deviceId,
                Value<bool> isSynced = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String?> verificationMethod = const Value.absent(),
                Value<String?> verifiedBy = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => AttendancesCompanion.insert(
                id: id,
                studentId: studentId,
                courseId: courseId,
                sessionId: sessionId,
                attendanceSessionId: attendanceSessionId,
                attendanceDate: attendanceDate,
                status: status,
                offlineUuid: offlineUuid,
                deviceId: deviceId,
                isSynced: isSynced,
                pendingSync: pendingSync,
                syncError: syncError,
                isDeleted: isDeleted,
                verificationMethod: verificationMethod,
                verifiedBy: verifiedBy,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncedAt: syncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttendancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AttendanceDatabase,
      $AttendancesTable,
      Attendance,
      $$AttendancesTableFilterComposer,
      $$AttendancesTableOrderingComposer,
      $$AttendancesTableAnnotationComposer,
      $$AttendancesTableCreateCompanionBuilder,
      $$AttendancesTableUpdateCompanionBuilder,
      (
        Attendance,
        BaseReferences<_$AttendanceDatabase, $AttendancesTable, Attendance>,
      ),
      Attendance,
      PrefetchHooks Function()
    >;
typedef $$SyncQueuesTableCreateCompanionBuilder =
    SyncQueuesCompanion Function({
      Value<int> id,
      required String actionType,
      required String entityType,
      required int entityId,
      required String payloadJson,
      Value<int> priority,
      required String deviceId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<DateTime?> lastRetryAt,
      Value<DateTime?> nextRetryAt,
      Value<DateTime?> syncedAt,
      Value<double?> durationMs,
    });
typedef $$SyncQueuesTableUpdateCompanionBuilder =
    SyncQueuesCompanion Function({
      Value<int> id,
      Value<String> actionType,
      Value<String> entityType,
      Value<int> entityId,
      Value<String> payloadJson,
      Value<int> priority,
      Value<String> deviceId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<DateTime?> lastRetryAt,
      Value<DateTime?> nextRetryAt,
      Value<DateTime?> syncedAt,
      Value<double?> durationMs,
    });

class $$SyncQueuesTableFilterComposer
    extends Composer<_$AttendanceDatabase, $SyncQueuesTable> {
  $$SyncQueuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastRetryAt => $composableBuilder(
    column: $table.lastRetryAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueuesTableOrderingComposer
    extends Composer<_$AttendanceDatabase, $SyncQueuesTable> {
  $$SyncQueuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastRetryAt => $composableBuilder(
    column: $table.lastRetryAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueuesTableAnnotationComposer
    extends Composer<_$AttendanceDatabase, $SyncQueuesTable> {
  $$SyncQueuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRetryAt => $composableBuilder(
    column: $table.lastRetryAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<double> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );
}

class $$SyncQueuesTableTableManager
    extends
        RootTableManager<
          _$AttendanceDatabase,
          $SyncQueuesTable,
          SyncQueue,
          $$SyncQueuesTableFilterComposer,
          $$SyncQueuesTableOrderingComposer,
          $$SyncQueuesTableAnnotationComposer,
          $$SyncQueuesTableCreateCompanionBuilder,
          $$SyncQueuesTableUpdateCompanionBuilder,
          (
            SyncQueue,
            BaseReferences<_$AttendanceDatabase, $SyncQueuesTable, SyncQueue>,
          ),
          SyncQueue,
          PrefetchHooks Function()
        > {
  $$SyncQueuesTableTableManager(_$AttendanceDatabase db, $SyncQueuesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> actionType = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<int> entityId = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> lastRetryAt = const Value.absent(),
                Value<DateTime?> nextRetryAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<double?> durationMs = const Value.absent(),
              }) => SyncQueuesCompanion(
                id: id,
                actionType: actionType,
                entityType: entityType,
                entityId: entityId,
                payloadJson: payloadJson,
                priority: priority,
                deviceId: deviceId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                retryCount: retryCount,
                lastError: lastError,
                lastRetryAt: lastRetryAt,
                nextRetryAt: nextRetryAt,
                syncedAt: syncedAt,
                durationMs: durationMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String actionType,
                required String entityType,
                required int entityId,
                required String payloadJson,
                Value<int> priority = const Value.absent(),
                required String deviceId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> lastRetryAt = const Value.absent(),
                Value<DateTime?> nextRetryAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<double?> durationMs = const Value.absent(),
              }) => SyncQueuesCompanion.insert(
                id: id,
                actionType: actionType,
                entityType: entityType,
                entityId: entityId,
                payloadJson: payloadJson,
                priority: priority,
                deviceId: deviceId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                retryCount: retryCount,
                lastError: lastError,
                lastRetryAt: lastRetryAt,
                nextRetryAt: nextRetryAt,
                syncedAt: syncedAt,
                durationMs: durationMs,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AttendanceDatabase,
      $SyncQueuesTable,
      SyncQueue,
      $$SyncQueuesTableFilterComposer,
      $$SyncQueuesTableOrderingComposer,
      $$SyncQueuesTableAnnotationComposer,
      $$SyncQueuesTableCreateCompanionBuilder,
      $$SyncQueuesTableUpdateCompanionBuilder,
      (
        SyncQueue,
        BaseReferences<_$AttendanceDatabase, $SyncQueuesTable, SyncQueue>,
      ),
      SyncQueue,
      PrefetchHooks Function()
    >;
typedef $$CoursesCachesTableCreateCompanionBuilder =
    CoursesCachesCompanion Function({
      Value<int> id,
      required int semesterId,
      required int teacherId,
      required String cacheKey,
      required String payloadJson,
      Value<DateTime> updatedAt,
    });
typedef $$CoursesCachesTableUpdateCompanionBuilder =
    CoursesCachesCompanion Function({
      Value<int> id,
      Value<int> semesterId,
      Value<int> teacherId,
      Value<String> cacheKey,
      Value<String> payloadJson,
      Value<DateTime> updatedAt,
    });

class $$CoursesCachesTableFilterComposer
    extends Composer<_$AttendanceDatabase, $CoursesCachesTable> {
  $$CoursesCachesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get semesterId => $composableBuilder(
    column: $table.semesterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teacherId => $composableBuilder(
    column: $table.teacherId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CoursesCachesTableOrderingComposer
    extends Composer<_$AttendanceDatabase, $CoursesCachesTable> {
  $$CoursesCachesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get semesterId => $composableBuilder(
    column: $table.semesterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teacherId => $composableBuilder(
    column: $table.teacherId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoursesCachesTableAnnotationComposer
    extends Composer<_$AttendanceDatabase, $CoursesCachesTable> {
  $$CoursesCachesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get semesterId => $composableBuilder(
    column: $table.semesterId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get teacherId =>
      $composableBuilder(column: $table.teacherId, builder: (column) => column);

  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CoursesCachesTableTableManager
    extends
        RootTableManager<
          _$AttendanceDatabase,
          $CoursesCachesTable,
          CoursesCache,
          $$CoursesCachesTableFilterComposer,
          $$CoursesCachesTableOrderingComposer,
          $$CoursesCachesTableAnnotationComposer,
          $$CoursesCachesTableCreateCompanionBuilder,
          $$CoursesCachesTableUpdateCompanionBuilder,
          (
            CoursesCache,
            BaseReferences<
              _$AttendanceDatabase,
              $CoursesCachesTable,
              CoursesCache
            >,
          ),
          CoursesCache,
          PrefetchHooks Function()
        > {
  $$CoursesCachesTableTableManager(
    _$AttendanceDatabase db,
    $CoursesCachesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoursesCachesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoursesCachesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoursesCachesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> semesterId = const Value.absent(),
                Value<int> teacherId = const Value.absent(),
                Value<String> cacheKey = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CoursesCachesCompanion(
                id: id,
                semesterId: semesterId,
                teacherId: teacherId,
                cacheKey: cacheKey,
                payloadJson: payloadJson,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int semesterId,
                required int teacherId,
                required String cacheKey,
                required String payloadJson,
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CoursesCachesCompanion.insert(
                id: id,
                semesterId: semesterId,
                teacherId: teacherId,
                cacheKey: cacheKey,
                payloadJson: payloadJson,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CoursesCachesTableProcessedTableManager =
    ProcessedTableManager<
      _$AttendanceDatabase,
      $CoursesCachesTable,
      CoursesCache,
      $$CoursesCachesTableFilterComposer,
      $$CoursesCachesTableOrderingComposer,
      $$CoursesCachesTableAnnotationComposer,
      $$CoursesCachesTableCreateCompanionBuilder,
      $$CoursesCachesTableUpdateCompanionBuilder,
      (
        CoursesCache,
        BaseReferences<_$AttendanceDatabase, $CoursesCachesTable, CoursesCache>,
      ),
      CoursesCache,
      PrefetchHooks Function()
    >;
typedef $$StudentsCachesTableCreateCompanionBuilder =
    StudentsCachesCompanion Function({
      Value<int> id,
      required int slotContextId,
      required String cacheKey,
      required String payloadJson,
      Value<DateTime> updatedAt,
    });
typedef $$StudentsCachesTableUpdateCompanionBuilder =
    StudentsCachesCompanion Function({
      Value<int> id,
      Value<int> slotContextId,
      Value<String> cacheKey,
      Value<String> payloadJson,
      Value<DateTime> updatedAt,
    });

class $$StudentsCachesTableFilterComposer
    extends Composer<_$AttendanceDatabase, $StudentsCachesTable> {
  $$StudentsCachesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get slotContextId => $composableBuilder(
    column: $table.slotContextId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudentsCachesTableOrderingComposer
    extends Composer<_$AttendanceDatabase, $StudentsCachesTable> {
  $$StudentsCachesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get slotContextId => $composableBuilder(
    column: $table.slotContextId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudentsCachesTableAnnotationComposer
    extends Composer<_$AttendanceDatabase, $StudentsCachesTable> {
  $$StudentsCachesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get slotContextId => $composableBuilder(
    column: $table.slotContextId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StudentsCachesTableTableManager
    extends
        RootTableManager<
          _$AttendanceDatabase,
          $StudentsCachesTable,
          StudentsCache,
          $$StudentsCachesTableFilterComposer,
          $$StudentsCachesTableOrderingComposer,
          $$StudentsCachesTableAnnotationComposer,
          $$StudentsCachesTableCreateCompanionBuilder,
          $$StudentsCachesTableUpdateCompanionBuilder,
          (
            StudentsCache,
            BaseReferences<
              _$AttendanceDatabase,
              $StudentsCachesTable,
              StudentsCache
            >,
          ),
          StudentsCache,
          PrefetchHooks Function()
        > {
  $$StudentsCachesTableTableManager(
    _$AttendanceDatabase db,
    $StudentsCachesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsCachesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsCachesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsCachesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> slotContextId = const Value.absent(),
                Value<String> cacheKey = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StudentsCachesCompanion(
                id: id,
                slotContextId: slotContextId,
                cacheKey: cacheKey,
                payloadJson: payloadJson,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int slotContextId,
                required String cacheKey,
                required String payloadJson,
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StudentsCachesCompanion.insert(
                id: id,
                slotContextId: slotContextId,
                cacheKey: cacheKey,
                payloadJson: payloadJson,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudentsCachesTableProcessedTableManager =
    ProcessedTableManager<
      _$AttendanceDatabase,
      $StudentsCachesTable,
      StudentsCache,
      $$StudentsCachesTableFilterComposer,
      $$StudentsCachesTableOrderingComposer,
      $$StudentsCachesTableAnnotationComposer,
      $$StudentsCachesTableCreateCompanionBuilder,
      $$StudentsCachesTableUpdateCompanionBuilder,
      (
        StudentsCache,
        BaseReferences<
          _$AttendanceDatabase,
          $StudentsCachesTable,
          StudentsCache
        >,
      ),
      StudentsCache,
      PrefetchHooks Function()
    >;
typedef $$SessionSnapshotsTableCreateCompanionBuilder =
    SessionSnapshotsCompanion Function({
      Value<int> id,
      required String cacheKey,
      required int scheduleSlotId,
      required DateTime attendanceDate,
      required String payloadJson,
      Value<DateTime> updatedAt,
    });
typedef $$SessionSnapshotsTableUpdateCompanionBuilder =
    SessionSnapshotsCompanion Function({
      Value<int> id,
      Value<String> cacheKey,
      Value<int> scheduleSlotId,
      Value<DateTime> attendanceDate,
      Value<String> payloadJson,
      Value<DateTime> updatedAt,
    });

class $$SessionSnapshotsTableFilterComposer
    extends Composer<_$AttendanceDatabase, $SessionSnapshotsTable> {
  $$SessionSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduleSlotId => $composableBuilder(
    column: $table.scheduleSlotId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get attendanceDate => $composableBuilder(
    column: $table.attendanceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionSnapshotsTableOrderingComposer
    extends Composer<_$AttendanceDatabase, $SessionSnapshotsTable> {
  $$SessionSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduleSlotId => $composableBuilder(
    column: $table.scheduleSlotId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get attendanceDate => $composableBuilder(
    column: $table.attendanceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionSnapshotsTableAnnotationComposer
    extends Composer<_$AttendanceDatabase, $SessionSnapshotsTable> {
  $$SessionSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<int> get scheduleSlotId => $composableBuilder(
    column: $table.scheduleSlotId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get attendanceDate => $composableBuilder(
    column: $table.attendanceDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SessionSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AttendanceDatabase,
          $SessionSnapshotsTable,
          SessionSnapshot,
          $$SessionSnapshotsTableFilterComposer,
          $$SessionSnapshotsTableOrderingComposer,
          $$SessionSnapshotsTableAnnotationComposer,
          $$SessionSnapshotsTableCreateCompanionBuilder,
          $$SessionSnapshotsTableUpdateCompanionBuilder,
          (
            SessionSnapshot,
            BaseReferences<
              _$AttendanceDatabase,
              $SessionSnapshotsTable,
              SessionSnapshot
            >,
          ),
          SessionSnapshot,
          PrefetchHooks Function()
        > {
  $$SessionSnapshotsTableTableManager(
    _$AttendanceDatabase db,
    $SessionSnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionSnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> cacheKey = const Value.absent(),
                Value<int> scheduleSlotId = const Value.absent(),
                Value<DateTime> attendanceDate = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SessionSnapshotsCompanion(
                id: id,
                cacheKey: cacheKey,
                scheduleSlotId: scheduleSlotId,
                attendanceDate: attendanceDate,
                payloadJson: payloadJson,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String cacheKey,
                required int scheduleSlotId,
                required DateTime attendanceDate,
                required String payloadJson,
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SessionSnapshotsCompanion.insert(
                id: id,
                cacheKey: cacheKey,
                scheduleSlotId: scheduleSlotId,
                attendanceDate: attendanceDate,
                payloadJson: payloadJson,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AttendanceDatabase,
      $SessionSnapshotsTable,
      SessionSnapshot,
      $$SessionSnapshotsTableFilterComposer,
      $$SessionSnapshotsTableOrderingComposer,
      $$SessionSnapshotsTableAnnotationComposer,
      $$SessionSnapshotsTableCreateCompanionBuilder,
      $$SessionSnapshotsTableUpdateCompanionBuilder,
      (
        SessionSnapshot,
        BaseReferences<
          _$AttendanceDatabase,
          $SessionSnapshotsTable,
          SessionSnapshot
        >,
      ),
      SessionSnapshot,
      PrefetchHooks Function()
    >;
typedef $$StudentAttendanceStatusesTableCreateCompanionBuilder =
    StudentAttendanceStatusesCompanion Function({
      Value<int> id,
      required String cacheKey,
      required int studentId,
      required String payloadJson,
      Value<DateTime> updatedAt,
    });
typedef $$StudentAttendanceStatusesTableUpdateCompanionBuilder =
    StudentAttendanceStatusesCompanion Function({
      Value<int> id,
      Value<String> cacheKey,
      Value<int> studentId,
      Value<String> payloadJson,
      Value<DateTime> updatedAt,
    });

class $$StudentAttendanceStatusesTableFilterComposer
    extends Composer<_$AttendanceDatabase, $StudentAttendanceStatusesTable> {
  $$StudentAttendanceStatusesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudentAttendanceStatusesTableOrderingComposer
    extends Composer<_$AttendanceDatabase, $StudentAttendanceStatusesTable> {
  $$StudentAttendanceStatusesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudentAttendanceStatusesTableAnnotationComposer
    extends Composer<_$AttendanceDatabase, $StudentAttendanceStatusesTable> {
  $$StudentAttendanceStatusesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StudentAttendanceStatusesTableTableManager
    extends
        RootTableManager<
          _$AttendanceDatabase,
          $StudentAttendanceStatusesTable,
          StudentAttendanceStatuse,
          $$StudentAttendanceStatusesTableFilterComposer,
          $$StudentAttendanceStatusesTableOrderingComposer,
          $$StudentAttendanceStatusesTableAnnotationComposer,
          $$StudentAttendanceStatusesTableCreateCompanionBuilder,
          $$StudentAttendanceStatusesTableUpdateCompanionBuilder,
          (
            StudentAttendanceStatuse,
            BaseReferences<
              _$AttendanceDatabase,
              $StudentAttendanceStatusesTable,
              StudentAttendanceStatuse
            >,
          ),
          StudentAttendanceStatuse,
          PrefetchHooks Function()
        > {
  $$StudentAttendanceStatusesTableTableManager(
    _$AttendanceDatabase db,
    $StudentAttendanceStatusesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentAttendanceStatusesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$StudentAttendanceStatusesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudentAttendanceStatusesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> cacheKey = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StudentAttendanceStatusesCompanion(
                id: id,
                cacheKey: cacheKey,
                studentId: studentId,
                payloadJson: payloadJson,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String cacheKey,
                required int studentId,
                required String payloadJson,
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StudentAttendanceStatusesCompanion.insert(
                id: id,
                cacheKey: cacheKey,
                studentId: studentId,
                payloadJson: payloadJson,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudentAttendanceStatusesTableProcessedTableManager =
    ProcessedTableManager<
      _$AttendanceDatabase,
      $StudentAttendanceStatusesTable,
      StudentAttendanceStatuse,
      $$StudentAttendanceStatusesTableFilterComposer,
      $$StudentAttendanceStatusesTableOrderingComposer,
      $$StudentAttendanceStatusesTableAnnotationComposer,
      $$StudentAttendanceStatusesTableCreateCompanionBuilder,
      $$StudentAttendanceStatusesTableUpdateCompanionBuilder,
      (
        StudentAttendanceStatuse,
        BaseReferences<
          _$AttendanceDatabase,
          $StudentAttendanceStatusesTable,
          StudentAttendanceStatuse
        >,
      ),
      StudentAttendanceStatuse,
      PrefetchHooks Function()
    >;
typedef $$StudentsTableCreateCompanionBuilder =
    StudentsCompanion Function({
      Value<int> id,
      required String universityStudentId,
      required String qrCode,
      required String fullName,
      Value<String?> email,
      Value<String?> phone,
      required int universityId,
      required int programId,
      Value<int?> currentSemester,
      Value<String?> deviceId,
      required String offlineUuid,
      Value<bool> isActive,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<DateTime?> lastSeenAt,
    });
typedef $$StudentsTableUpdateCompanionBuilder =
    StudentsCompanion Function({
      Value<int> id,
      Value<String> universityStudentId,
      Value<String> qrCode,
      Value<String> fullName,
      Value<String?> email,
      Value<String?> phone,
      Value<int> universityId,
      Value<int> programId,
      Value<int?> currentSemester,
      Value<String?> deviceId,
      Value<String> offlineUuid,
      Value<bool> isActive,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<DateTime?> lastSeenAt,
    });

class $$StudentsTableFilterComposer
    extends Composer<_$AttendanceDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get universityStudentId => $composableBuilder(
    column: $table.universityStudentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrCode => $composableBuilder(
    column: $table.qrCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get universityId => $composableBuilder(
    column: $table.universityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get programId => $composableBuilder(
    column: $table.programId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentSemester => $composableBuilder(
    column: $table.currentSemester,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get offlineUuid => $composableBuilder(
    column: $table.offlineUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudentsTableOrderingComposer
    extends Composer<_$AttendanceDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get universityStudentId => $composableBuilder(
    column: $table.universityStudentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrCode => $composableBuilder(
    column: $table.qrCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get universityId => $composableBuilder(
    column: $table.universityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get programId => $composableBuilder(
    column: $table.programId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentSemester => $composableBuilder(
    column: $table.currentSemester,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get offlineUuid => $composableBuilder(
    column: $table.offlineUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$AttendanceDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get universityStudentId => $composableBuilder(
    column: $table.universityStudentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get qrCode =>
      $composableBuilder(column: $table.qrCode, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<int> get universityId => $composableBuilder(
    column: $table.universityId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get programId =>
      $composableBuilder(column: $table.programId, builder: (column) => column);

  GeneratedColumn<int> get currentSemester => $composableBuilder(
    column: $table.currentSemester,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get offlineUuid => $composableBuilder(
    column: $table.offlineUuid,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => column,
  );
}

class $$StudentsTableTableManager
    extends
        RootTableManager<
          _$AttendanceDatabase,
          $StudentsTable,
          Student,
          $$StudentsTableFilterComposer,
          $$StudentsTableOrderingComposer,
          $$StudentsTableAnnotationComposer,
          $$StudentsTableCreateCompanionBuilder,
          $$StudentsTableUpdateCompanionBuilder,
          (
            Student,
            BaseReferences<_$AttendanceDatabase, $StudentsTable, Student>,
          ),
          Student,
          PrefetchHooks Function()
        > {
  $$StudentsTableTableManager(_$AttendanceDatabase db, $StudentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> universityStudentId = const Value.absent(),
                Value<String> qrCode = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<int> universityId = const Value.absent(),
                Value<int> programId = const Value.absent(),
                Value<int?> currentSemester = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<String> offlineUuid = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime?> lastSeenAt = const Value.absent(),
              }) => StudentsCompanion(
                id: id,
                universityStudentId: universityStudentId,
                qrCode: qrCode,
                fullName: fullName,
                email: email,
                phone: phone,
                universityId: universityId,
                programId: programId,
                currentSemester: currentSemester,
                deviceId: deviceId,
                offlineUuid: offlineUuid,
                isActive: isActive,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                lastSeenAt: lastSeenAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String universityStudentId,
                required String qrCode,
                required String fullName,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                required int universityId,
                required int programId,
                Value<int?> currentSemester = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                required String offlineUuid,
                Value<bool> isActive = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime?> lastSeenAt = const Value.absent(),
              }) => StudentsCompanion.insert(
                id: id,
                universityStudentId: universityStudentId,
                qrCode: qrCode,
                fullName: fullName,
                email: email,
                phone: phone,
                universityId: universityId,
                programId: programId,
                currentSemester: currentSemester,
                deviceId: deviceId,
                offlineUuid: offlineUuid,
                isActive: isActive,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                lastSeenAt: lastSeenAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AttendanceDatabase,
      $StudentsTable,
      Student,
      $$StudentsTableFilterComposer,
      $$StudentsTableOrderingComposer,
      $$StudentsTableAnnotationComposer,
      $$StudentsTableCreateCompanionBuilder,
      $$StudentsTableUpdateCompanionBuilder,
      (Student, BaseReferences<_$AttendanceDatabase, $StudentsTable, Student>),
      Student,
      PrefetchHooks Function()
    >;
typedef $$CoursesTableCreateCompanionBuilder =
    CoursesCompanion Function({
      Value<int> id,
      required String universityCourseId,
      required String courseCode,
      required String courseName,
      Value<String?> creditHours,
      required int universityId,
      required int programId,
      required int semesterId,
      Value<bool> isActive,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$CoursesTableUpdateCompanionBuilder =
    CoursesCompanion Function({
      Value<int> id,
      Value<String> universityCourseId,
      Value<String> courseCode,
      Value<String> courseName,
      Value<String?> creditHours,
      Value<int> universityId,
      Value<int> programId,
      Value<int> semesterId,
      Value<bool> isActive,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

class $$CoursesTableFilterComposer
    extends Composer<_$AttendanceDatabase, $CoursesTable> {
  $$CoursesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get universityCourseId => $composableBuilder(
    column: $table.universityCourseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseCode => $composableBuilder(
    column: $table.courseCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditHours => $composableBuilder(
    column: $table.creditHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get universityId => $composableBuilder(
    column: $table.universityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get programId => $composableBuilder(
    column: $table.programId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get semesterId => $composableBuilder(
    column: $table.semesterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CoursesTableOrderingComposer
    extends Composer<_$AttendanceDatabase, $CoursesTable> {
  $$CoursesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get universityCourseId => $composableBuilder(
    column: $table.universityCourseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseCode => $composableBuilder(
    column: $table.courseCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditHours => $composableBuilder(
    column: $table.creditHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get universityId => $composableBuilder(
    column: $table.universityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get programId => $composableBuilder(
    column: $table.programId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get semesterId => $composableBuilder(
    column: $table.semesterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoursesTableAnnotationComposer
    extends Composer<_$AttendanceDatabase, $CoursesTable> {
  $$CoursesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get universityCourseId => $composableBuilder(
    column: $table.universityCourseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseCode => $composableBuilder(
    column: $table.courseCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creditHours => $composableBuilder(
    column: $table.creditHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get universityId => $composableBuilder(
    column: $table.universityId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get programId =>
      $composableBuilder(column: $table.programId, builder: (column) => column);

  GeneratedColumn<int> get semesterId => $composableBuilder(
    column: $table.semesterId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$CoursesTableTableManager
    extends
        RootTableManager<
          _$AttendanceDatabase,
          $CoursesTable,
          Course,
          $$CoursesTableFilterComposer,
          $$CoursesTableOrderingComposer,
          $$CoursesTableAnnotationComposer,
          $$CoursesTableCreateCompanionBuilder,
          $$CoursesTableUpdateCompanionBuilder,
          (Course, BaseReferences<_$AttendanceDatabase, $CoursesTable, Course>),
          Course,
          PrefetchHooks Function()
        > {
  $$CoursesTableTableManager(_$AttendanceDatabase db, $CoursesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoursesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoursesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoursesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> universityCourseId = const Value.absent(),
                Value<String> courseCode = const Value.absent(),
                Value<String> courseName = const Value.absent(),
                Value<String?> creditHours = const Value.absent(),
                Value<int> universityId = const Value.absent(),
                Value<int> programId = const Value.absent(),
                Value<int> semesterId = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => CoursesCompanion(
                id: id,
                universityCourseId: universityCourseId,
                courseCode: courseCode,
                courseName: courseName,
                creditHours: creditHours,
                universityId: universityId,
                programId: programId,
                semesterId: semesterId,
                isActive: isActive,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String universityCourseId,
                required String courseCode,
                required String courseName,
                Value<String?> creditHours = const Value.absent(),
                required int universityId,
                required int programId,
                required int semesterId,
                Value<bool> isActive = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => CoursesCompanion.insert(
                id: id,
                universityCourseId: universityCourseId,
                courseCode: courseCode,
                courseName: courseName,
                creditHours: creditHours,
                universityId: universityId,
                programId: programId,
                semesterId: semesterId,
                isActive: isActive,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CoursesTableProcessedTableManager =
    ProcessedTableManager<
      _$AttendanceDatabase,
      $CoursesTable,
      Course,
      $$CoursesTableFilterComposer,
      $$CoursesTableOrderingComposer,
      $$CoursesTableAnnotationComposer,
      $$CoursesTableCreateCompanionBuilder,
      $$CoursesTableUpdateCompanionBuilder,
      (Course, BaseReferences<_$AttendanceDatabase, $CoursesTable, Course>),
      Course,
      PrefetchHooks Function()
    >;
typedef $$SchedulesTableCreateCompanionBuilder =
    SchedulesCompanion Function({
      Value<int> id,
      required String universitySlotId,
      required int courseId,
      required int facultyMemberId,
      required int semesterId,
      required int dayOfWeek,
      required String startTime,
      required String endTime,
      Value<String?> roomNumber,
      Value<String?> building,
      Value<bool> isActive,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$SchedulesTableUpdateCompanionBuilder =
    SchedulesCompanion Function({
      Value<int> id,
      Value<String> universitySlotId,
      Value<int> courseId,
      Value<int> facultyMemberId,
      Value<int> semesterId,
      Value<int> dayOfWeek,
      Value<String> startTime,
      Value<String> endTime,
      Value<String?> roomNumber,
      Value<String?> building,
      Value<bool> isActive,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

class $$SchedulesTableFilterComposer
    extends Composer<_$AttendanceDatabase, $SchedulesTable> {
  $$SchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get universitySlotId => $composableBuilder(
    column: $table.universitySlotId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get courseId => $composableBuilder(
    column: $table.courseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get facultyMemberId => $composableBuilder(
    column: $table.facultyMemberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get semesterId => $composableBuilder(
    column: $table.semesterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roomNumber => $composableBuilder(
    column: $table.roomNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get building => $composableBuilder(
    column: $table.building,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SchedulesTableOrderingComposer
    extends Composer<_$AttendanceDatabase, $SchedulesTable> {
  $$SchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get universitySlotId => $composableBuilder(
    column: $table.universitySlotId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get courseId => $composableBuilder(
    column: $table.courseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get facultyMemberId => $composableBuilder(
    column: $table.facultyMemberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get semesterId => $composableBuilder(
    column: $table.semesterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roomNumber => $composableBuilder(
    column: $table.roomNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get building => $composableBuilder(
    column: $table.building,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SchedulesTableAnnotationComposer
    extends Composer<_$AttendanceDatabase, $SchedulesTable> {
  $$SchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get universitySlotId => $composableBuilder(
    column: $table.universitySlotId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get courseId =>
      $composableBuilder(column: $table.courseId, builder: (column) => column);

  GeneratedColumn<int> get facultyMemberId => $composableBuilder(
    column: $table.facultyMemberId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get semesterId => $composableBuilder(
    column: $table.semesterId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<String> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<String> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get roomNumber => $composableBuilder(
    column: $table.roomNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get building =>
      $composableBuilder(column: $table.building, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$SchedulesTableTableManager
    extends
        RootTableManager<
          _$AttendanceDatabase,
          $SchedulesTable,
          Schedule,
          $$SchedulesTableFilterComposer,
          $$SchedulesTableOrderingComposer,
          $$SchedulesTableAnnotationComposer,
          $$SchedulesTableCreateCompanionBuilder,
          $$SchedulesTableUpdateCompanionBuilder,
          (
            Schedule,
            BaseReferences<_$AttendanceDatabase, $SchedulesTable, Schedule>,
          ),
          Schedule,
          PrefetchHooks Function()
        > {
  $$SchedulesTableTableManager(_$AttendanceDatabase db, $SchedulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> universitySlotId = const Value.absent(),
                Value<int> courseId = const Value.absent(),
                Value<int> facultyMemberId = const Value.absent(),
                Value<int> semesterId = const Value.absent(),
                Value<int> dayOfWeek = const Value.absent(),
                Value<String> startTime = const Value.absent(),
                Value<String> endTime = const Value.absent(),
                Value<String?> roomNumber = const Value.absent(),
                Value<String?> building = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => SchedulesCompanion(
                id: id,
                universitySlotId: universitySlotId,
                courseId: courseId,
                facultyMemberId: facultyMemberId,
                semesterId: semesterId,
                dayOfWeek: dayOfWeek,
                startTime: startTime,
                endTime: endTime,
                roomNumber: roomNumber,
                building: building,
                isActive: isActive,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String universitySlotId,
                required int courseId,
                required int facultyMemberId,
                required int semesterId,
                required int dayOfWeek,
                required String startTime,
                required String endTime,
                Value<String?> roomNumber = const Value.absent(),
                Value<String?> building = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => SchedulesCompanion.insert(
                id: id,
                universitySlotId: universitySlotId,
                courseId: courseId,
                facultyMemberId: facultyMemberId,
                semesterId: semesterId,
                dayOfWeek: dayOfWeek,
                startTime: startTime,
                endTime: endTime,
                roomNumber: roomNumber,
                building: building,
                isActive: isActive,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AttendanceDatabase,
      $SchedulesTable,
      Schedule,
      $$SchedulesTableFilterComposer,
      $$SchedulesTableOrderingComposer,
      $$SchedulesTableAnnotationComposer,
      $$SchedulesTableCreateCompanionBuilder,
      $$SchedulesTableUpdateCompanionBuilder,
      (
        Schedule,
        BaseReferences<_$AttendanceDatabase, $SchedulesTable, Schedule>,
      ),
      Schedule,
      PrefetchHooks Function()
    >;
typedef $$AttendanceSessionsTableCreateCompanionBuilder =
    AttendanceSessionsCompanion Function({
      Value<int> id,
      required int scheduleSlotId,
      required int facultyMemberId,
      required DateTime sessionDate,
      required String startTime,
      required String endTime,
      required String attendanceMode,
      Value<double?> actualDuration,
      Value<String?> notes,
      required String offlineUuid,
      Value<String?> deviceId,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<DateTime?> syncedAt,
    });
typedef $$AttendanceSessionsTableUpdateCompanionBuilder =
    AttendanceSessionsCompanion Function({
      Value<int> id,
      Value<int> scheduleSlotId,
      Value<int> facultyMemberId,
      Value<DateTime> sessionDate,
      Value<String> startTime,
      Value<String> endTime,
      Value<String> attendanceMode,
      Value<double?> actualDuration,
      Value<String?> notes,
      Value<String> offlineUuid,
      Value<String?> deviceId,
      Value<bool> isSynced,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<DateTime?> syncedAt,
    });

class $$AttendanceSessionsTableFilterComposer
    extends Composer<_$AttendanceDatabase, $AttendanceSessionsTable> {
  $$AttendanceSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduleSlotId => $composableBuilder(
    column: $table.scheduleSlotId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get facultyMemberId => $composableBuilder(
    column: $table.facultyMemberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attendanceMode => $composableBuilder(
    column: $table.attendanceMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get actualDuration => $composableBuilder(
    column: $table.actualDuration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get offlineUuid => $composableBuilder(
    column: $table.offlineUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttendanceSessionsTableOrderingComposer
    extends Composer<_$AttendanceDatabase, $AttendanceSessionsTable> {
  $$AttendanceSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduleSlotId => $composableBuilder(
    column: $table.scheduleSlotId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get facultyMemberId => $composableBuilder(
    column: $table.facultyMemberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attendanceMode => $composableBuilder(
    column: $table.attendanceMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get actualDuration => $composableBuilder(
    column: $table.actualDuration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get offlineUuid => $composableBuilder(
    column: $table.offlineUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttendanceSessionsTableAnnotationComposer
    extends Composer<_$AttendanceDatabase, $AttendanceSessionsTable> {
  $$AttendanceSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get scheduleSlotId => $composableBuilder(
    column: $table.scheduleSlotId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get facultyMemberId => $composableBuilder(
    column: $table.facultyMemberId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sessionDate => $composableBuilder(
    column: $table.sessionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<String> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get attendanceMode => $composableBuilder(
    column: $table.attendanceMode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get actualDuration => $composableBuilder(
    column: $table.actualDuration,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get offlineUuid => $composableBuilder(
    column: $table.offlineUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$AttendanceSessionsTableTableManager
    extends
        RootTableManager<
          _$AttendanceDatabase,
          $AttendanceSessionsTable,
          AttendanceSession,
          $$AttendanceSessionsTableFilterComposer,
          $$AttendanceSessionsTableOrderingComposer,
          $$AttendanceSessionsTableAnnotationComposer,
          $$AttendanceSessionsTableCreateCompanionBuilder,
          $$AttendanceSessionsTableUpdateCompanionBuilder,
          (
            AttendanceSession,
            BaseReferences<
              _$AttendanceDatabase,
              $AttendanceSessionsTable,
              AttendanceSession
            >,
          ),
          AttendanceSession,
          PrefetchHooks Function()
        > {
  $$AttendanceSessionsTableTableManager(
    _$AttendanceDatabase db,
    $AttendanceSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceSessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> scheduleSlotId = const Value.absent(),
                Value<int> facultyMemberId = const Value.absent(),
                Value<DateTime> sessionDate = const Value.absent(),
                Value<String> startTime = const Value.absent(),
                Value<String> endTime = const Value.absent(),
                Value<String> attendanceMode = const Value.absent(),
                Value<double?> actualDuration = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> offlineUuid = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => AttendanceSessionsCompanion(
                id: id,
                scheduleSlotId: scheduleSlotId,
                facultyMemberId: facultyMemberId,
                sessionDate: sessionDate,
                startTime: startTime,
                endTime: endTime,
                attendanceMode: attendanceMode,
                actualDuration: actualDuration,
                notes: notes,
                offlineUuid: offlineUuid,
                deviceId: deviceId,
                isSynced: isSynced,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int scheduleSlotId,
                required int facultyMemberId,
                required DateTime sessionDate,
                required String startTime,
                required String endTime,
                required String attendanceMode,
                Value<double?> actualDuration = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required String offlineUuid,
                Value<String?> deviceId = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => AttendanceSessionsCompanion.insert(
                id: id,
                scheduleSlotId: scheduleSlotId,
                facultyMemberId: facultyMemberId,
                sessionDate: sessionDate,
                startTime: startTime,
                endTime: endTime,
                attendanceMode: attendanceMode,
                actualDuration: actualDuration,
                notes: notes,
                offlineUuid: offlineUuid,
                deviceId: deviceId,
                isSynced: isSynced,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncedAt: syncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttendanceSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AttendanceDatabase,
      $AttendanceSessionsTable,
      AttendanceSession,
      $$AttendanceSessionsTableFilterComposer,
      $$AttendanceSessionsTableOrderingComposer,
      $$AttendanceSessionsTableAnnotationComposer,
      $$AttendanceSessionsTableCreateCompanionBuilder,
      $$AttendanceSessionsTableUpdateCompanionBuilder,
      (
        AttendanceSession,
        BaseReferences<
          _$AttendanceDatabase,
          $AttendanceSessionsTable,
          AttendanceSession
        >,
      ),
      AttendanceSession,
      PrefetchHooks Function()
    >;
typedef $$StaffPermissionsTableCreateCompanionBuilder =
    StaffPermissionsCompanion Function({
      Value<int> id,
      required int userId,
      required int courseId,
      required int semesterId,
      required String permissionsJson,
      Value<String?> deviceId,
      required String offlineUuid,
      Value<bool> isActive,
      Value<bool> isDeleted,
      Value<DateTime> grantedAt,
      Value<DateTime?> revokedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$StaffPermissionsTableUpdateCompanionBuilder =
    StaffPermissionsCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<int> courseId,
      Value<int> semesterId,
      Value<String> permissionsJson,
      Value<String?> deviceId,
      Value<String> offlineUuid,
      Value<bool> isActive,
      Value<bool> isDeleted,
      Value<DateTime> grantedAt,
      Value<DateTime?> revokedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

class $$StaffPermissionsTableFilterComposer
    extends Composer<_$AttendanceDatabase, $StaffPermissionsTable> {
  $$StaffPermissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get courseId => $composableBuilder(
    column: $table.courseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get semesterId => $composableBuilder(
    column: $table.semesterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get permissionsJson => $composableBuilder(
    column: $table.permissionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get offlineUuid => $composableBuilder(
    column: $table.offlineUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get grantedAt => $composableBuilder(
    column: $table.grantedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get revokedAt => $composableBuilder(
    column: $table.revokedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StaffPermissionsTableOrderingComposer
    extends Composer<_$AttendanceDatabase, $StaffPermissionsTable> {
  $$StaffPermissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get courseId => $composableBuilder(
    column: $table.courseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get semesterId => $composableBuilder(
    column: $table.semesterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get permissionsJson => $composableBuilder(
    column: $table.permissionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get offlineUuid => $composableBuilder(
    column: $table.offlineUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get grantedAt => $composableBuilder(
    column: $table.grantedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get revokedAt => $composableBuilder(
    column: $table.revokedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StaffPermissionsTableAnnotationComposer
    extends Composer<_$AttendanceDatabase, $StaffPermissionsTable> {
  $$StaffPermissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get courseId =>
      $composableBuilder(column: $table.courseId, builder: (column) => column);

  GeneratedColumn<int> get semesterId => $composableBuilder(
    column: $table.semesterId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get permissionsJson => $composableBuilder(
    column: $table.permissionsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get offlineUuid => $composableBuilder(
    column: $table.offlineUuid,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get grantedAt =>
      $composableBuilder(column: $table.grantedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get revokedAt =>
      $composableBuilder(column: $table.revokedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$StaffPermissionsTableTableManager
    extends
        RootTableManager<
          _$AttendanceDatabase,
          $StaffPermissionsTable,
          StaffPermission,
          $$StaffPermissionsTableFilterComposer,
          $$StaffPermissionsTableOrderingComposer,
          $$StaffPermissionsTableAnnotationComposer,
          $$StaffPermissionsTableCreateCompanionBuilder,
          $$StaffPermissionsTableUpdateCompanionBuilder,
          (
            StaffPermission,
            BaseReferences<
              _$AttendanceDatabase,
              $StaffPermissionsTable,
              StaffPermission
            >,
          ),
          StaffPermission,
          PrefetchHooks Function()
        > {
  $$StaffPermissionsTableTableManager(
    _$AttendanceDatabase db,
    $StaffPermissionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StaffPermissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StaffPermissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StaffPermissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<int> courseId = const Value.absent(),
                Value<int> semesterId = const Value.absent(),
                Value<String> permissionsJson = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<String> offlineUuid = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> grantedAt = const Value.absent(),
                Value<DateTime?> revokedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => StaffPermissionsCompanion(
                id: id,
                userId: userId,
                courseId: courseId,
                semesterId: semesterId,
                permissionsJson: permissionsJson,
                deviceId: deviceId,
                offlineUuid: offlineUuid,
                isActive: isActive,
                isDeleted: isDeleted,
                grantedAt: grantedAt,
                revokedAt: revokedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required int courseId,
                required int semesterId,
                required String permissionsJson,
                Value<String?> deviceId = const Value.absent(),
                required String offlineUuid,
                Value<bool> isActive = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> grantedAt = const Value.absent(),
                Value<DateTime?> revokedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => StaffPermissionsCompanion.insert(
                id: id,
                userId: userId,
                courseId: courseId,
                semesterId: semesterId,
                permissionsJson: permissionsJson,
                deviceId: deviceId,
                offlineUuid: offlineUuid,
                isActive: isActive,
                isDeleted: isDeleted,
                grantedAt: grantedAt,
                revokedAt: revokedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StaffPermissionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AttendanceDatabase,
      $StaffPermissionsTable,
      StaffPermission,
      $$StaffPermissionsTableFilterComposer,
      $$StaffPermissionsTableOrderingComposer,
      $$StaffPermissionsTableAnnotationComposer,
      $$StaffPermissionsTableCreateCompanionBuilder,
      $$StaffPermissionsTableUpdateCompanionBuilder,
      (
        StaffPermission,
        BaseReferences<
          _$AttendanceDatabase,
          $StaffPermissionsTable,
          StaffPermission
        >,
      ),
      StaffPermission,
      PrefetchHooks Function()
    >;
typedef $$QrMappingsTableCreateCompanionBuilder =
    QrMappingsCompanion Function({
      Value<int> id,
      required int studentId,
      required String qrPayload,
      required String qrHash,
      required String deviceId,
      Value<DateTime> generatedAt,
      required DateTime expiresAt,
      Value<bool> isActive,
      Value<bool> isDeleted,
      Value<DateTime?> lastUsedAt,
      Value<int> usageCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });
typedef $$QrMappingsTableUpdateCompanionBuilder =
    QrMappingsCompanion Function({
      Value<int> id,
      Value<int> studentId,
      Value<String> qrPayload,
      Value<String> qrHash,
      Value<String> deviceId,
      Value<DateTime> generatedAt,
      Value<DateTime> expiresAt,
      Value<bool> isActive,
      Value<bool> isDeleted,
      Value<DateTime?> lastUsedAt,
      Value<int> usageCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
    });

class $$QrMappingsTableFilterComposer
    extends Composer<_$AttendanceDatabase, $QrMappingsTable> {
  $$QrMappingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrPayload => $composableBuilder(
    column: $table.qrPayload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrHash => $composableBuilder(
    column: $table.qrHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QrMappingsTableOrderingComposer
    extends Composer<_$AttendanceDatabase, $QrMappingsTable> {
  $$QrMappingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrPayload => $composableBuilder(
    column: $table.qrPayload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrHash => $composableBuilder(
    column: $table.qrHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QrMappingsTableAnnotationComposer
    extends Composer<_$AttendanceDatabase, $QrMappingsTable> {
  $$QrMappingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get qrPayload =>
      $composableBuilder(column: $table.qrPayload, builder: (column) => column);

  GeneratedColumn<String> get qrHash =>
      $composableBuilder(column: $table.qrHash, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$QrMappingsTableTableManager
    extends
        RootTableManager<
          _$AttendanceDatabase,
          $QrMappingsTable,
          QrMapping,
          $$QrMappingsTableFilterComposer,
          $$QrMappingsTableOrderingComposer,
          $$QrMappingsTableAnnotationComposer,
          $$QrMappingsTableCreateCompanionBuilder,
          $$QrMappingsTableUpdateCompanionBuilder,
          (
            QrMapping,
            BaseReferences<_$AttendanceDatabase, $QrMappingsTable, QrMapping>,
          ),
          QrMapping,
          PrefetchHooks Function()
        > {
  $$QrMappingsTableTableManager(_$AttendanceDatabase db, $QrMappingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QrMappingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QrMappingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QrMappingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> studentId = const Value.absent(),
                Value<String> qrPayload = const Value.absent(),
                Value<String> qrHash = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => QrMappingsCompanion(
                id: id,
                studentId: studentId,
                qrPayload: qrPayload,
                qrHash: qrHash,
                deviceId: deviceId,
                generatedAt: generatedAt,
                expiresAt: expiresAt,
                isActive: isActive,
                isDeleted: isDeleted,
                lastUsedAt: lastUsedAt,
                usageCount: usageCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int studentId,
                required String qrPayload,
                required String qrHash,
                required String deviceId,
                Value<DateTime> generatedAt = const Value.absent(),
                required DateTime expiresAt,
                Value<bool> isActive = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
              }) => QrMappingsCompanion.insert(
                id: id,
                studentId: studentId,
                qrPayload: qrPayload,
                qrHash: qrHash,
                deviceId: deviceId,
                generatedAt: generatedAt,
                expiresAt: expiresAt,
                isActive: isActive,
                isDeleted: isDeleted,
                lastUsedAt: lastUsedAt,
                usageCount: usageCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QrMappingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AttendanceDatabase,
      $QrMappingsTable,
      QrMapping,
      $$QrMappingsTableFilterComposer,
      $$QrMappingsTableOrderingComposer,
      $$QrMappingsTableAnnotationComposer,
      $$QrMappingsTableCreateCompanionBuilder,
      $$QrMappingsTableUpdateCompanionBuilder,
      (
        QrMapping,
        BaseReferences<_$AttendanceDatabase, $QrMappingsTable, QrMapping>,
      ),
      QrMapping,
      PrefetchHooks Function()
    >;

class $AttendanceDatabaseManager {
  final _$AttendanceDatabase _db;
  $AttendanceDatabaseManager(this._db);
  $$AttendancesTableTableManager get attendances =>
      $$AttendancesTableTableManager(_db, _db.attendances);
  $$SyncQueuesTableTableManager get syncQueues =>
      $$SyncQueuesTableTableManager(_db, _db.syncQueues);
  $$CoursesCachesTableTableManager get coursesCaches =>
      $$CoursesCachesTableTableManager(_db, _db.coursesCaches);
  $$StudentsCachesTableTableManager get studentsCaches =>
      $$StudentsCachesTableTableManager(_db, _db.studentsCaches);
  $$SessionSnapshotsTableTableManager get sessionSnapshots =>
      $$SessionSnapshotsTableTableManager(_db, _db.sessionSnapshots);
  $$StudentAttendanceStatusesTableTableManager get studentAttendanceStatuses =>
      $$StudentAttendanceStatusesTableTableManager(
        _db,
        _db.studentAttendanceStatuses,
      );
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$CoursesTableTableManager get courses =>
      $$CoursesTableTableManager(_db, _db.courses);
  $$SchedulesTableTableManager get schedules =>
      $$SchedulesTableTableManager(_db, _db.schedules);
  $$AttendanceSessionsTableTableManager get attendanceSessions =>
      $$AttendanceSessionsTableTableManager(_db, _db.attendanceSessions);
  $$StaffPermissionsTableTableManager get staffPermissions =>
      $$StaffPermissionsTableTableManager(_db, _db.staffPermissions);
  $$QrMappingsTableTableManager get qrMappings =>
      $$QrMappingsTableTableManager(_db, _db.qrMappings);
}
