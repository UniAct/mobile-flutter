import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';
import 'package:mobile_flutter/features/auth/user_model.dart';
import 'package:mobile_flutter/features/attendance/attendance_dependencies.dart';
import 'package:mobile_flutter/features/attendance/attendance_models.dart';
import 'package:mobile_flutter/features/attendance/data/repositories/attendance_repository.dart';
import 'package:mobile_flutter/features/attendance/data/repositories/connectivity_repository.dart';
import 'package:mobile_flutter/features/attendance/data/repositories/sync_repository.dart';
import 'package:mobile_flutter/features/attendance/services/local_student_service.dart';
import 'package:mobile_flutter/features/attendance/services/sync_engine.dart';
import 'package:mobile_flutter/features/home/dashboard_models.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc({required AttendanceDependencies dependencies})
    : _dependencies = dependencies,
      super(AttendanceState.initial()) {
    on<AttendanceStarted>(_onStarted);
    on<AttendanceDateChanged>(_onDateChanged);
    on<AttendanceCourseSelected>(_onCourseSelected);
    on<AttendanceMarkToggled>(_onMarkToggled);
    on<AttendanceMarkAllRequested>(_onMarkAllRequested);
    on<AttendanceManualSubmitted>(_onManualSubmitted);
    on<AttendanceQrSubmitted>(_onQrSubmitted);
    on<AttendanceRefreshRequested>(_onRefreshRequested);
    on<AttendanceSyncRequested>(_onSyncRequested);
    on<_AttendanceCoursesUpdated>(_onCoursesUpdated);
    on<_AttendanceStudentsUpdated>(_onStudentsUpdated);
    on<_AttendanceSessionUpdated>(_onSessionUpdated);
    on<_AttendanceStudentStatusUpdated>(_onStudentStatusUpdated);
    on<_AttendancePendingCountUpdated>(_onPendingCountUpdated);
    on<_AttendanceSyncStateChanged>(_onSyncStateChanged);
    on<_AttendanceConnectivityChanged>(_onConnectivityChanged);
  }

  final AttendanceDependencies _dependencies;
  AttendanceRepository get _attendanceRepository =>
      _dependencies.attendanceRepository;
  SyncRepository get _syncRepository => _dependencies.syncRepository;
  ConnectivityRepository get _connectivityRepository =>
      _dependencies.connectivityRepository;
  SyncEngine get _syncEngine => _dependencies.syncEngine;
  LocalStudentService get _localStudentService =>
      _dependencies.localStudentService;

  StreamSubscription<List<StaffAttendanceCourseOption>>? _coursesSubscription;
  StreamSubscription<List<EnrolledStudent>>? _studentsSubscription;
  StreamSubscription<Map<String, dynamic>?>? _sessionSubscription;
  StreamSubscription<Map<String, dynamic>?>? _studentStatusSubscription;
  StreamSubscription<int>? _pendingCountSubscription;
  StreamSubscription<SyncState>? _syncStateSubscription;
  StreamSubscription<bool>? _connectivitySubscription;

  @override
  Future<void> close() async {
    await _coursesSubscription?.cancel();
    await _studentsSubscription?.cancel();
    await _sessionSubscription?.cancel();
    await _studentStatusSubscription?.cancel();
    await _pendingCountSubscription?.cancel();
    await _syncStateSubscription?.cancel();
    await _connectivitySubscription?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    AttendanceStarted event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(
      state.copyWith(
        mode: event.dashboard.isStudent
            ? AttendanceMode.student
            : AttendanceMode.staff,
        userName: event.user.name,
        userId: event.user.userId,
        semesterId: event.dashboard.semesterId,
        teacherId: event.dashboard.isStudent
            ? 0
            : (event.user.staffId ?? _toInt(event.user.userId)),
        isInitialized: true,
        selectedDate: DateTime.now(),
        qrSupported: _isQrSupported,
      ),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        await _dependencies.initialize();
      } catch (e) {
        debugPrint('[AttendanceBloc] Init error: $e');
        return;
      }

      final isOnlineNow = await _connectivityRepository.isConnected();
      add(_AttendanceConnectivityChanged(isOnlineNow));

      // Guard against duplicate subscriptions on re-init
      _pendingCountSubscription ??= _syncRepository.watchPendingCount().listen((
        count,
      ) {
        add(_AttendancePendingCountUpdated(count));
      });

      _syncStateSubscription ??= _syncEngine.syncStateStream.listen((
        syncState,
      ) {
        add(_AttendanceSyncStateChanged(syncState));
      });
      unawaited(_fetchSessionSnapshotForSelection());

      _connectivitySubscription ??= _connectivityRepository
          .onConnectivityChanged
          .listen((isConnected) {
            add(_AttendanceConnectivityChanged(isConnected));
          });

      if (event.dashboard.isStudent) {
        _syncEngine.onRefreshStudentStatus = () =>
            _attendanceRepository.fetchAndCacheStudentStatus(event.user.userId);
        _startStudentWatchers(event.user);
      } else {
        _syncEngine.onRefreshStudentStatus = null;
        _startStaffWatchers();
        unawaited(_fetchRemoteDataIfOnline());
      }
    });
  }

  Future<void> _onDateChanged(
    AttendanceDateChanged event,
    Emitter<AttendanceState> emit,
  ) async {
    final nextState = state.copyWith(selectedDate: event.date);
    emit(nextState);

    if (state.mode == AttendanceMode.staff && state.selectedCourse != null) {
      _startSessionWatcher();
      unawaited(_fetchSessionSnapshotForSelection());
      add(const AttendanceRefreshRequested());
    }
  }

  Future<void> _onCourseSelected(
    AttendanceCourseSelected event,
    Emitter<AttendanceState> emit,
  ) async {
    final course = state.courses
        .where((item) => item.contextId == event.contextId)
        .toList();
    if (course.isEmpty) {
      return;
    }

    final selectedCourse = course.first;
    emit(
      state.copyWith(
        selectedCourse: selectedCourse,
        currentPage: 0,
        loadingStudents: true,
      ),
    );

    if (state.mode == AttendanceMode.staff) {
      await _studentsSubscription?.cancel();
      _studentsSubscription = null;
      await _sessionSubscription?.cancel();
      _sessionSubscription = null;
      _startStaffWatchers();
      unawaited(_fetchStudentsForCourse(selectedCourse.contextId));
      unawaited(_fetchSessionSnapshotForSelection());
    }
  }

  Future<void> _onMarkToggled(
    AttendanceMarkToggled event,
    Emitter<AttendanceState> emit,
  ) async {
    final updated = Map<int, bool>.from(state.presentMap)
      ..[event.studentId] = event.isPresent;
    emit(state.copyWith(presentMap: updated));
  }

  Future<void> _onMarkAllRequested(
    AttendanceMarkAllRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    final updated = Map<int, bool>.from(state.presentMap);
    for (final student in state.students) {
      updated[student.studentId] = event.isPresent;
    }
    emit(state.copyWith(presentMap: updated));
  }

  Future<void> _onManualSubmitted(
    AttendanceManualSubmitted event,
    Emitter<AttendanceState> emit,
  ) async {
    final selectedCourse = state.selectedCourse;
    if (selectedCourse == null || state.students.isEmpty) {
      return;
    }

    emit(state.copyWith(isSaving: true, errorMessage: null));
    try {
      final records = state.students
          .map(
            (student) => ManualAttendanceRecord(
              studentId: student.studentId,
              status: (state.presentMap[student.studentId] ?? false)
                  ? 'present'
                  : 'absent',
            ),
          )
          .toList();

      await _attendanceRepository.submitManualAttendanceLocally(
        scheduleSlotId: selectedCourse.scheduleSlotId,
        facultyMemberId: state.teacherId,
        attendanceDate: state.selectedDate,
        startTime: selectedCourse.startTime,
        endTime: selectedCourse.endTime,
        records: records,
      );

      if (state.isOnline) {
        unawaited(_syncEngine.syncNow());
      }

      emit(
        state.copyWith(
          isSaving: false,
          toastMessage: 'Attendance saved successfully.',
          toastIsSuccess: true,
          toastSequence: state.toastSequence + 1,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: e.message,
          toastMessage: e.message,
          toastIsSuccess: false,
          toastSequence: state.toastSequence + 1,
        ),
      );
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: message,
          toastMessage: message,
          toastIsSuccess: false,
          toastSequence: state.toastSequence + 1,
        ),
      );
    }
  }

  Future<void> _onQrSubmitted(
    AttendanceQrSubmitted event,
    Emitter<AttendanceState> emit,
  ) async {
    final selectedCourse = state.selectedCourse;
    if (selectedCourse == null) {
      return;
    }

    try {
      // Step 1: Decode QR payload
      final qrData = _decodeQrPayload(event.qrPayload);
      var studentId = _toInt(qrData['studentId']);

      // Step 2: If studentId not in payload, try raw payload as ID
      if (studentId <= 0) {
        studentId = _toInt(event.qrPayload);
      }

      if (studentId <= 0) {
        emit(state.copyWith(errorMessage: 'Invalid QR code data.'));
        return;
      }

      // Step 3: OPTIMISTIC LOCAL VALIDATION (No API call)
      // Check if student exists in local DB BY QR (fast, indexed lookup)
      // Even if not in current course roster, we allow marking based on QR validity
      LocalStudent? student;
      try {
        // First try QR payload lookup (fastest, most reliable)
        student = await _localStudentService.findStudentByQr(event.qrPayload);

        // Fallback: look up by student ID if QR not in cache yet
        student ??= await _localStudentService.findStudentById(studentId);
      } catch (e) {
        debugPrint('[AttendanceBloc] Local student lookup failed: $e');
      }

      // Step 4: Mark attendance locally (instant UI update via streams)
      // Even if student is unknown, we still record with generic name (recoverable)
      final studentName = student?.fullName ?? 'Unknown Student';
      final resolvedStudentId = student?.id ?? studentId;

      final assignedToClass =
          state.students.isEmpty ||
          state.students.any((item) => item.studentId == resolvedStudentId);
      if (!assignedToClass) {
        const message = 'Student not assigned to this class.';
        emit(
          state.copyWith(
            errorMessage: message,
            toastMessage: message,
            toastIsSuccess: false,
            toastSequence: state.toastSequence + 1,
          ),
        );
        return;
      }

      await _attendanceRepository.applyQrAttendanceLocally(
        scheduleSlotId: selectedCourse.scheduleSlotId,
        attendanceDate: state.selectedDate,
        studentId: resolvedStudentId,
        status: 'present',
      );

      // Step 5: Queue for background sync
      await _attendanceRepository.submitQrScanLocally(
        scheduleSlotId: selectedCourse.scheduleSlotId,
        facultyMemberId: state.teacherId,
        attendanceDate: state.selectedDate,
        startTime: selectedCourse.startTime,
        endTime: selectedCourse.endTime,
        qrPayload: event.qrPayload,
      );

      // Step 6: Trigger sync if online (non-blocking)
      if (state.isOnline) {
        unawaited(_syncEngine.syncNow());
      }

      debugPrint(
        '[AttendanceBloc] QR attendance recorded: Student $resolvedStudentId ($studentName)',
      );
      emit(
        state.copyWith(
          errorMessage: null,
          toastMessage: '$studentName marked attendance successfully.',
          toastIsSuccess: true,
          toastSequence: state.toastSequence + 1,
        ),
      );
    } catch (e) {
      final message = 'QR scan failed: $e';
      emit(
        state.copyWith(
          errorMessage: message,
          toastMessage: message,
          toastIsSuccess: false,
          toastSequence: state.toastSequence + 1,
        ),
      );
    }
  }

  Future<void> _onRefreshRequested(
    AttendanceRefreshRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    if (state.mode == AttendanceMode.student) {
      return;
    }

    final selectedCourse = state.selectedCourse;
    if (selectedCourse == null) {
      return;
    }

    _startStaffWatchers();
    unawaited(_fetchSessionSnapshotForSelection());
  }

  Future<void> _onSyncRequested(
    AttendanceSyncRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    await _syncEngine.syncNow();
  }

  Future<void> _onCoursesUpdated(
    _AttendanceCoursesUpdated event,
    Emitter<AttendanceState> emit,
  ) async {
    final selectedCourse = _resolveSelectedCourse(event.courses);
    emit(
      state.copyWith(
        loadingCourses: false,
        loadingStudents: event.courses.isEmpty ? false : state.loadingStudents,
        courses: event.courses,
        selectedCourse: selectedCourse,
      ),
    );

    if (state.mode == AttendanceMode.staff && selectedCourse != null) {
      _startStaffWatchers(refreshCourses: false);
      unawaited(_fetchStudentsForCourse(selectedCourse.contextId));
      unawaited(_fetchSessionSnapshotForSelection());
    }
  }

  Future<void> _onStudentsUpdated(
    _AttendanceStudentsUpdated event,
    Emitter<AttendanceState> emit,
  ) async {
    final updatedPresentMap = <int, bool>{
      for (final student in event.students)
        student.studentId: state.presentMap[student.studentId] ?? false,
    };
    final updatedMarkedMap = <int, bool>{
      for (final student in event.students)
        student.studentId: state.alreadyMarkedMap[student.studentId] ?? false,
    };

    emit(
      state.copyWith(
        loadingStudents: false,
        students: event.students,
        presentMap: updatedPresentMap,
        alreadyMarkedMap: updatedMarkedMap,
        currentPage: 0,
      ),
    );
  }

  Future<void> _onSessionUpdated(
    _AttendanceSessionUpdated event,
    Emitter<AttendanceState> emit,
  ) async {
    final attendanceByStudentId = <int, bool>{};
    final records =
        (event.session?['attendance'] as List<dynamic>? ?? const <dynamic>[])
            .whereType<Map<String, dynamic>>();

    for (final record in records) {
      final studentId = _toInt(record['studentId']);
      if (studentId <= 0) {
        continue;
      }

      final status = (record['status'] ?? '').toString().toLowerCase();
      attendanceByStudentId[studentId] = status == 'present';
    }

    final updatedPresent = Map<int, bool>.from(state.presentMap);
    final updatedAlready = Map<int, bool>.from(state.alreadyMarkedMap);
    for (final student in state.students) {
      updatedAlready[student.studentId] = attendanceByStudentId.containsKey(
        student.studentId,
      );
      updatedPresent[student.studentId] =
          attendanceByStudentId[student.studentId] ??
          updatedPresent[student.studentId] ??
          false;
    }

    emit(
      state.copyWith(
        sessionSnapshot: event.session,
        loadingStudents: false,
        alreadyMarkedMap: updatedAlready,
        presentMap: updatedPresent,
      ),
    );
  }

  Future<void> _onStudentStatusUpdated(
    _AttendanceStudentStatusUpdated event,
    Emitter<AttendanceState> emit,
  ) async {
    final data = event.status == null
        ? null
        : StudentAttendanceStatusData.fromJson(event.status!);
    emit(state.copyWith(studentData: data, loadingStudentStatus: false));
  }

  Future<void> _onPendingCountUpdated(
    _AttendancePendingCountUpdated event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(pendingSyncCount: event.count));
  }

  Future<void> _onSyncStateChanged(
    _AttendanceSyncStateChanged event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(syncState: event.syncState));
  }

  Future<void> _onConnectivityChanged(
    _AttendanceConnectivityChanged event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(isOnline: event.isConnected));
    if (!event.isConnected) {
      return;
    }

    if (state.mode == AttendanceMode.staff) {
      unawaited(_fetchRemoteDataIfOnline());
      return;
    }

    if (state.mode == AttendanceMode.student) {
      final user = UserModel(
        userId: state.userId,
        name: state.userName,
        email: '',
        universityName: '',
        roles: const ['student'],
      );
      unawaited(_refreshStudentStatusIfOnline(user));
    }
  }

  void _startStudentWatchers(UserModel user) {
    _studentStatusSubscription ??= _attendanceRepository
        .watchStudentAttendanceStatus(user.userId)
        .listen((status) => add(_AttendanceStudentStatusUpdated(status)));

    unawaited(_refreshStudentStatusIfOnline(user));
  }

  Future<void> _refreshStudentStatusIfOnline(UserModel user) async {
    final isOnline = await _connectivityRepository.isConnected();
    if (!isOnline) {
      await _ensureOfflineQrPayload(user);
      return;
    }

    try {
      final status = await _attendanceRepository.fetchAndCacheStudentStatus(
        user.userId,
      );
      if (status == null || status.isEmpty) {
        await _ensureOfflineQrPayload(user);
      }
    } catch (e) {
      debugPrint('[AttendanceBloc] Student status refresh failed: $e');
      await _ensureOfflineQrPayload(user);
    }
  }

  Future<void> _ensureOfflineQrPayload(UserModel user) async {
    final current = state.studentData;
    if (current?.qrPayload.isNotEmpty == true) {
      add(
        _AttendanceStudentStatusUpdated({
          'semesterId': current!.semesterId,
          'timeline': current.timeline.map((item) => item.toJson()).toList(),
          'qrPayload': current.qrPayload,
        }),
      );
      return;
    }

    final cached = await _attendanceRepository
        .watchStudentAttendanceStatus(user.userId)
        .first;
    if (cached != null && cached.isNotEmpty) {
      add(_AttendanceStudentStatusUpdated(cached));
      return;
    }

    final offlineQr = await _attendanceRepository.getOfflineQrPayload(
      user.userId,
    );
    if (offlineQr != null && offlineQr.isNotEmpty) {
      add(
        _AttendanceStudentStatusUpdated({
          'semesterId': current?.semesterId ?? state.semesterId,
          'timeline': (current?.timeline ?? const <StudentAttendanceItem>[])
              .map((item) => item.toJson())
              .toList(),
          'qrPayload': offlineQr,
        }),
      );
      return;
    }

    add(
      _AttendanceStudentStatusUpdated(
        current == null
            ? null
            : {
                'semesterId': current.semesterId,
                'timeline': current.timeline
                    .map((item) => item.toJson())
                    .toList(),
                'qrPayload': current.qrPayload,
              },
      ),
    );
  }

  void _startStaffWatchers({bool refreshCourses = true}) {
    final course = _resolveSelectedCourse(state.courses);

    if (refreshCourses) {
      _coursesSubscription?.cancel();
      _coursesSubscription = _attendanceRepository
          .watchCoursesCached(
            semesterId: state.semesterId,
            teacherId: state.teacherId,
          )
          .listen((courses) => add(_AttendanceCoursesUpdated(courses)));
    }

    if (course == null) {
      return;
    }

    _studentsSubscription ??= _attendanceRepository
        .watchStudentsCached(course.contextId)
        .listen((students) => add(_AttendanceStudentsUpdated(students)));

    _startSessionWatcher();
  }

  void _startSessionWatcher() {
    final course = _resolveSelectedCourse(state.courses);
    if (course == null) {
      return;
    }

    _sessionSubscription?.cancel();
    _sessionSubscription = _attendanceRepository
        .watchSessionSnapshot(
          scheduleSlotId: course.scheduleSlotId,
          attendanceDate: state.selectedDate,
        )
        .listen((session) => add(_AttendanceSessionUpdated(session)));
  }

  Future<void> _fetchRemoteDataIfOnline() async {
    final isOnline = await _connectivityRepository.isConnected();
    if (!isOnline) {
      return;
    }

    try {
      final courses = await _attendanceRepository.fetchAndCacheCourses(
        semesterId: state.semesterId,
        teacherId: state.teacherId,
      );

      final course = state.selectedCourse ?? _resolveSelectedCourse(courses);
      if (course != null) {
        await _attendanceRepository.fetchAndCacheStudents(course.contextId);
      }
    } catch (e) {
      debugPrint(
        '[AttendanceBloc] Background remote fetch failed (non-fatal): $e',
      );
    }
  }

  Future<void> _fetchStudentsForCourse(int contextId) async {
    final isOnline = await _connectivityRepository.isConnected();
    if (!isOnline) {
      return;
    }

    try {
      await _attendanceRepository.fetchAndCacheStudents(contextId);
      unawaited(_fetchSessionSnapshotForSelection());
    } catch (e) {
      debugPrint('[AttendanceBloc] Student fetch failed (non-fatal): $e');
    }
  }

  Future<void> _fetchSessionSnapshotForSelection() async {
    final selectedCourse = state.selectedCourse;
    if (selectedCourse == null) {
      return;
    }

    final isOnline = await _connectivityRepository.isConnected();
    if (!isOnline) {
      return;
    }

    try {
      await _attendanceRepository.fetchAndCacheSessionSnapshot(
        scheduleSlotId: selectedCourse.scheduleSlotId,
        attendanceDate: state.selectedDate,
      );
    } catch (e) {
      debugPrint(
        '[AttendanceBloc] Session snapshot fetch failed (non-fatal): $e',
      );
    }
  }

  StaffAttendanceCourseOption? _resolveSelectedCourse(
    List<StaffAttendanceCourseOption> courses,
  ) {
    if (courses.isEmpty) {
      return null;
    }

    final selected = state.selectedCourse;
    if (selected != null) {
      final found = courses
          .where((item) => item.contextId == selected.contextId)
          .toList();
      if (found.isNotEmpty) {
        return found.first;
      }
    }

    return courses.first;
  }

  Map<String, dynamic> _decodeQrPayload(String value) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } catch (_) {}
    return <String, dynamic>{};
  }

  int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is String) {
      return int.tryParse(value) ?? 0;
    }

    if (value is num) {
      return value.toInt();
    }

    return 0;
  }

  bool get _isQrSupported =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
}
