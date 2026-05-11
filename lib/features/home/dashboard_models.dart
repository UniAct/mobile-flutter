class DashboardStats {
  DashboardStats({
    this.registeredCourses = 0,
    this.registeredCreditHours = 0,
    this.totalSessions = 0,
    this.distinctCourseCount = 0,
    this.enrolledStudents = 0,
  });

  final int registeredCourses;
  final int registeredCreditHours;
  final int totalSessions;
  final int distinctCourseCount;
  final int enrolledStudents;

  factory DashboardStats.fromJson(Map<String, dynamic>? json) {
    json ??= <String, dynamic>{};

    return DashboardStats(
      registeredCourses: _toInt(json['registeredCourses']),
      registeredCreditHours: _toInt(json['registeredCreditHours']),
      totalSessions: _toInt(json['totalSessions']),
      distinctCourseCount: _toInt(json['distinctCourseCount']),
      enrolledStudents: _toInt(json['enrolledStudents']),
    );
  }

  Map<String, dynamic> toJson() => {
    'registeredCourses': registeredCourses,
    'registeredCreditHours': registeredCreditHours,
    'totalSessions': totalSessions,
    'distinctCourseCount': distinctCourseCount,
    'enrolledStudents': enrolledStudents,
  };

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class DashboardScheduleItem {
  DashboardScheduleItem({
    required this.slotId,
    required this.title,
    required this.courseCode,
    required this.startTime,
    required this.endTime,
    required this.classroomLabel,
    required this.dayOfWeek,
    this.teacherName,
    this.registrationStatus,
    this.slotContextIds = const <int>[],
  });

  final int slotId;
  final String title;
  final String courseCode;
  final String startTime;
  final String endTime;
  final String classroomLabel;
  final String dayOfWeek;
  final String? teacherName;
  final String? registrationStatus;
  final List<int> slotContextIds;

  factory DashboardScheduleItem.fromStudentJson(Map<String, dynamic> json) {
    final slotContext =
        (json['scheduleSlotContext'] as Map<String, dynamic>?) ??
        <String, dynamic>{};
    final slot =
        (slotContext['slot'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final course =
        (slot['course'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final classroom =
        (slot['classroom'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final teacher =
        ((slot['teacher'] as Map<String, dynamic>?)?['user']
            as Map<String, dynamic>?) ??
        <String, dynamic>{};

    return DashboardScheduleItem(
      slotId: _toInt(slot['id']),
      title: (course['name'] ?? 'Course').toString(),
      courseCode: (course['code'] ?? '').toString(),
      startTime: _timeOnly(slot['startTime']),
      endTime: _timeOnly(slot['endTime']),
      classroomLabel:
          '${(classroom['building'] ?? '').toString()} / ${(classroom['classroomNumber'] ?? '').toString()}',
      dayOfWeek: (slot['dayOfWeek'] ?? '').toString(),
      teacherName:
          '${(teacher['firstName'] ?? '').toString()} ${(teacher['lastName'] ?? '').toString()}'
              .trim(),
      registrationStatus: (json['status'] ?? '').toString(),
      slotContextIds: <int>[_toInt(slotContext['id'])],
    );
  }

  factory DashboardScheduleItem.fromStaffJson(Map<String, dynamic> json) {
    final course =
        (json['course'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final classroom =
        (json['classroom'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final contexts = (json['slotContext'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((ctx) => _toInt(ctx['id']))
        .where((value) => value > 0)
        .toList();

    return DashboardScheduleItem(
      slotId: _toInt(json['id']),
      title: (course['name'] ?? 'Course').toString(),
      courseCode: (course['code'] ?? '').toString(),
      startTime: _timeOnly(json['startTime']),
      endTime: _timeOnly(json['endTime']),
      classroomLabel:
          '${(classroom['building'] ?? '').toString()} / ${(classroom['classroomNumber'] ?? '').toString()}',
      dayOfWeek: (json['dayOfWeek'] ?? '').toString(),
      slotContextIds: contexts,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': slotId,
    'slotId': slotId,
    'title': title,
    'courseCode': courseCode,
    'startTime': startTime,
    'endTime': endTime,
    'classroomLabel': classroomLabel,
    'dayOfWeek': dayOfWeek,
    'teacherName': teacherName,
    'registrationStatus': registrationStatus,
    'slotContextIds': slotContextIds,
    'course': {'name': title, 'code': courseCode},
    'classroom': {'building': classroomLabel, 'classroomNumber': ''},
    'slotContext': [
      for (final id in slotContextIds) {'id': id},
    ],
    'scheduleSlotContext': {
      'id': slotContextIds.isNotEmpty ? slotContextIds.first : 0,
      'slot': {
        'id': slotId,
        'startTime': startTime,
        'endTime': endTime,
        'dayOfWeek': dayOfWeek,
        'course': {'name': title, 'code': courseCode},
        'classroom': {'building': classroomLabel, 'classroomNumber': ''},
        'teacher': {
          'user': {'firstName': teacherName ?? '', 'lastName': ''},
        },
      },
    },
    'status': registrationStatus,
  };

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static String _timeOnly(dynamic value) {
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
}

class DashboardData {
  DashboardData({
    required this.role,
    required this.dayOfWeek,
    required this.semesterId,
    required this.stats,
    required this.todaySchedule,
  });

  final String role;
  final String dayOfWeek;
  final int semesterId;
  final DashboardStats stats;
  final List<DashboardScheduleItem> todaySchedule;

  bool get isStudent => role.toLowerCase() == 'student';

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    final role = (json['role'] ?? '').toString();
    final scheduleList = (json['todaySchedule'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((item) {
          if (role.toLowerCase() == 'student') {
            return DashboardScheduleItem.fromStudentJson(item);
          }

          return DashboardScheduleItem.fromStaffJson(item);
        })
        .toList();

    return DashboardData(
      role: role,
      dayOfWeek: (json['dayOfWeek'] ?? '').toString(),
      semesterId: int.tryParse((json['semesterId'] ?? '0').toString()) ?? 0,
      stats: DashboardStats.fromJson(json['stats'] as Map<String, dynamic>?),
      todaySchedule: scheduleList,
    );
  }

  Map<String, dynamic> toJson() => {
    'role': role,
    'dayOfWeek': dayOfWeek,
    'semesterId': semesterId,
    'stats': stats.toJson(),
    'todaySchedule': todaySchedule.map((item) => item.toJson()).toList(),
  };
}
