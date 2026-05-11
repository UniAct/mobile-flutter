class StudentAttendanceItem {
  StudentAttendanceItem({
    required this.sessionId,
    required this.courseName,
    required this.courseCode,
    required this.status,
    required this.sessionDate,
    required this.mode,
  });

  final int sessionId;
  final String courseName;
  final String courseCode;
  final String status;
  final DateTime sessionDate;
  final String mode;

  factory StudentAttendanceItem.fromJson(Map<String, dynamic> json) {
    final session =
        (json['attendanceSession'] as Map<String, dynamic>?) ??
        <String, dynamic>{};
    final scheduleSlot =
        (session['scheduleSlot'] as Map<String, dynamic>?) ??
        <String, dynamic>{};
    final course =
        (scheduleSlot['course'] as Map<String, dynamic>?) ??
        <String, dynamic>{};

    return StudentAttendanceItem(
      sessionId: _toInt(session['id']),
      courseName: (course['name'] ?? 'Course').toString(),
      courseCode: (course['code'] ?? '').toString(),
      status: (json['status'] ?? 'Unknown').toString(),
      sessionDate:
          DateTime.tryParse((session['sessionDate'] ?? '').toString()) ??
          DateTime.now(),
      mode: (session['attendanceMode'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'attendanceSession': {
      'id': sessionId,
      'sessionDate': sessionDate.toIso8601String(),
      'attendanceMode': mode,
      'scheduleSlot': {
        'course': {'name': courseName, 'code': courseCode},
      },
    },
    'status': status,
  };
}

class StudentAttendanceStatusData {
  StudentAttendanceStatusData({
    required this.semesterId,
    required this.timeline,
    required this.qrPayload,
  });

  final int semesterId;
  final List<StudentAttendanceItem> timeline;
  final String qrPayload;

  factory StudentAttendanceStatusData.fromJson(Map<String, dynamic> json) {
    final timelineRaw = (json['timeline'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(StudentAttendanceItem.fromJson)
        .toList();

    return StudentAttendanceStatusData(
      semesterId: _toInt(json['semesterId']),
      timeline: timelineRaw,
      qrPayload: (json['qrPayload'] ?? '').toString(),
    );
  }
}

class EnrolledStudent {
  EnrolledStudent({
    required this.studentId,
    required this.fullName,
    required this.email,
  });

  final int studentId;
  final String fullName;
  final String email;

  factory EnrolledStudent.fromJson(Map<String, dynamic> json) {
    final student =
        (json['student'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final user =
        (student['user'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final firstName =
        (user['firstName'] ?? json['firstName'] ?? json['name'] ?? '')
            .toString();
    final lastName = (user['lastName'] ?? json['lastName'] ?? '').toString();
    final fullName = '$firstName $lastName'.trim();

    return EnrolledStudent(
      studentId: _toInt(json['studentId']),
      fullName: fullName.isNotEmpty ? fullName : 'Student ${json['studentId']}',
      email: (user['email'] ?? json['email'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'studentId': studentId,
    'student': {
      'user': {'firstName': fullName, 'lastName': '', 'email': email},
    },
  };
}

class StaffAttendanceCourseOption {
  StaffAttendanceCourseOption({
    required this.contextId,
    required this.scheduleSlotId,
    required this.teacherId,
    required this.label,
    required this.description,
    required this.courseCode,
    required this.courseName,
    required this.programName,
    required this.academicLevel,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  final int contextId;
  final int scheduleSlotId;
  final int teacherId;
  final String label;
  final String description;
  final String courseCode;
  final String courseName;
  final String programName;
  final int academicLevel;
  final String dayOfWeek;
  final String startTime;
  final String endTime;

  factory StaffAttendanceCourseOption.fromJson(Map<String, dynamic> json) {
    final program =
        (json['program'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final slot = (json['slot'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final course =
        (slot['course'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    final courseCode = (course['code'] ?? json['courseCode'] ?? '').toString();
    final courseName = (course['name'] ?? json['courseName'] ?? 'Course')
        .toString();
    final programName = (program['name'] ?? '').toString();
    final academicLevel = _toInt(json['academicLevel']);
    final dayOfWeek = _weekdayName(slot['dayOfWeek'] ?? json['dayOfWeek']);
    final startTime = _timeOnly(slot['startTime'] ?? json['startTime']);
    final endTime = _timeOnly(slot['endTime'] ?? json['endTime']);
    final type = (slot['type'] ?? '').toString();
    final timeLabel = [
      if (dayOfWeek.isNotEmpty) dayOfWeek,
      if (startTime.isNotEmpty || endTime.isNotEmpty) '$startTime-$endTime',
    ].join(' ');

    return StaffAttendanceCourseOption(
      contextId: _toInt(json['id']),
      scheduleSlotId: _toInt(slot['id']),
      teacherId: _toInt(slot['teacherId']),
      label: courseCode.isNotEmpty ? '$courseCode - $courseName' : courseName,
      description: [
        if (programName.isNotEmpty) programName,
        if (academicLevel > 0) 'Level $academicLevel',
        if (type.isNotEmpty) type,
        if (timeLabel.isNotEmpty) timeLabel,
      ].join(' • '),
      courseCode: courseCode,
      courseName: courseName,
      programName: programName,
      academicLevel: academicLevel,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': contextId,
    'academicLevel': academicLevel,
    'program': {'name': programName},
    'slot': {
      'id': scheduleSlotId,
      'teacherId': teacherId,
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
      'course': {'code': courseCode, 'name': courseName},
    },
  };
}

class ManualAttendanceRecord {
  ManualAttendanceRecord({
    required this.studentId,
    required this.status,
    this.notes,
  });

  final int studentId;
  final String status;
  final String? notes;

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{'studentId': studentId, 'status': status};
    if (notes != null) {
      result['notes'] = notes;
    }
    return result;
  }
}

int _toInt(dynamic value) {
  if (value is int) {
    return value;
  }

  return int.tryParse(value?.toString() ?? '') ?? 0;
}

String _timeOnly(dynamic value) {
  final raw = (value ?? '').toString();
  if (!raw.contains('T') && raw.length >= 5) {
    return raw.substring(0, 5);
  }

  final match = RegExp(r'(\d{2}:\d{2})').firstMatch(raw);
  if (match != null) {
    return match.group(1) ?? raw;
  }

  return raw;
}

String _weekdayName(dynamic value) {
  if (value is int) {
    return _weekdayFromInt(value);
  }

  final raw = (value ?? '').toString().trim();
  final parsed = int.tryParse(raw);
  if (parsed != null) {
    return _weekdayFromInt(parsed);
  }

  if (raw.isEmpty) {
    return '';
  }

  return raw[0].toUpperCase() + raw.substring(1);
}

String _weekdayFromInt(int value) {
  const days = <int, String>{
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday',
  };
  return days[value] ?? value.toString();
}
