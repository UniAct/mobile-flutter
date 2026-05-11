part of 'attendance_bloc.dart';

enum AttendanceMode { initial, student, staff }

class AttendanceState extends Equatable {
  const AttendanceState({
    required this.mode,
    required this.isInitialized,
    required this.isOnline,
    required this.syncState,
    required this.pendingSyncCount,
    required this.selectedDate,
    required this.courses,
    required this.selectedCourse,
    required this.students,
    required this.presentMap,
    required this.alreadyMarkedMap,
    required this.studentData,
    required this.sessionSnapshot,
    required this.loadingCourses,
    required this.loadingStudents,
    required this.loadingStudentStatus,
    required this.isSaving,
    required this.errorMessage,
    required this.toastMessage,
    required this.toastIsSuccess,
    required this.toastSequence,
    required this.currentPage,
    required this.qrSupported,
    required this.userId,
    required this.userName,
    required this.semesterId,
    required this.teacherId,
  });

  factory AttendanceState.initial() {
    return AttendanceState(
      mode: AttendanceMode.initial,
      isInitialized: false,
      isOnline: false,
      syncState: SyncState.idle,
      pendingSyncCount: 0,
      selectedDate: DateTime.now(),
      courses: const <StaffAttendanceCourseOption>[],
      selectedCourse: null,
      students: const <EnrolledStudent>[],
      presentMap: const <int, bool>{},
      alreadyMarkedMap: const <int, bool>{},
      studentData: null,
      sessionSnapshot: null,
      loadingCourses: true,
      loadingStudents: true,
      loadingStudentStatus: true,
      isSaving: false,
      errorMessage: null,
      toastMessage: null,
      toastIsSuccess: true,
      toastSequence: 0,
      currentPage: 0,
      qrSupported: false,
      userId: '',
      userName: '',
      semesterId: 0,
      teacherId: 0,
    );
  }

  final AttendanceMode mode;
  final bool isInitialized;
  final bool isOnline;
  final SyncState syncState;
  final int pendingSyncCount;
  final DateTime selectedDate;
  final List<StaffAttendanceCourseOption> courses;
  final StaffAttendanceCourseOption? selectedCourse;
  final List<EnrolledStudent> students;
  final Map<int, bool> presentMap;
  final Map<int, bool> alreadyMarkedMap;
  final StudentAttendanceStatusData? studentData;
  final Map<String, dynamic>? sessionSnapshot;
  final bool loadingCourses;
  final bool loadingStudents;
  final bool loadingStudentStatus;
  final bool isSaving;
  final String? errorMessage;
  final String? toastMessage;
  final bool toastIsSuccess;
  final int toastSequence;
  final int currentPage;
  final bool qrSupported;
  final String userId;
  final String userName;
  final int semesterId;
  final int teacherId;

  AttendanceState copyWith({
    AttendanceMode? mode,
    bool? isInitialized,
    bool? isOnline,
    SyncState? syncState,
    int? pendingSyncCount,
    DateTime? selectedDate,
    List<StaffAttendanceCourseOption>? courses,
    StaffAttendanceCourseOption? selectedCourse,
    List<EnrolledStudent>? students,
    Map<int, bool>? presentMap,
    Map<int, bool>? alreadyMarkedMap,
    StudentAttendanceStatusData? studentData,
    Map<String, dynamic>? sessionSnapshot,
    bool? loadingCourses,
    bool? loadingStudents,
    bool? loadingStudentStatus,
    bool? isSaving,
    String? errorMessage,
    String? toastMessage,
    bool? toastIsSuccess,
    int? toastSequence,
    int? currentPage,
    bool? qrSupported,
    String? userId,
    String? userName,
    int? semesterId,
    int? teacherId,
  }) {
    return AttendanceState(
      mode: mode ?? this.mode,
      isInitialized: isInitialized ?? this.isInitialized,
      isOnline: isOnline ?? this.isOnline,
      syncState: syncState ?? this.syncState,
      pendingSyncCount: pendingSyncCount ?? this.pendingSyncCount,
      selectedDate: selectedDate ?? this.selectedDate,
      courses: courses ?? this.courses,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      students: students ?? this.students,
      presentMap: presentMap ?? this.presentMap,
      alreadyMarkedMap: alreadyMarkedMap ?? this.alreadyMarkedMap,
      studentData: studentData ?? this.studentData,
      sessionSnapshot: sessionSnapshot ?? this.sessionSnapshot,
      loadingCourses: loadingCourses ?? this.loadingCourses,
      loadingStudents: loadingStudents ?? this.loadingStudents,
      loadingStudentStatus: loadingStudentStatus ?? this.loadingStudentStatus,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
      toastMessage: toastMessage ?? this.toastMessage,
      toastIsSuccess: toastIsSuccess ?? this.toastIsSuccess,
      toastSequence: toastSequence ?? this.toastSequence,
      currentPage: currentPage ?? this.currentPage,
      qrSupported: qrSupported ?? this.qrSupported,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      semesterId: semesterId ?? this.semesterId,
      teacherId: teacherId ?? this.teacherId,
    );
  }

  @override
  List<Object?> get props => [
    mode,
    isInitialized,
    isOnline,
    syncState,
    pendingSyncCount,
    selectedDate,
    courses,
    selectedCourse,
    students,
    presentMap,
    alreadyMarkedMap,
    studentData,
    sessionSnapshot,
    loadingCourses,
    loadingStudents,
    loadingStudentStatus,
    isSaving,
    errorMessage,
    toastMessage,
    toastIsSuccess,
    toastSequence,
    currentPage,
    qrSupported,
    userId,
    userName,
    semesterId,
    teacherId,
  ];
}
