import 'package:equatable/equatable.dart';

class AttendanceModel extends Equatable {
  final int id;
  final int studentId;
  final DateTime attendanceDate;
  final String status; // present, absent, late
  final int courseId;
  final int sessionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool pendingSync;
  final String? syncError;

  const AttendanceModel({
    required this.id,
    required this.studentId,
    required this.attendanceDate,
    required this.status,
    required this.courseId,
    required this.sessionId,
    required this.createdAt,
    required this.updatedAt,
    required this.pendingSync,
    this.syncError,
  });

  AttendanceModel copyWith({
    int? id,
    int? studentId,
    DateTime? attendanceDate,
    String? status,
    int? courseId,
    int? sessionId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? pendingSync,
    String? syncError,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      attendanceDate: attendanceDate ?? this.attendanceDate,
      status: status ?? this.status,
      courseId: courseId ?? this.courseId,
      sessionId: sessionId ?? this.sessionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
      syncError: syncError ?? this.syncError,
    );
  }

  @override
  List<Object?> get props => [
    id,
    studentId,
    attendanceDate,
    status,
    courseId,
    sessionId,
    createdAt,
    updatedAt,
    pendingSync,
    syncError,
  ];
}
