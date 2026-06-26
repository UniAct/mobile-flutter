class TimetableCourse {
  TimetableCourse({
    required this.id,
    required this.code,
    required this.name,
    required this.credits,
  });

  final int id;
  final String code;
  final String name;
  final int credits;

  factory TimetableCourse.fromJson(Map<String, dynamic>? json) {
    json ??= <String, dynamic>{};
    return TimetableCourse(
      id: _toInt(json['id']),
      code: (json['code'] ?? '').toString(),
      name: (json['name'] ?? 'Course').toString(),
      credits: _toInt(json['credits']),
    );
  }
}

class TimetableClassroom {
  TimetableClassroom({required this.label, required this.capacity});

  final String label;
  final int capacity;

  factory TimetableClassroom.fromJson(Map<String, dynamic>? json) {
    json ??= <String, dynamic>{};
    final label =
        (json['label'] ??
                '${(json['building'] ?? '').toString()} / ${(json['classroomNumber'] ?? '').toString()}')
            .toString()
            .trim();

    return TimetableClassroom(
      label: label == '/' ? '' : label,
      capacity: _toInt(json['capacity']),
    );
  }
}

class TimetableTeacher {
  TimetableTeacher({required this.name, this.email});

  final String name;
  final String? email;

  factory TimetableTeacher.fromJson(Map<String, dynamic>? json) {
    json ??= <String, dynamic>{};
    return TimetableTeacher(
      name: (json['name'] ?? '').toString(),
      email: json['email']?.toString(),
    );
  }
}

class TimetableProgramContext {
  TimetableProgramContext({
    required this.programName,
    required this.academicLevel,
    required this.enrolledStudents,
  });

  final String programName;
  final int academicLevel;
  final int enrolledStudents;

  factory TimetableProgramContext.fromJson(Map<String, dynamic> json) {
    final program =
        (json['program'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    return TimetableProgramContext(
      programName: (program['name'] ?? 'Program').toString(),
      academicLevel: _toInt(json['academicLevel']),
      enrolledStudents: _toInt(json['enrolledStudents']),
    );
  }
}

class TimetableItem {
  TimetableItem({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.course,
    this.classroom,
    this.teacher,
    this.registrationStatus,
    this.programContexts = const <TimetableProgramContext>[],
    this.allowedCapacity,
    this.enrolledSeats,
  });

  final int id;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final String type;
  final TimetableCourse course;
  final TimetableClassroom? classroom;
  final TimetableTeacher? teacher;
  final String? registrationStatus;
  final List<TimetableProgramContext> programContexts;
  final int? allowedCapacity;
  final int? enrolledSeats;

  factory TimetableItem.fromJson(Map<String, dynamic> json) {
    return TimetableItem(
      id: _toInt(json['id']),
      dayOfWeek: (json['dayOfWeek'] ?? '').toString(),
      startTime: (json['startTime'] ?? '').toString(),
      endTime: (json['endTime'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      course: TimetableCourse.fromJson(json['course'] as Map<String, dynamic>?),
      classroom: json['classroom'] is Map<String, dynamic>
          ? TimetableClassroom.fromJson(
              json['classroom'] as Map<String, dynamic>,
            )
          : null,
      teacher: json['teacher'] is Map<String, dynamic>
          ? TimetableTeacher.fromJson(json['teacher'] as Map<String, dynamic>)
          : null,
      registrationStatus: json['registrationStatus']?.toString(),
      programContexts: (json['programContexts'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(TimetableProgramContext.fromJson)
          .toList(),
      allowedCapacity: _nullableInt(json['allowedCapacity']),
      enrolledSeats: _nullableInt(json['enrolledSeats']),
    );
  }

  factory TimetableItem.fromScheduleJson(Map<String, dynamic> json) {
    return TimetableItem(
      id: _toInt(json['id']),
      dayOfWeek: (json['dayOfWeek'] ?? '').toString(),
      startTime: (json['startTime'] ?? '').toString(),
      endTime: (json['endTime'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      course: TimetableCourse.fromJson(json['course'] as Map<String, dynamic>?),
      classroom: TimetableClassroom.fromJson(
        json['classroom'] as Map<String, dynamic>?,
      ),
      teacher: TimetableTeacher.fromJson(
        json['teacher'] as Map<String, dynamic>?,
      ),
      registrationStatus: json['registrationStatus']?.toString(),
      allowedCapacity: _nullableInt(json['allowedCapacity']),
      enrolledSeats: _nullableInt(json['enrolledSeats']),
    );
  }

  factory TimetableItem.fromDashboardJson(
    Map<String, dynamic> json, {
    required bool isStudent,
  }) {
    if (isStudent) {
      final slotContext =
          (json['scheduleSlotContext'] as Map<String, dynamic>?) ?? {};
      final slot = (slotContext['slot'] as Map<String, dynamic>?) ?? {};
      final teacher =
          ((slot['teacher'] as Map<String, dynamic>?)?['user']
              as Map<String, dynamic>?) ??
          {};

      return TimetableItem(
        id: _toInt(json['id']),
        dayOfWeek: (slot['dayOfWeek'] ?? '').toString(),
        startTime: _timeOnly(slot['startTime']),
        endTime: _timeOnly(slot['endTime']),
        type: (slot['type'] ?? '').toString(),
        course: TimetableCourse.fromJson(
          slot['course'] as Map<String, dynamic>?,
        ),
        classroom: TimetableClassroom.fromJson(
          slot['classroom'] as Map<String, dynamic>?,
        ),
        teacher: TimetableTeacher(
          name:
              '${(teacher['firstName'] ?? '').toString()} ${(teacher['lastName'] ?? '').toString()}'
                  .trim(),
          email: teacher['email']?.toString(),
        ),
        registrationStatus: json['status']?.toString(),
      );
    }

    return TimetableItem(
      id: _toInt(json['id']),
      dayOfWeek: (json['dayOfWeek'] ?? '').toString(),
      startTime: _timeOnly(json['startTime']),
      endTime: _timeOnly(json['endTime']),
      type: (json['type'] ?? '').toString(),
      course: TimetableCourse.fromJson(json['course'] as Map<String, dynamic>?),
      classroom: TimetableClassroom.fromJson(
        json['classroom'] as Map<String, dynamic>?,
      ),
      programContexts: (json['slotContext'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(TimetableProgramContext.fromJson)
          .toList(),
      allowedCapacity: _nullableInt(json['allowedCapacity']),
      enrolledSeats: _nullableInt(json['enrolledSeats']),
    );
  }
}

class TimetableData {
  TimetableData({
    required this.role,
    required this.semesterId,
    required this.timetable,
  });

  final String role;
  final int semesterId;
  final List<TimetableItem> timetable;

  bool get isStudent => role.toLowerCase() == 'student';

  factory TimetableData.fromJson(Map<String, dynamic> json) {
    return TimetableData(
      role: (json['role'] ?? '').toString(),
      semesterId: _toInt(json['semesterId']),
      timetable: (json['timetable'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(TimetableItem.fromJson)
          .toList(),
    );
  }
}

int _toInt(dynamic value) {
  if (value is int) {
    return value;
  }
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

int? _nullableInt(dynamic value) {
  if (value == null) {
    return null;
  }
  return _toInt(value);
}

String _timeOnly(dynamic value) {
  final raw = (value ?? '').toString();
  final match = RegExp(r'(\d{2}:\d{2})').firstMatch(raw);
  return match?.group(1) ?? raw;
}
