import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_flutter/core/security/security_service.dart';

class LocalStorage {
  static const String _tokenKey = 'token';
  static const String _universityKey = 'university_name';
  static const String _dashboardCacheKey = 'dashboard_cache_json';
  static const String _dashboardCacheTimestampKey = 'dashboard_cache_ts';
  static const String _timetableCacheKey = 'timetable_cache_json';
  static const String _timetableCacheTimestampKey = 'timetable_cache_ts';
  static const String _transcriptCacheKey = 'transcript_cache_json';
  static const String _transcriptCacheTimestampKey = 'transcript_cache_ts';
  static const String _learningGroupsCachePrefix = 'learning_groups_cache_';

  final SecurityService _securityService = SecurityService();

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<void> saveToken(String token) async {
    await _securityService.saveAuthToken(token);
    final prefs = await _prefs;
    await prefs.remove(_tokenKey);
  }

  Future<String?> getToken() async {
    try {
      final secureToken = await _securityService.getAuthToken();
      if (secureToken != null && secureToken.isNotEmpty) {
        return secureToken;
      }

      final prefs = await _prefs;
      final legacyToken = prefs.getString(_tokenKey);
      if (legacyToken != null && legacyToken.isNotEmpty) {
        await _securityService.saveAuthToken(legacyToken);
        await prefs.remove(_tokenKey);
      }
      return legacyToken;
    } catch (_) {
      return null;
    }
  }

  Future<void> clearToken() async {
    await _securityService.clearAuthToken();
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

  Future<void> saveTimetableCache(String jsonString) async {
    final prefs = await _prefs;
    await prefs.setString(_timetableCacheKey, jsonString);
    await prefs.setInt(
      _timetableCacheTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<String?> getTimetableCache() async {
    try {
      final prefs = await _prefs;
      return prefs.getString(_timetableCacheKey);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveTranscriptCache(String jsonString) async {
    final prefs = await _prefs;
    await prefs.setString(_transcriptCacheKey, jsonString);
    await prefs.setInt(
      _transcriptCacheTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<String?> getTranscriptCache() async {
    try {
      final prefs = await _prefs;
      return prefs.getString(_transcriptCacheKey);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveLearningGroupsCache(String key, String jsonString) async {
    final prefs = await _prefs;
    await prefs.setString('$_learningGroupsCachePrefix$key', jsonString);
  }

  Future<String?> getLearningGroupsCache(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getString('$_learningGroupsCachePrefix$key');
    } catch (_) {
      return null;
    }
  }
}
