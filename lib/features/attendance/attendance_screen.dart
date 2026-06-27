import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
import 'package:mobile_flutter/core/utils/helpers.dart';
import 'package:mobile_flutter/core/widgets/app_button.dart';
import 'package:mobile_flutter/core/widgets/app_card.dart';
import 'package:mobile_flutter/core/widgets/attendance_skeleton_loader.dart';
import 'package:mobile_flutter/core/widgets/sync_status_widget.dart';
import 'package:mobile_flutter/features/attendance/attendance_dependencies.dart';
import 'package:mobile_flutter/features/attendance/attendance_models.dart';
import 'package:mobile_flutter/features/attendance/bloc/attendance_bloc.dart';
import 'package:mobile_flutter/features/attendance/services/scanner_service.dart';
import 'package:mobile_flutter/features/attendance/services/sync_engine.dart';
import 'package:mobile_flutter/features/auth/user_model.dart';
import 'package:mobile_flutter/features/home/dashboard_models.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({
    super.key,
    required this.user,
    required this.dashboard,
    required this.dependencies,
  });

  final UserModel user;
  final DashboardData dashboard;
  final AttendanceDependencies dependencies;

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with WidgetsBindingObserver {
  late final AttendanceBloc _bloc;
  ScannerService? _scannerService;
  bool _scanBusy = false;
  int _currentPage = 0;

  bool get _isQrSupported =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _bloc = AttendanceBloc(dependencies: widget.dependencies)
      ..add(AttendanceStarted(user: widget.user, dashboard: widget.dashboard));

    // Get singleton scanner service (shared across app)
    _scannerService = widget.dependencies.scannerService;

    if (_isQrSupported) {
      unawaited(_scannerService?.startScanning());
    }
  }

  @override
  void dispose() {
    // Stop scanning (but don't dispose singleton - other screens may use it)
    if (_isQrSupported) {
      unawaited(_scannerService?.stopScanning());
    }
    WidgetsBinding.instance.removeObserver(this);
    _bloc.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle: pause scanning when app backgrounded
    super.didChangeAppLifecycleState(state);
    if (_isQrSupported) {
      switch (state) {
        case AppLifecycleState.resumed:
          unawaited(_scannerService?.startScanning());
          break;
        case AppLifecycleState.paused:
          unawaited(_scannerService?.stopScanning());
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<AttendanceBloc, AttendanceState>(
        listenWhen: (previous, current) =>
            previous.toastSequence != current.toastSequence &&
            current.toastMessage != null,
        listener: (context, state) {
          final message = state.toastMessage;
          if (message == null || message.isEmpty) {
            return;
          }

          switch (state.toastType) {
            case AttendanceToastType.success:
              AppHelpers.showSuccess(context, message);
              break;
            case AttendanceToastType.warning:
              AppHelpers.showWarning(context, message);
              break;
            case AttendanceToastType.error:
              AppHelpers.showError(context, message);
              break;
          }
        },
        builder: (context, state) {
          if (!state.isInitialized) {
            return const AttendanceSkeletonLoader(isStaff: false);
          }

          if (widget.dashboard.isStudent) {
            return _buildStudentView(context, state);
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 420;
              return state.loadingCourses || state.loadingStudents
                  ? const AttendanceSkeletonLoader(isStaff: true)
                  : DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          _buildStatusBanner(context, state),
                          SyncStatusWidget(
                            status: state.syncState,
                            isOnline: state.isOnline,
                            onRetry: () => context.read<AttendanceBloc>().add(
                              const AttendanceSyncRequested(),
                            ),
                          ),
                          const TabBar(
                            tabs: [
                              Tab(text: 'Manual'),
                              Tab(text: 'QR-Code'),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                _buildStaffManualView(
                                  context,
                                  state,
                                  isCompact: isCompact,
                                ),
                                _buildStaffQrView(
                                  context,
                                  state,
                                  isCompact: isCompact,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatusBanner(BuildContext context, AttendanceState state) {
    final isClean =
        state.isOnline &&
        state.pendingSyncCount == 0 &&
        state.syncState != SyncState.syncing &&
        state.syncState != SyncState.failed;
    if (isClean) {
      return const SizedBox.shrink();
    }

    if (!state.isOnline) {
      return _buildPill(
        context,
        icon: Icons.cloud_off_rounded,
        label: state.pendingSyncCount > 0
            ? '${state.pendingSyncCount} record(s) saved locally - will sync when online'
            : 'Offline mode',
        color: const Color(0xFFB45309),
      );
    }

    if (state.syncState == SyncState.syncing) {
      return _buildPill(
        context,
        icon: Icons.sync_rounded,
        label: 'Syncing...',
        color: AppColors.primary,
        spinner: true,
      );
    }

    if (state.syncState == SyncState.failed) {
      return GestureDetector(
        onTap: () =>
            context.read<AttendanceBloc>().add(const AttendanceSyncRequested()),
        child: _buildPill(
          context,
          icon: Icons.error_outline_rounded,
          label: 'Sync failed - tap to retry',
          color: AppColors.error,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildPill(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    bool spinner = false,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.xs,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          spinner
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color,
                  ),
                )
              : Icon(icon, size: 16, color: color),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentView(BuildContext context, AttendanceState state) {
    final data = state.studentData;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<AttendanceBloc>().add(const AttendanceSyncRequested());
        await Future<void>.delayed(const Duration(milliseconds: 400));
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _buildStatusBanner(context, state),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Attendance',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 6),
                          Text('Semester #${state.semesterId}'),
                        ],
                      ),
                    ),
                    if (state.loadingStudentStatus)
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Builder(
                  builder: (context) {
                    final hasQr =
                        data?.qrPayload != null && data!.qrPayload.isNotEmpty;
                    final isLoading = state.loadingStudentStatus;
                    final qrPayload = data?.qrPayload ?? '';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppButton(
                          text: 'View My QR-Code',
                          icon: Icons.qr_code_2_rounded,
                          isLoading: isLoading,
                          onPressed: hasQr
                              ? () => _showMyQrCode(qrPayload)
                              : null,
                        ),
                        if (!isLoading && !hasQr) ...[
                          const SizedBox(height: 6),
                          Text(
                            state.isOnline
                                ? 'Loading your QR code...'
                                : 'QR code unavailable offline. Connect once to download it.',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (data == null && !state.loadingStudentStatus)
            AppCard(
              child: Text(
                state.isOnline
                    ? 'No cached attendance found yet. It will appear here after the first successful sync.'
                    : 'No cached attendance found yet. Connect once to download your attendance history.',
              ),
            )
          else if (data != null)
            ...data.timeline.map(_buildStudentAttendanceTile),
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 16),
        ],
      ),
    );
  }

  Widget _buildStudentAttendanceTile(StudentAttendanceItem item) {
    final date = DateFormat('EEE, MMM d').format(item.sessionDate.toLocal());
    final stacked = MediaQuery.sizeOf(context).width < 360;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: stacked
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: _statusColor(
                          item.status,
                        ).withValues(alpha: 0.15),
                        child: Icon(
                          Icons.fact_check_rounded,
                          color: _statusColor(item.status),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          '${item.courseCode} ${item.courseName}'.trim(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$date • ${item.mode}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.status,
                      style: TextStyle(
                        color: _statusColor(item.status),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  CircleAvatar(
                    backgroundColor: _statusColor(
                      item.status,
                    ).withValues(alpha: 0.15),
                    child: Icon(
                      Icons.fact_check_rounded,
                      color: _statusColor(item.status),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${item.courseCode} ${item.courseName}'.trim()),
                        const SizedBox(height: 2),
                        Text(
                          '$date • ${item.mode}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    item.status,
                    style: TextStyle(
                      color: _statusColor(item.status),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildStaffManualView(
    BuildContext context,
    AttendanceState state, {
    required bool isCompact,
  }) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<AttendanceBloc>().add(const AttendanceSyncRequested());
        await Future<void>.delayed(const Duration(milliseconds: 400));
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(isCompact ? AppSpacing.sm : AppSpacing.md),
        children: [
          _buildAttendanceDateCard(context, state, isCompact: isCompact),
          SizedBox(height: isCompact ? AppSpacing.sm : AppSpacing.md),
          _buildCourseSelectorCard(context, state),
          SizedBox(height: isCompact ? AppSpacing.sm : AppSpacing.md),
          if (state.courses.isEmpty)
            AppCard(
              child: Text(
                state.isOnline
                    ? 'No assigned classes found for this staff member.'
                    : 'No cached classes available yet. Connect once to download your assigned classes.',
              ),
            )
          else if (state.students.isEmpty)
            AppCard(
              child: Text(
                state.loadingStudents
                    ? 'Loading enrolled students...'
                    : state.selectedCourse == null
                    ? 'Choose a class to load the roster.'
                    : 'No enrolled students found for this class.',
              ),
            )
          else ...[
            _buildMarkAllButtonsCard(context, isCompact: isCompact),
            const SizedBox(height: AppSpacing.sm),
            _buildPaginatedStudentList(context, state),
            const SizedBox(height: AppSpacing.sm),
            _buildPaginationControls(context, state),
          ],
          SizedBox(height: isCompact ? AppSpacing.sm : AppSpacing.md),
          AppButton(
            text: 'Submit Manual Attendance',
            isLoading: state.isSaving,
            onPressed: state.students.isEmpty || state.selectedCourse == null
                ? null
                : () => context.read<AttendanceBloc>().add(
                    const AttendanceManualSubmitted(),
                  ),
          ),
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 16),
        ],
      ),
    );
  }

  Widget _buildStaffQrView(
    BuildContext context,
    AttendanceState state, {
    required bool isCompact,
  }) {
    final scannerHeight = isCompact ? 220.0 : 300.0;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<AttendanceBloc>().add(const AttendanceSyncRequested());
        await Future<void>.delayed(const Duration(milliseconds: 400));
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(isCompact ? AppSpacing.sm : AppSpacing.md),
        children: [
          _buildAttendanceDateCard(context, state, isCompact: isCompact),
          SizedBox(height: isCompact ? AppSpacing.sm : AppSpacing.md),
          _buildCourseSelectorCard(context, state),
          SizedBox(height: isCompact ? AppSpacing.sm : AppSpacing.md),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: const Icon(
                        Icons.qr_code_2_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Scan Student QR-Code',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (!_isQrSupported || _scannerService == null)
                  AppCard(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Text(
                      'QR scanning is available on Android and iOS devices only.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                else
                  SizedBox(
                    height: scannerHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      child: MobileScanner(
                        // Use singleton controller - prevents camera recreation
                        controller: _scannerService!.controller,
                        onDetect: (capture) {
                          if (_scanBusy) {
                            return;
                          }

                          final barcodes = capture.barcodes;
                          if (barcodes.isEmpty) {
                            return;
                          }

                          final raw = barcodes.first.rawValue;
                          if (raw == null || raw.isEmpty) {
                            return;
                          }

                          setState(() {
                            _scanBusy = true;
                          });
                          unawaited(_scannerService?.stopScanning());
                          context.read<AttendanceBloc>().add(
                            AttendanceQrSubmitted(raw),
                          );
                          Future<void>.delayed(
                            const Duration(milliseconds: 1400),
                            () {
                              if (mounted) {
                                setState(() {
                                  _scanBusy = false;
                                });
                                unawaited(_scannerService?.startScanning());
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 16),
        ],
      ),
    );
  }

  Widget _buildAttendanceDateCard(
    BuildContext context,
    AttendanceState state, {
    required bool isCompact,
  }) {
    final formattedDate = DateFormat(
      'EEE, MMM d, yyyy',
    ).format(state.selectedDate);

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attendance Date',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(formattedDate, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          SizedBox(
            width: isCompact ? double.infinity : null,
            child: OutlinedButton.icon(
              onPressed: () async {
                final bloc = context.read<AttendanceBloc>();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: state.selectedDate,
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );

                if (picked == null || !mounted) {
                  return;
                }

                bloc.add(AttendanceDateChanged(picked));
                setState(() {
                  _currentPage = 0;
                });
              },
              icon: const Icon(Icons.event_rounded),
              label: const Text('Change Date'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseSelectorCard(BuildContext context, AttendanceState state) {
    final selectedCourse = state.selectedCourse;

    return AppCard(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose Class',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (state.syncState == SyncState.syncing)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (state.courses.isEmpty)
            Text(
              state.isOnline
                  ? 'No assigned classes found for this staff member.'
                  : 'No cached classes available yet. Connect once to download your assigned classes.',
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<int>(
                  isExpanded: true,
                  initialValue: selectedCourse?.contextId,
                  selectedItemBuilder: (context) {
                    return state.courses
                        .map(
                          (course) => Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              course.label,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        )
                        .toList();
                  },
                  items: state.courses
                      .map(
                        (course) => DropdownMenuItem<int>(
                          value: course.contextId,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.label,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              if (course.description.isNotEmpty)
                                Text(
                                  course.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    context.read<AttendanceBloc>().add(
                      AttendanceCourseSelected(value),
                    );
                    setState(() {
                      _currentPage = 0;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Assigned class',
                    hintText: 'Select a class session',
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                  ),
                ),
                if (selectedCourse != null &&
                    selectedCourse.description.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    selectedCourse.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildMarkAllButtonsCard(
    BuildContext context, {
    required bool isCompact,
  }) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: isCompact
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppButton(
                  text: 'Mark All Present',
                  onPressed: () => context.read<AttendanceBloc>().add(
                    const AttendanceMarkAllRequested(true),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  text: 'Mark All Absent',
                  onPressed: () => context.read<AttendanceBloc>().add(
                    const AttendanceMarkAllRequested(false),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Mark All Present',
                    onPressed: () => context.read<AttendanceBloc>().add(
                      const AttendanceMarkAllRequested(true),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AppButton(
                    text: 'Mark All Absent',
                    onPressed: () => context.read<AttendanceBloc>().add(
                      const AttendanceMarkAllRequested(false),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPaginatedStudentList(
    BuildContext context,
    AttendanceState state,
  ) {
    final startIndex = _currentPage * _studentsPerPage;
    final endIndex = (_currentPage + 1) * _studentsPerPage;
    final paginatedStudents = state.students.sublist(
      startIndex,
      endIndex > state.students.length ? state.students.length : endIndex,
    );

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: paginatedStudents.asMap().entries.map((entry) {
          final index = entry.key;
          final student = entry.value;
          final isPresent = state.presentMap[student.studentId] ?? false;
          final alreadyMarked =
              state.alreadyMarkedMap[student.studentId] ?? false;
          final isLastItem = index == paginatedStudents.length - 1;

          return Column(
            children: [
              Container(
                color: alreadyMarked
                    ? Colors.green.withValues(alpha: 0.08)
                    : null,
                child: CheckboxListTile(
                  value: isPresent,
                  onChanged: (value) {
                    context.read<AttendanceBloc>().add(
                      AttendanceMarkToggled(
                        studentId: student.studentId,
                        isPresent: value ?? false,
                      ),
                    );
                  },
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          student.fullName,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (alreadyMarked)
                        const Padding(
                          padding: EdgeInsets.only(left: AppSpacing.sm),
                          child: Tooltip(
                            message: 'Existing record - changes will update it',
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 18,
                            ),
                          ),
                        ),
                    ],
                  ),
                  subtitle: Text(
                    student.email,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ),
              if (!isLastItem)
                const Divider(
                  height: 0,
                  indent: AppSpacing.md,
                  endIndent: AppSpacing.md,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPaginationControls(BuildContext context, AttendanceState state) {
    final totalPages = (state.students.length / _studentsPerPage).ceil();
    if (totalPages <= 1) {
      return const SizedBox.shrink();
    }

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 40,
            child: AppButton(
              text: 'Previous',
              onPressed: _currentPage > 0
                  ? () {
                      setState(() {
                        _currentPage -= 1;
                      });
                    }
                  : null,
            ),
          ),
          Text(
            'Page ${_currentPage + 1} of $totalPages',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 40,
            child: AppButton(
              text: 'Next',
              onPressed: _currentPage < totalPages - 1
                  ? () {
                      setState(() {
                        _currentPage += 1;
                      });
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  void _showMyQrCode(String qrPayload) {
    final blocState = _bloc.state;
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('My QR-Code'),
          content: SizedBox(
            width: 280,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.white,
                  child: QrImageView(
                    data: qrPayload,
                    size: 240,
                    backgroundColor: Colors.white,
                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Show this to your instructor to mark attendance.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  blocState.isOnline ? '● Online' : '● Offline – cached QR',
                  style: TextStyle(
                    fontSize: 12,
                    color: blocState.isOnline
                        ? const Color(0xFF15803D)
                        : const Color(0xFFB45309),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Color _statusColor(String status) {
    final normalized = status.toLowerCase();
    if (normalized.contains('present')) {
      return const Color(0xFF15803D);
    }

    if (normalized.contains('late')) {
      return const Color(0xFFB45309);
    }

    return const Color(0xFFB91C1C);
  }

  static const int _studentsPerPage = 10;
}
