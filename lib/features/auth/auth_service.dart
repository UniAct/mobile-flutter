import 'package:mobile_flutter/core/api/api_client.dart';
import 'package:mobile_flutter/core/storage/local_storage.dart';

class AuthService {
  AuthService({ApiClient? apiClient, LocalStorage? localStorage})
    : _localStorage = localStorage ?? LocalStorage(),
      _apiClient = apiClient ?? ApiClient(localStorage: localStorage);

  final LocalStorage _localStorage;
  final ApiClient _apiClient;

  Future<void> login({
    required String universityName,
    required String email,
    required String password,
    String? universityLogoUrl,
  }) async {
    if (universityName.isEmpty) {
      throw Exception('No university selected');
    }

    final response = await _apiClient.post(
      '/user/login',
      requiresAuth: false,
      headers: {'university-name': universityName},
      body: {'email': email, 'password': password},
    );

    final token = _extractToken(response);
    if (token == null || token.isEmpty) {
      throw Exception('Login succeeded but token is missing in response');
    }

    await _localStorage.saveToken(token);
    await _localStorage.saveUniversityName(universityName);
    await _refreshUniversityLogo(fallbackLogoUrl: universityLogoUrl);
  }

  Future<void> _refreshUniversityLogo({String? fallbackLogoUrl}) async {
    try {
      final response = await _apiClient.get('/university/settings');
      final data = response is Map<String, dynamic>
          ? response['data'] ?? response
          : null;
      final logoUrl = data is Map<String, dynamic>
          ? data['logo_url'] ?? data['logoUrl']
          : null;

      await _localStorage.saveUniversityLogoUrl(
        logoUrl?.toString() ?? fallbackLogoUrl,
      );
    } catch (_) {
      await _localStorage.saveUniversityLogoUrl(fallbackLogoUrl);
    }
  }

  Future<void> logout() async {
    await _localStorage.clearToken();
    await _localStorage.clearUniversityName();
  }

  String? _extractToken(dynamic response) {
    if (response is Map<String, dynamic>) {
      if (response['token'] != null) {
        return response['token'].toString();
      }

      final data = response['data'];
      if (data is Map<String, dynamic> && data['token'] != null) {
        return data['token'].toString();
      }
    }

    return null;
  }
}
