import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static const String _androidEmulatorBaseUrl = 'http://10.0.2.2:3001/api';
  static const String _desktopBaseUrl = 'http://localhost:3001/api';

  static String get baseUrl {
    final configured = _readConfiguredBaseUrl();
    if (_isCustomNetworkAddress(configured)) {
      return configured;
    }

    if (_isAndroid()) {
      return _androidEmulatorBaseUrl;
    }

    if (_isDesktop()) {
      return _desktopBaseUrl;
    }

    if (configured.isNotEmpty) {
      return configured;
    }

    return _desktopBaseUrl;
  }

  static String _readConfiguredBaseUrl() {
    try {
      return (dotenv.env['API_BASE_URL'] ?? '').trim();
    } catch (_) {
      return '';
    }
  }

  static bool _isCustomNetworkAddress(String value) {
    if (value.isEmpty) {
      return false;
    }

    return !(value.contains('localhost') || value.contains('127.0.0.1'));
  }

  static bool _isAndroid() {
    if (kIsWeb) {
      return false;
    }

    return defaultTargetPlatform == TargetPlatform.android;
  }

  static bool _isDesktop() {
    if (kIsWeb) {
      return false;
    }

    return defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS;
  }
}
