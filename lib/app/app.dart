import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_flutter/app/router.dart';
import 'package:mobile_flutter/core/storage/local_storage.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
import 'package:mobile_flutter/core/utils/connection_monitor.dart';
import 'package:mobile_flutter/core/utils/helpers.dart';
import 'package:mobile_flutter/core/widgets/loading_indicator.dart';
import 'package:mobile_flutter/features/auth/login_screen.dart';
import 'package:mobile_flutter/features/home/home_screen.dart';

class UniActApp extends StatefulWidget {
  const UniActApp({super.key});

  @override
  State<UniActApp> createState() => _UniActAppState();
}

class _UniActAppState extends State<UniActApp> {
  final LocalStorage _localStorage = LocalStorage();
  final ConnectionMonitor _connectionMonitor = ConnectionMonitor();
  static const Duration _minimumBootstrapDuration = Duration(seconds: 4);

  late final Future<Widget> _startScreenFuture;
  StreamSubscription<bool>? _connectionSubscription;

  @override
  void initState() {
    super.initState();
    _startScreenFuture = _getStartScreenWithMinimumBootstrap();
    _connectionSubscription = _connectionMonitor.onStatusChanged.listen((
      isConnected,
    ) {
      if (!isConnected || !mounted) {
        return;
      }

      AppHelpers.showSuccess(
        context,
        'Connection restored. You are back online.',
      );
    });
    _connectionMonitor.start();
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    _connectionMonitor.dispose();
    super.dispose();
  }

  Future<Widget> getStartScreen() async {
    final token = await _localStorage.getToken();
    if (token != null && token.isNotEmpty) {
      return const HomeScreen();
    }

    return const LoginScreen();
  }

  Future<Widget> _getStartScreenWithMinimumBootstrap() async {
    final results = await Future.wait<dynamic>([
      getStartScreen(),
      Future<void>.delayed(_minimumBootstrapDuration),
    ]);

    return results.first as Widget;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniAct',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: FutureBuilder<Widget>(
        future: _startScreenFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: LoadingIndicator(
                message: 'Initializing tenant infrastructure...',
                variant: LoadingIndicatorVariant.bootstrap,
              ),
            );
          }

          if (snapshot.hasError) {
            return const LoginScreen();
          }

          return snapshot.data ?? const LoginScreen();
        },
      ),
    );
  }
}
