import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:mobile_flutter/features/attendance/data/database/attendance_database.dart';

/// High-performance local student lookup service with QR acceleration
///
/// This is the core of the "Zero-Latency QR Scanning" requirement:
/// 1. QR scan → offline_uuid lookup (indexed) → instant validation
/// 2. All data cached locally, no network dependency
/// 3. SHA256 hashing for collision-free QR code indexing
class LocalStudentService {
  late final AttendanceDatabase database;
  late final String deviceId;

  LocalStudentService({required this.database, required this.deviceId});

  /// QUICK LOOKUP: Find student by QR code hash (fastest path)
  /// Query: SELECT * FROM qr_mappings WHERE qr_hash = ? LIMIT 1
  /// Expected latency: < 1ms with proper index
  Future<LocalStudent?> findStudentByQr(String qrPayload) async {
    final qrHash = _hashQr(qrPayload);

    final query =
        database.select(database.qrMappings).join([
            innerJoin(
              database.students,
              database.students.id.equalsExp(database.qrMappings.studentId),
            ),
          ])
          ..where(
            database.qrMappings.qrHash.equals(qrHash) &
                database.qrMappings.isActive.equals(true) &
                database.qrMappings.isDeleted.equals(false) &
                database.students.isDeleted.equals(false),
          )
          ..limit(1);

    final row = await query.getSingleOrNull();
    if (row != null) {
      final student = row.readTable(database.students);
      unawaited(_updateLastSeen(student.id));
      return _mapStudent(student);
    }

    return null;
  }

  /// FALLBACK: Find student by student ID (for manual entry)
  Future<LocalStudent?> findStudentById(int studentId) async {
    final record =
        await (database.select(database.students)
              ..where((tbl) => tbl.id.equals(studentId))
              ..limit(1))
            .getSingleOrNull();

    return record != null ? _mapStudent(record) : null;
  }

  /// BULK LOAD: Get all active students for a program (for pre-caching)
  /// Used: Before opening QR scanner, preload student roster into memory
  Future<List<LocalStudent>> getStudentsByProgram({
    required int universityId,
    required int programId,
  }) async {
    final records =
        await (database.select(database.students)
              ..where(
                (tbl) =>
                    tbl.universityId.equals(universityId) &
                    tbl.programId.equals(programId) &
                    tbl.isActive.equals(true) &
                    tbl.isDeleted.equals(false),
              )
              ..orderBy([(tbl) => OrderingTerm(expression: tbl.fullName)]))
            .get();

    return records.map(_mapStudent).toList();
  }

  /// INSERT: Cache a new student record (optimistic write)
  /// Called: After QR scan if student not yet cached
  Future<LocalStudent> cacheStudent({
    required String universityStudentId,
    required String qrPayload,
    required String fullName,
    String? email,
    int? universityId,
    int? programId,
  }) async {
    final now = DateTime.now();
    final offlineUuid = _generateOfflineUuid();

    final id = await database
        .into(database.students)
        .insert(
          StudentsCompanion(
            universityStudentId: Value(universityStudentId),
            qrCode: Value(qrPayload),
            fullName: Value(fullName),
            email: Value(email),
            universityId: Value(universityId ?? 0),
            programId: Value(programId ?? 0),
            offlineUuid: Value(offlineUuid),
            deviceId: Value(deviceId),
            createdAt: Value(now),
            updatedAt: Value(now),
            lastSeenAt: Value(now),
          ),
        );

    final record = await (database.select(
      database.students,
    )..where((tbl) => tbl.id.equals(id))).getSingle();

    return _mapStudent(record);
  }

  /// UPDATE: Batch update students with latest sync timestamp
  /// Called: During delta sync pull from server
  Future<void> upsertStudents(List<LocalStudent> students) async {
    await database.batch((batch) {
      for (final student in students) {
        batch.insert(
          database.students,
          StudentsCompanion(
            id: Value(student.id),
            universityStudentId: Value(student.universityStudentId),
            qrCode: Value(student.qrCode),
            fullName: Value(student.fullName),
            email: Value(student.email),
            universityId: Value(student.universityId),
            programId: Value(student.programId),
            offlineUuid: Value(student.offlineUuid),
            deviceId: Value(deviceId),
            isActive: Value(student.isActive),
            isDeleted: Value(student.isDeleted),
            updatedAt: Value(student.updatedAt),
            lastSeenAt: Value(DateTime.now()),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  /// SOFT DELETE: Mark student as deleted (never hard deletes)
  Future<void> softDeleteStudent(int studentId) async {
    await (database.update(
      database.students,
    )..where((tbl) => tbl.id.equals(studentId))).write(
      StudentsCompanion(
        isDeleted: const Value(true),
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// GET ACTIVE COUNT: For diagnostics and UI
  Future<int> getActiveStudentCount() async {
    final query = database.select(database.students)
      ..where((tbl) => tbl.isActive.equals(true) & tbl.isDeleted.equals(false));
    final rows = await query.get();
    return rows.length;
  }

  /// COUNT BY QR: Quick existence check
  Future<bool> existsByQr(String qrPayload) async {
    final record =
        await (database.select(database.students)
              ..where((tbl) => tbl.qrCode.equals(qrPayload))
              ..limit(1))
            .getSingleOrNull();
    return record != null;
  }

  // ─────────────────────────────────────────────
  // INTERNAL HELPERS
  // ─────────────────────────────────────────────

  Future<void> _updateLastSeen(int studentId) async {
    await (database.update(database.students)
          ..where((tbl) => tbl.id.equals(studentId)))
        .write(StudentsCompanion(lastSeenAt: Value(DateTime.now())));
  }

  String _hashQr(String qrPayload) {
    final bytes = utf8.encode(qrPayload);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  String _generateOfflineUuid() {
    // UUID v4 style: 8-4-4-4-12
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(256));
    values[6] = (values[6] & 0x0f) | 0x40; // Version 4
    values[8] = (values[8] & 0x3f) | 0x80; // Variant RFC4122

    final hex = values.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }

  LocalStudent _mapStudent(Student data) {
    return LocalStudent(
      id: data.id,
      universityStudentId: data.universityStudentId,
      qrCode: data.qrCode,
      fullName: data.fullName,
      email: data.email,
      universityId: data.universityId,
      programId: data.programId,
      currentSemester: data.currentSemester,
      offlineUuid: data.offlineUuid,
      deviceId: data.deviceId,
      isActive: data.isActive,
      isDeleted: data.isDeleted,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      lastSeenAt: data.lastSeenAt,
    );
  }
}

// ─────────────────────────────────────────────
// MODEL
// ─────────────────────────────────────────────

class LocalStudent {
  final int id;
  final String universityStudentId;
  final String qrCode;
  final String fullName;
  final String? email;
  final int universityId;
  final int programId;
  final int? currentSemester;

  final String offlineUuid;
  final String? deviceId;

  final bool isActive;
  final bool isDeleted;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastSeenAt;

  LocalStudent({
    required this.id,
    required this.universityStudentId,
    required this.qrCode,
    required this.fullName,
    this.email,
    required this.universityId,
    required this.programId,
    this.currentSemester,
    required this.offlineUuid,
    this.deviceId,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.lastSeenAt,
  });
}
