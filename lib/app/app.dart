import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_flutter/app/router.dart';
import 'package:mobile_flutter/core/storage/local_storage.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
import 'package:mobile_flutter/core/utils/connection_monitor.dart';
import 'package:mobile_flutter/features/auth/login_screen.dart';
import 'package:mobile_flutter/features/home/home_screen.dart';
import 'package:mobile_flutter/features/splash/splash_screen.dart';

class UniActApp extends StatefulWidget {
  const UniActApp({super.key});

  @override
  State<UniActApp> createState() => _UniActAppState();
}

class _UniActAppState extends State<UniActApp> {
  final LocalStorage _localStorage = LocalStorage();
  final ConnectionMonitor _connectionMonitor = ConnectionMonitor();

  StreamSubscription<bool>? _connectionSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _connectionSubscription = _connectionMonitor.onStatusChanged.listen((
        isConnected,
      ) {
        if (!isConnected || !mounted) {
          return;
        }

        // Connection restored - update state silently, do NOT show toast during startup
        debugPrint('[UniActApp] Connection restored - online');
      });
      _connectionMonitor.start();
    });
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    _connectionMonitor.dispose();
    super.dispose();
  }

  Future<Widget> getStartScreen() async {
    try {
      final token = await _localStorage.getToken();
      if (token != null && token.isNotEmpty) {
        return const HomeScreen();
      }
    } catch (e) {
      debugPrint('[UniActApp] Error checking token: $e');
    }
    return const LoginScreen();
  }

  Future<Widget> _getStartScreen() async {
    try {
      return await getStartScreen();
    } catch (e) {
      debugPrint('[UniActApp] Error getting start screen: $e');
      return const LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniAct',
      debugShowCheckedModeBanner: false,
      navigatorKey: AppRouter.navigatorKey,
      theme: AppTheme.light(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: SplashScreen(onComplete: _getStartScreen),
    );
  }
}
