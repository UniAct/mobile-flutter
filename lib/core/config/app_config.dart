import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get baseUrl {
    final url = _readConfiguredBaseUrl();
    if (url.isEmpty && kDebugMode) {
      debugPrint('[AppConfig] WARNING: API_BASE_URL is not set in .env');
    }
    return url;
  }

  static bool get isConfigured {
    return _readConfiguredBaseUrl().isNotEmpty;
  }

  static String _readConfiguredBaseUrl() {
    try {
      return (dotenv.env['API_BASE_URL'] ?? '').trim();
    } catch (_) {
      return '';
    }
  }
}
