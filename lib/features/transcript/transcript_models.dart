class TranscriptCourse {
  TranscriptCourse({
    required this.registrationId,
    required this.courseCode,
    required this.courseName,
    required this.credits,
    required this.grade,
    required this.gradePoints,
    required this.status,
    required this.totalMarks,
    required this.totalMaxMarks,
    required this.scorePercentage,
  });

  final int registrationId;
  final String courseCode;
  final String courseName;
  final int credits;
  final String? grade;
  final double? gradePoints;
  final String status;
  final double totalMarks;
  final double totalMaxMarks;
  final double? scorePercentage;

  factory TranscriptCourse.fromJson(Map<String, dynamic> json) {
    return TranscriptCourse(
      registrationId: _toInt(json['registrationId']),
      courseCode: (json['courseCode'] ?? '').toString(),
      courseName: (json['courseName'] ?? 'Course').toString(),
      credits: _toInt(json['credits']),
      grade: json['grade']?.toString(),
      gradePoints: _nullableDouble(json['gradePoints']),
      status: (json['status'] ?? '').toString(),
      totalMarks: _toDouble(json['totalMarks']),
      totalMaxMarks: _toDouble(json['totalMaxMarks']),
      scorePercentage: _nullableDouble(json['scorePercentage']),
    );
  }
}

class TranscriptSemesterInfo {
  TranscriptSemesterInfo({
    required this.id,
    required this.year,
    required this.term,
    required this.type,
  });

  final int id;
  final int year;
  final int term;
  final String type;

  String get label => '$type $term - $year';

  factory TranscriptSemesterInfo.fromJson(Map<String, dynamic>? json) {
    json ??= <String, dynamic>{};
    return TranscriptSemesterInfo(
      id: _toInt(json['id']),
      year: _toInt(json['year']),
      term: _toInt(json['term']),
      type: (json['type'] ?? 'Semester').toString(),
    );
  }
}

class TranscriptTerm {
  TranscriptTerm({
    required this.id,
    required this.semesterId,
    required this.semester,
    required this.semesterGpa,
    required this.cumulativeGpa,
    required this.totalCredits,
    required this.courses,
  });

  final int id;
  final int semesterId;
  final TranscriptSemesterInfo semester;
  final double semesterGpa;
  final double cumulativeGpa;
  final int totalCredits;
  final List<TranscriptCourse> courses;

  factory TranscriptTerm.fromJson(Map<String, dynamic> json) {
    return TranscriptTerm(
      id: _toInt(json['id']),
      semesterId: _toInt(json['semesterId']),
      semester: TranscriptSemesterInfo.fromJson(
        json['semester'] as Map<String, dynamic>?,
      ),
      semesterGpa: _toDouble(json['semesterGpa']),
      cumulativeGpa: _toDouble(json['cumulativeGpa']),
      totalCredits: _toInt(json['totalCredits']),
      courses: (json['courses'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(TranscriptCourse.fromJson)
          .toList(),
    );
  }
}

class TranscriptData {
  TranscriptData({required this.studentId, required this.semesters});

  final int studentId;
  final List<TranscriptTerm> semesters;

  factory TranscriptData.fromJson(Map<String, dynamic> json) {
    return TranscriptData(
      studentId: _toInt(json['studentId']),
      semesters: (json['semesters'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(TranscriptTerm.fromJson)
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

double _toDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

double? _nullableDouble(dynamic value) {
  if (value == null) {
    return null;
  }
  return _toDouble(value);
}
