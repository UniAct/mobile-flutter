import 'dart:async';

import 'package:flutter/material.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
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
    if (_isSyncing || !_attendanceDependencies.isReady) {
      return;
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        surfaceTintColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _selectedIndex == 0 ? 'Dashboard' : 'Attendance',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (user != null)
              Text(
                user.primaryRole,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
          ],
        ),
        centerTitle: false,
        bottom: !_isOnline
            ? PreferredSize(
                preferredSize: const Size.fromHeight(36),
                child: Container(
                  width: double.infinity,
                  color: Colors.orange.shade700,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.cloud_off_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Offline mode - data may be outdated',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
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
                    color: Colors.orange.shade700,
                    borderRadius: BorderRadius.circular(16),
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
          Tooltip(
            message: 'Refresh data',
            child: IconButton(
              onPressed: _loadHome,
              icon: const Icon(Icons.refresh_rounded),
              color: Colors.white,
            ),
          ),
          Tooltip(
            message: 'Menu',
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu_rounded),
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(user),
      body: _buildBody(user, dashboard),
      floatingActionButton: _pendingOfflineActions > 0
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

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 260),
      child: _selectedIndex == 0
          ? DashboardScreen(
              key: const ValueKey('dashboard'),
              user: user,
              dashboard: dashboard,
              onRefresh: _loadHome,
              onOpenAttendance: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            )
          : AttendanceScreen(
              key: const ValueKey('attendance'),
              user: user!,
              dashboard: dashboard!,
              dependencies: _attendanceDependencies,
            ),
    );
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
                  colors: [Color(0xFF1D4ED8), Color(0xFF2563EB)],
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
