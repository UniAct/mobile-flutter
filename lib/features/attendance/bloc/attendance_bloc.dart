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
  final Set<int> _processingQrStudentIds = <int>{};
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
    final rawTeacherId = event.user.staffId;
    if (!event.dashboard.isStudent &&
        (rawTeacherId == null || rawTeacherId <= 0)) {
      debugPrint(
        '[AttendanceBloc] WARNING: staffId is null/zero. Courses may not '
        'filter correctly. userId=${event.user.userId}',
      );
    }
    final resolvedTeacherId = rawTeacherId != null && rawTeacherId > 0
        ? rawTeacherId
        : _toInt(event.user.userId);

    emit(
      state.copyWith(
        mode: event.dashboard.isStudent
            ? AttendanceMode.student
            : AttendanceMode.staff,
        userName: event.user.name,
        userId: event.user.userId,
        semesterId: event.dashboard.semesterId,
        teacherId: event.dashboard.isStudent ? 0 : resolvedTeacherId,
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
    final resetPresentMap = <int, bool>{
      for (final student in state.students) student.studentId: false,
    };
    final resetMarkedMap = <int, bool>{
      for (final student in state.students) student.studentId: false,
    };
    final nextState = state.copyWith(
      selectedDate: event.date,
      presentMap: resetPresentMap,
      alreadyMarkedMap: resetMarkedMap,
      clearSessionSnapshot: true,
    );
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
        students: const <EnrolledStudent>[],
        presentMap: const <int, bool>{},
        alreadyMarkedMap: const <int, bool>{},
        clearSessionSnapshot: true,
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
          syncState: state.isOnline ? state.syncState : SyncStatus.offline,
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

    final qrData = _decodeQrPayload(event.qrPayload);
    final studentId = _resolveQrStudentId(qrData, event.qrPayload);

    var didMarkProcessing = false;

    try {
      if (studentId <= 0) {
        const message = 'Invalid QR code data.';
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

      LocalStudent? student;
      try {
        student = await _localStudentService.findStudentByQr(event.qrPayload);
        student ??= await _localStudentService.findStudentById(studentId);
      } catch (e) {
        debugPrint('[AttendanceBloc] Local student lookup failed: $e');
      }

      final localStudentId = student?.id ?? studentId;
      final rosterStudent =
          _findRosterStudent(studentId) ??
          (localStudentId != studentId
              ? _findRosterStudent(localStudentId)
              : null);
      final displayName =
          rosterStudent?.fullName ??
          student?.fullName ??
          _resolveQrStudentName(qrData);
      final universityStudentId = _resolveUniversityStudentId(
        qrData,
        student,
        rosterStudent,
      );
      final resolvedStudentLabel = _formatStudentLabel(
        name: displayName,
        universityStudentId: universityStudentId,
      );

      if (_processingQrStudentIds.contains(studentId)) {
        debugPrint(
          '[AttendanceBloc] Ignoring duplicate QR frame while processing: '
          '$studentId ($resolvedStudentLabel)',
        );
        return;
      }

      _processingQrStudentIds.add(studentId);
      didMarkProcessing = true;

      final resolvedStudentId = rosterStudent?.studentId ?? localStudentId;
      final displayLabel = _formatStudentLabel(
        name:
            rosterStudent?.fullName ??
            student?.fullName ??
            _resolveQrStudentName(qrData),
        universityStudentId: universityStudentId,
      );

      final assignedToClass = rosterStudent != null;
      if (!assignedToClass) {
        final message = '$displayLabel is not enrolled in this class.';
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

      var sessionSnapshot = state.sessionSnapshot;
      if (sessionSnapshot == null && state.isOnline) {
        sessionSnapshot = await _attendanceRepository
            .fetchAndCacheSessionSnapshot(
              scheduleSlotId: selectedCourse.scheduleSlotId,
              attendanceDate: state.selectedDate,
            );
      }

      final existingAttendanceStatus = _existingAttendanceStatus(
        resolvedStudentId,
        sessionSnapshot: sessionSnapshot,
      );
      if (existingAttendanceStatus == 'present' ||
          existingAttendanceStatus == 'late') {
        emit(
          state.copyWith(
            errorMessage: '$displayLabel attendance already taken.',
            toastMessage: '$displayLabel attendance already taken.',
            toastType: AttendanceToastType.warning,
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
        studentId: resolvedStudentId,
        attendanceDate: state.selectedDate,
        startTime: selectedCourse.startTime,
        endTime: selectedCourse.endTime,
        qrPayload: event.qrPayload,
      );

      // Step 6: Trigger sync if online (non-blocking)
      if (state.isOnline) {
        unawaited(_syncEngine.syncNow());
      }

      final updatedPresentMap = Map<int, bool>.from(state.presentMap)
        ..[resolvedStudentId] = true;
      final updatedAlreadyMarkedMap = Map<int, bool>.from(
        state.alreadyMarkedMap,
      )..[resolvedStudentId] = true;

      debugPrint(
        '[AttendanceBloc] QR attendance recorded: Student $resolvedStudentId ($displayLabel)',
      );
      emit(
        state.copyWith(
          errorMessage: null,
          presentMap: updatedPresentMap,
          alreadyMarkedMap: updatedAlreadyMarkedMap,
          syncState: state.isOnline ? state.syncState : SyncStatus.offline,
          toastMessage: '$displayLabel attendance saved.',
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
    } finally {
      if (didMarkProcessing) {
        _processingQrStudentIds.remove(studentId);
      }
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

      final status = _normalizeAttendanceStatus(record['status']);
      attendanceByStudentId[studentId] =
          status == 'present' || status == 'late';
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
        clearSessionSnapshot: event.session == null,
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

  int _resolveQrStudentId(Map<String, dynamic> qrData, String qrPayload) {
    final candidates = <dynamic>[
      qrData['studentId'],
      qrData['student_id'],
      qrData['id'],
    ];

    for (final candidate in candidates) {
      final value = _toInt(candidate);
      if (value > 0) {
        return value;
      }
    }

    final nestedStudent = qrData['student'];
    if (nestedStudent is Map<String, dynamic>) {
      final nestedCandidates = <dynamic>[
        nestedStudent['studentId'],
        nestedStudent['student_id'],
        nestedStudent['id'],
        nestedStudent['userId'],
      ];

      for (final candidate in nestedCandidates) {
        final value = _toInt(candidate);
        if (value > 0) {
          return value;
        }
      }
    }

    return _toInt(qrPayload);
  }

  EnrolledStudent? _findRosterStudent(int studentId) {
    for (final student in state.students) {
      if (student.studentId == studentId) {
        return student;
      }
    }
    return null;
  }

  String? _resolveUniversityStudentId(
    Map<String, dynamic> qrData,
    LocalStudent? student,
    EnrolledStudent? rosterStudent,
  ) {
    final candidates = <Object?>[
      rosterStudent?.universityStudentId,
      student?.universityStudentId,
      qrData['universityStudentId'],
      qrData['university_student_id'],
      qrData['universityId'],
      qrData['university_id'],
      qrData['student'] is Map<String, dynamic>
          ? (qrData['student'] as Map<String, dynamic>)['universityStudentId']
          : null,
      qrData['student'] is Map<String, dynamic>
          ? (qrData['student'] as Map<String, dynamic>)['university_student_id']
          : null,
    ];

    for (final candidate in candidates) {
      final value = candidate?.toString().trim();
      if (value != null && value.isNotEmpty) {
        return value;
      }
    }

    return null;
  }

  String? _resolveQrStudentName(Map<String, dynamic> qrData) {
    final nestedStudent = qrData['student'];
    final nestedUser = nestedStudent is Map<String, dynamic>
        ? nestedStudent['user']
        : null;
    final candidates = <Object?>[
      qrData['fullName'],
      qrData['full_name'],
      qrData['name'],
      nestedStudent is Map<String, dynamic> ? nestedStudent['fullName'] : null,
      nestedStudent is Map<String, dynamic> ? nestedStudent['name'] : null,
      nestedUser is Map<String, dynamic>
          ? '${nestedUser['firstName'] ?? ''} ${nestedUser['lastName'] ?? ''}'
          : null,
    ];

    for (final candidate in candidates) {
      final value = candidate?.toString().trim();
      if (value != null && value.isNotEmpty) {
        return value;
      }
    }

    return null;
  }

  String? _existingAttendanceStatus(
    int studentId, {
    Map<String, dynamic>? sessionSnapshot,
  }) {
    final effectiveSnapshot = sessionSnapshot ?? state.sessionSnapshot;
    final attendance =
        (effectiveSnapshot?['attendance'] as List<dynamic>? ??
                const <dynamic>[])
            .whereType<Map<String, dynamic>>();
    for (final item in attendance) {
      if (_toInt(item['studentId']) == studentId) {
        return _normalizeAttendanceStatus(item['status']);
      }
    }

    if (state.alreadyMarkedMap[studentId] == true) {
      return (state.presentMap[studentId] ?? false) ? 'present' : 'absent';
    }

    return null;
  }

  String _normalizeAttendanceStatus(dynamic value) {
    final normalized = value?.toString().trim().toLowerCase() ?? '';
    return switch (normalized) {
      'present' => 'present',
      'late' => 'late',
      'absent' => 'absent',
      'excused' => 'excused',
      'medical' => 'medical',
      _ => normalized,
    };
  }

  String _formatStudentLabel({
    required String? name,
    String? universityStudentId,
  }) {
    final cleanedName = name?.trim();
    final cleanedUniversityId = universityStudentId?.trim();

    final namePart = (cleanedName != null && cleanedName.isNotEmpty)
        ? cleanedName
        : 'Student';
    final uniPart =
        (cleanedUniversityId != null && cleanedUniversityId.isNotEmpty)
        ? cleanedUniversityId
        : 'unknown';

    return '$namePart - $uniPart';
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
