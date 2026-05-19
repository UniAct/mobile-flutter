import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/storage/local_storage.dart';
import 'package:mobile_flutter/features/auth/login_screen.dart';
import 'package:mobile_flutter/features/home/home_screen.dart';
import 'package:mobile_flutter/features/splash/splash_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String splashRoute = '/splash';
  static bool isOnLoginRoute = false;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    late final Widget page;

    switch (settings.name) {
      case splashRoute:
        page = SplashScreen(onComplete: _resolveStartScreen);
        break;
      case homeRoute:
        page = const HomeScreen();
        break;
      case loginRoute:
      default:
        page = const LoginScreen();
        break;
    }

    return PageRouteBuilder<void>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fade = CurvedAnimation(parent: animation, curve: Curves.easeOut);
        final slide =
            Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

        return FadeTransition(
          opacity: fade,
          child: SlideTransition(position: slide, child: child),
        );
      },
    );
  }

  static Future<Widget> _resolveStartScreen() async {
    final token = await LocalStorage().getToken();
    if (token != null && token.isNotEmpty) {
      return const HomeScreen();
    }
    return const LoginScreen();
  }
}
