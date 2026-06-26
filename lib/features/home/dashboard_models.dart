class DashboardStats {
  DashboardStats({
    this.registeredCourses = 0,
    this.registeredCreditHours = 0,
    this.completedCourses = 0,
    this.completedCreditHours = 0,
    this.totalSessions = 0,
    this.distinctCourseCount = 0,
    this.enrolledStudents = 0,
  });

  final int registeredCourses;
  final int registeredCreditHours;
  final int completedCourses;
  final int completedCreditHours;
  final int totalSessions;
  final int distinctCourseCount;
  final int enrolledStudents;

  factory DashboardStats.fromJson(Map<String, dynamic>? json) {
    json ??= <String, dynamic>{};

    return DashboardStats(
      registeredCourses: _toInt(json['registeredCourses']),
      registeredCreditHours: _toInt(json['registeredCreditHours']),
      completedCourses: _toInt(json['completedCourses']),
      completedCreditHours: _toInt(json['completedCreditHours']),
      totalSessions: _toInt(json['totalSessions']),
      distinctCourseCount: _toInt(json['distinctCourseCount']),
      enrolledStudents: _toInt(json['enrolledStudents']),
    );
  }

  Map<String, dynamic> toJson() => {
    'registeredCourses': registeredCourses,
    'registeredCreditHours': registeredCreditHours,
    'completedCourses': completedCourses,
    'completedCreditHours': completedCreditHours,
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

class CreditProgressSegment {
  CreditProgressSegment({
    required this.label,
    required this.completedCreditHours,
    required this.requiredCreditHours,
    required this.remainingCreditHours,
    required this.percent,
  });

  final String label;
  final int completedCreditHours;
  final int requiredCreditHours;
  final int remainingCreditHours;
  final double percent;

  factory CreditProgressSegment.fromJson(Map<String, dynamic> json) {
    return CreditProgressSegment(
      label: (json['label'] ?? '').toString(),
      completedCreditHours: DashboardStats._toInt(json['completedCreditHours']),
      requiredCreditHours: DashboardStats._toInt(json['requiredCreditHours']),
      remainingCreditHours: DashboardStats._toInt(json['remainingCreditHours']),
      percent: _toDouble(json['percent']),
    );
  }

  Map<String, dynamic> toJson() => {
    'label': label,
    'completedCreditHours': completedCreditHours,
    'requiredCreditHours': requiredCreditHours,
    'remainingCreditHours': remainingCreditHours,
    'percent': percent,
  };

  static double _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class CreditProgress {
  CreditProgress({
    required this.completedCourses,
    required this.completedCreditHours,
    required this.totalRequiredCreditHours,
    required this.remainingCreditHours,
    required this.percent,
    required this.segments,
  });

  final int completedCourses;
  final int completedCreditHours;
  final int totalRequiredCreditHours;
  final int remainingCreditHours;
  final double percent;
  final List<CreditProgressSegment> segments;

  factory CreditProgress.fromJson(Map<String, dynamic>? json) {
    json ??= <String, dynamic>{};
    final segments = (json['segments'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(CreditProgressSegment.fromJson)
        .toList();

    return CreditProgress(
      completedCourses: DashboardStats._toInt(json['completedCourses']),
      completedCreditHours: DashboardStats._toInt(json['completedCreditHours']),
      totalRequiredCreditHours: DashboardStats._toInt(
        json['totalRequiredCreditHours'],
      ),
      remainingCreditHours: DashboardStats._toInt(json['remainingCreditHours']),
      percent: CreditProgressSegment._toDouble(json['percent']),
      segments: segments,
    );
  }

  Map<String, dynamic> toJson() => {
    'completedCourses': completedCourses,
    'completedCreditHours': completedCreditHours,
    'totalRequiredCreditHours': totalRequiredCreditHours,
    'remainingCreditHours': remainingCreditHours,
    'percent': percent,
    'segments': segments.map((segment) => segment.toJson()).toList(),
  };
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
    this.creditProgress,
  });

  final String role;
  final String dayOfWeek;
  final int semesterId;
  final DashboardStats stats;
  final List<DashboardScheduleItem> todaySchedule;
  final CreditProgress? creditProgress;

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
      creditProgress: json['creditProgress'] is Map<String, dynamic>
          ? CreditProgress.fromJson(
              json['creditProgress'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'role': role,
    'dayOfWeek': dayOfWeek,
    'semesterId': semesterId,
    'stats': stats.toJson(),
    'todaySchedule': todaySchedule.map((item) => item.toJson()).toList(),
    'creditProgress': creditProgress?.toJson(),
  };
}
