import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_flutter/app/router.dart';
import 'package:mobile_flutter/features/attendance/attendance_dependencies.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';
import 'package:mobile_flutter/core/utils/helpers.dart';
import 'package:mobile_flutter/core/widgets/app_button.dart';
import 'package:mobile_flutter/features/attendance/attendance_screen.dart';
import 'package:mobile_flutter/features/auth/auth_service.dart';
import 'package:mobile_flutter/features/auth/user_model.dart';
import 'package:mobile_flutter/features/home/dashboard_models.dart';
import 'package:mobile_flutter/features/home/dashboard_screen.dart';
import 'package:mobile_flutter/features/home/dashboard_service.dart';
import 'package:mobile_flutter/features/home/user_service.dart';
import 'package:mobile_flutter/features/timetable/timetable_screen.dart';
import 'package:mobile_flutter/features/transcript/transcript_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();
  final DashboardService _dashboardService = DashboardService();
  final AttendanceDependencies _attendanceDependencies =
      AttendanceDependencies.instance;

  bool _isSyncing = false;
  String? _error;
  UserModel? _user;
  DashboardData? _dashboard;
  int _selectedIndex = 0;
  int _pendingOfflineActions = 0;
  bool _isOnline = true;
  StreamSubscription<int>? _pendingCountSubscription;
  StreamSubscription<bool>? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeAsync();
  }

  void _initializeAsync() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await _attendanceDependencies.initialize();
      } catch (e) {
        debugPrint('[HomeScreen] Init error: $e');
      }

      if (!mounted) {
        return;
      }

      if (_attendanceDependencies.isReady) {
        final isOnline = await _attendanceDependencies.connectivityRepository
            .isConnected();
        if (mounted) {
          setState(() => _isOnline = isOnline);
        }

        _pendingCountSubscription = _attendanceDependencies.syncRepository
            .watchPendingCount()
            .listen((count) {
              if (mounted) {
                setState(() => _pendingOfflineActions = count);
              }
            });

        _connectivitySubscription = _attendanceDependencies
            .connectivityRepository
            .onConnectivityChanged
            .listen((connected) {
              if (!mounted) {
                return;
              }

              setState(() => _isOnline = connected);
              if (connected) {
                unawaited(_loadHome());
                unawaited(_attendanceDependencies.syncEngine.syncNow());
              }
            });
      }

      await _loadHome();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _attendanceDependencies.isReady) {
      _attendanceDependencies.syncEngine.syncNow();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pendingCountSubscription?.cancel();
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadHome() async {
    setState(() {
      _error = null;
    });

    try {
      final userFuture = _userService.getCurrentUser();
      final dashboardFuture = _dashboardService.getDashboard();
      final queueCountFuture = _attendanceDependencies.pendingSyncCount();

      final results = await Future.wait<dynamic>([
        userFuture,
        dashboardFuture,
        queueCountFuture,
      ]);

      if (mounted) {
        setState(() {
          _user = results[0] as UserModel;
          _dashboard = results[1] as DashboardData;
          _pendingOfflineActions = results[2] as int;
          _error = null;
        });
      }
    } on AppException catch (e) {
      if (e.isNetworkError && (_user != null || _dashboard != null)) {
        return;
      }

      if (mounted) {
        setState(() {
          _error = e.message;
        });
        if (!e.isNetworkError) {
          AppHelpers.showError(context, e.message);
        }
      }
    } catch (e) {
      if (mounted) {
        final message = AppHelpers.userErrorMessage(e);
        setState(() {
          _error = message;
        });
        AppHelpers.showMessage(context, message);
      }
    }
  }

  Future<void> _syncOfflineQueue() async {
    if (_isSyncing) {
      return;
    }

    // Ensure dependencies are initialized before attempting sync.
    if (!_attendanceDependencies.isReady) {
      try {
        await _attendanceDependencies.initialize();
      } catch (e) {
        if (mounted) {
          AppHelpers.showError(context, AppHelpers.userErrorMessage(e));
        }
        return;
      }
      if (!mounted) {
        return;
      }
    }

    setState(() {
      _isSyncing = true;
    });

    try {
      await _attendanceDependencies.syncEngine.syncNow();
      final pending = await _attendanceDependencies.pendingSyncCount();

      if (!mounted) {
        return;
      }

      setState(() {
        _pendingOfflineActions = pending;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      AppHelpers.showError(context, AppHelpers.userErrorMessage(e));
    } finally {
      if (mounted) {
        setState(() {
          _isSyncing = false;
        });
      }
    }
  }

  Future<void> _logout() async {
    try {
      await _authService.logout();
      if (!mounted) {
        return;
      }

      Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
    } catch (e) {
      if (mounted) {
        AppHelpers.showMessage(context, AppHelpers.userErrorMessage(e));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _user;
    final dashboard = _dashboard;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 76,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        flexibleSpace: const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF115E59), Color(0xFF0F766E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leadingWidth: 68,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: AppSpacing.md),
          child: Center(
            child: Material(
              color: Colors.white24,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: IconButton(
                tooltip: 'Open menu',
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        titleSpacing: AppSpacing.sm,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _pageTitle(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            if (user != null)
              Text(
                !_isOnline ? 'Offline' : user.primaryRole,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: !_isOnline
                      ? const Color(0xFFFFEDD5)
                      : Colors.white.withValues(alpha: 0.86),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
          ],
        ),
        centerTitle: false,
        actions: [
          if (_pendingOfflineActions > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.24),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.cloud_off_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_pendingOfflineActions.toString()} unsynced',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      drawer: _buildDrawer(user),
      body: _buildBody(user, dashboard),
      floatingActionButton: _isOnline && _pendingOfflineActions > 0
          ? FloatingActionButton.extended(
              onPressed: _isSyncing ? null : _syncOfflineQueue,
              icon: _isSyncing
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.sync_rounded),
              label: Text(_isSyncing ? 'Syncing...' : 'Sync Unsynced Data'),
            )
          : null,
    );
  }

  Widget _buildBody(UserModel? user, DashboardData? dashboard) {
    if (_error != null && user == null && dashboard == null) {
      final errorText = _error ?? 'Unknown error';
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorText, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: _loadHome, child: const Text('Retry')),
          ],
        ),
      );
    }

    if (_selectedIndex == 1 && (user == null || dashboard == null)) {
      return const Center(child: CircularProgressIndicator());
    }

    final selectedIndex = _selectedIndex == 3 && !_isStudent(user, dashboard)
        ? 0
        : _selectedIndex;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 260),
      child: switch (selectedIndex) {
        1 => AttendanceScreen(
          key: const ValueKey('attendance'),
          user: user!,
          dashboard: dashboard!,
          dependencies: _attendanceDependencies,
        ),
        2 => const TimetableScreen(key: ValueKey('timetable')),
        3 => const TranscriptScreen(key: ValueKey('transcript')),
        _ => DashboardScreen(
          key: const ValueKey('dashboard'),
          user: user,
          dashboard: dashboard,
          onRefresh: _loadHome,
          onOpenAttendance: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
        ),
      },
    );
  }

  bool _isStudent(UserModel? user, DashboardData? dashboard) {
    if (dashboard?.isStudent == true) {
      return true;
    }

    return user?.roles.any((role) => role.toLowerCase() == 'student') ?? false;
  }

  String _pageTitle() {
    return switch (_selectedIndex) {
      1 => 'Attendance',
      2 => 'Timetable',
      3 => 'Transcript',
      _ => 'Dashboard',
    };
  }

  Widget _buildDrawer(UserModel? user) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(AppSpacing.md),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                gradient: const LinearGradient(
                  colors: [AppColors.primaryDark, AppColors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person_rounded, color: AppColors.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user?.name ?? 'UniAct User',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.primaryRole ?? '',
                    style: const TextStyle(color: Color(0xFFE0EAFF)),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.space_dashboard_rounded),
              title: const Text('Dashboard'),
              selected: _selectedIndex == 0,
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.fact_check_rounded),
              title: const Text('Attendance'),
              selected: _selectedIndex == 1,
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_view_week_rounded),
              title: const Text('Timetable'),
              selected: _selectedIndex == 2,
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            if (_isStudent(user, _dashboard))
              ListTile(
                leading: const Icon(Icons.history_edu_rounded),
                title: const Text('Transcript'),
                selected: _selectedIndex == 3,
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: AppButton(
                text: 'Logout',
                icon: Icons.logout_rounded,
                onPressed: _logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
