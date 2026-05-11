import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _tokenKey = 'token';
  static const String _universityKey = 'university_name';
  static const String _dashboardCacheKey = 'dashboard_cache_json';
  static const String _dashboardCacheTimestampKey = 'dashboard_cache_ts';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<void> saveToken(String token) async {
    final prefs = await _prefs;
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    try {
      final prefs = await _prefs;
      return prefs.getString(_tokenKey);
    } catch (_) {
      return null;
    }
  }

  Future<void> clearToken() async {
    final prefs = await _prefs;
    await prefs.remove(_tokenKey);
  }

  Future<void> saveUniversityName(String universityName) async {
    final prefs = await _prefs;
    await prefs.setString(_universityKey, universityName);
  }

  Future<String?> getUniversityName() async {
    try {
      final prefs = await _prefs;
      return prefs.getString(_universityKey);
    } catch (_) {
      return null;
    }
  }

  Future<String?> getUniversity() {
    return getUniversityName();
  }

  Future<void> clearUniversityName() async {
    final prefs = await _prefs;
    await prefs.remove(_universityKey);
  }

  Future<void> saveDashboardCache(String jsonString) async {
    final prefs = await _prefs;
    await prefs.setString(_dashboardCacheKey, jsonString);
    await prefs.setInt(
      _dashboardCacheTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<String?> getDashboardCache() async {
    try {
      final prefs = await _prefs;
      return prefs.getString(_dashboardCacheKey);
    } catch (_) {
      return null;
    }
  }

  Future<String?> getFreshDashboardCache({int maxAgeHours = 72}) async {
    try {
      final prefs = await _prefs;
      final timestamp = prefs.getInt(_dashboardCacheTimestampKey);
      if (timestamp == null) {
        return null;
      }

      final age = DateTime.now().millisecondsSinceEpoch - timestamp;
      if (age > Duration(hours: maxAgeHours).inMilliseconds) {
        return null;
      }

      return prefs.getString(_dashboardCacheKey);
    } catch (_) {
      return null;
    }
  }
}
