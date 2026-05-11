import 'package:equatable/equatable.dart';

/// Business model for Student (UI layer)
/// Separate from Drift table definition in tables/students_table.dart
class Student extends Equatable {
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

  const Student({
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

  Student copyWith({
    int? id,
    String? universityStudentId,
    String? qrCode,
    String? fullName,
    String? email,
    int? universityId,
    int? programId,
    int? currentSemester,
    String? offlineUuid,
    String? deviceId,
    bool? isActive,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastSeenAt,
  }) {
    return Student(
      id: id ?? this.id,
      universityStudentId: universityStudentId ?? this.universityStudentId,
      qrCode: qrCode ?? this.qrCode,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      universityId: universityId ?? this.universityId,
      programId: programId ?? this.programId,
      currentSemester: currentSemester ?? this.currentSemester,
      offlineUuid: offlineUuid ?? this.offlineUuid,
      deviceId: deviceId ?? this.deviceId,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        universityStudentId,
        qrCode,
        fullName,
        email,
        universityId,
        programId,
        currentSemester,
        offlineUuid,
        deviceId,
        isActive,
        isDeleted,
        createdAt,
        updatedAt,
        lastSeenAt,
      ];

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int? ?? 0,
      universityStudentId: json['universityStudentId'] as String? ?? '',
      qrCode: json['qrCode'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String?,
      universityId: json['universityId'] as int? ?? 0,
      programId: json['programId'] as int? ?? 0,
      currentSemester: json['currentSemester'] as int?,
      offlineUuid: json['offlineUuid'] as String? ?? '',
      deviceId: json['deviceId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : DateTime.now(),
      lastSeenAt: json['lastSeenAt'] != null
          ? DateTime.parse(json['lastSeenAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'universityStudentId': universityStudentId,
      'qrCode': qrCode,
      'fullName': fullName,
      'email': email,
      'universityId': universityId,
      'programId': programId,
      'currentSemester': currentSemester,
      'offlineUuid': offlineUuid,
      'deviceId': deviceId,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lastSeenAt': lastSeenAt?.toIso8601String(),
    };
  }
}
