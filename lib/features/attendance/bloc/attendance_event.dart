part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class AttendanceStarted extends AttendanceEvent {
  const AttendanceStarted({required this.user, required this.dashboard});

  final UserModel user;
  final DashboardData dashboard;

  @override
  List<Object?> get props => [user, dashboard];
}

class AttendanceDateChanged extends AttendanceEvent {
  const AttendanceDateChanged(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class AttendanceCourseSelected extends AttendanceEvent {
  const AttendanceCourseSelected(this.contextId);

  final int contextId;

  @override
  List<Object?> get props => [contextId];
}

class AttendanceMarkToggled extends AttendanceEvent {
  const AttendanceMarkToggled({
    required this.studentId,
    required this.isPresent,
  });

  final int studentId;
  final bool isPresent;

  @override
  List<Object?> get props => [studentId, isPresent];
}

class AttendanceMarkAllRequested extends AttendanceEvent {
  const AttendanceMarkAllRequested(this.isPresent);

  final bool isPresent;

  @override
  List<Object?> get props => [isPresent];
}

class AttendanceManualSubmitted extends AttendanceEvent {
  const AttendanceManualSubmitted();
}

class AttendanceQrSubmitted extends AttendanceEvent {
  const AttendanceQrSubmitted(this.qrPayload);

  final String qrPayload;

  @override
  List<Object?> get props => [qrPayload];
}

class AttendanceRefreshRequested extends AttendanceEvent {
  const AttendanceRefreshRequested();
}

class AttendanceSyncRequested extends AttendanceEvent {
  const AttendanceSyncRequested();
}

class _AttendanceCoursesUpdated extends AttendanceEvent {
  const _AttendanceCoursesUpdated(this.courses);

  final List<StaffAttendanceCourseOption> courses;

  @override
  List<Object?> get props => [courses];
}

class _AttendanceStudentsUpdated extends AttendanceEvent {
  const _AttendanceStudentsUpdated(this.students);

  final List<EnrolledStudent> students;

  @override
  List<Object?> get props => [students];
}

class _AttendanceSessionUpdated extends AttendanceEvent {
  const _AttendanceSessionUpdated(this.session);

  final Map<String, dynamic>? session;

  @override
  List<Object?> get props => [session];
}

class _AttendanceStudentStatusUpdated extends AttendanceEvent {
  const _AttendanceStudentStatusUpdated(this.status);

  final Map<String, dynamic>? status;

  @override
  List<Object?> get props => [status];
}

class _AttendancePendingCountUpdated extends AttendanceEvent {
  const _AttendancePendingCountUpdated(this.count);

  final int count;

  @override
  List<Object?> get props => [count];
}

class _AttendanceSyncStateChanged extends AttendanceEvent {
  const _AttendanceSyncStateChanged(this.syncState);

  final SyncState syncState;

  @override
  List<Object?> get props => [syncState];
}

class _AttendanceConnectivityChanged extends AttendanceEvent {
  const _AttendanceConnectivityChanged(this.isConnected);

  final bool isConnected;

  @override
  List<Object?> get props => [isConnected];
}
