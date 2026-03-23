import 'package:flutter/material.dart';
import 'package:mobile_flutter/app/router.dart';
import 'package:mobile_flutter/core/storage/local_storage.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
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
  late final Future<Widget> _startScreenFuture;

  @override
  void initState() {
    super.initState();
    _startScreenFuture = getStartScreen();
  }

  Future<Widget> getStartScreen() async {
    final token = await _localStorage.getToken();
    if (token != null && token.isNotEmpty) {
      return const HomeScreen();
    }

    return const LoginScreen();
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
              body: LoadingIndicator(message: 'Loading app...'),
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
