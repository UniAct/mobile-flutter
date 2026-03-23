import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_flutter/core/config/app_config.dart';
import 'package:mobile_flutter/core/storage/local_storage.dart';

class ApiClient {
  ApiClient({LocalStorage? localStorage})
    : _localStorage = localStorage ?? LocalStorage();

  final LocalStorage _localStorage;

  Future<dynamic> get(
    String path, {
    bool requiresAuth = true,
    Map<String, String>? headers,
  }) async {
    final requestHeaders = await _buildHeaders(
      requiresAuth: requiresAuth,
      extraHeaders: headers,
    );

    final response = await http.get(_buildUri(path), headers: requestHeaders);
    return _handleResponse(response);
  }

  Future<dynamic> post(
    String path, {
    bool requiresAuth = true,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final requestHeaders = await _buildHeaders(
      requiresAuth: requiresAuth,
      extraHeaders: headers,
    );

    final response = await http.post(
      _buildUri(path),
      headers: requestHeaders,
      body: body == null ? null : jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Uri _buildUri(String path) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('${AppConfig.baseUrl}$normalizedPath');
  }

  Future<Map<String, String>> _buildHeaders({
    required bool requiresAuth,
    Map<String, String>? extraHeaders,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      if (extraHeaders != null) ...extraHeaders,
    };

    if (!requiresAuth) {
      return headers;
    }

    final token = await _localStorage.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Unauthorized: missing token');
    }

    headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  dynamic _handleResponse(http.Response response) {
    dynamic payload;
    if (response.body.isNotEmpty) {
      payload = jsonDecode(response.body);
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return payload;
    }

    final serverMessage = payload is Map<String, dynamic>
        ? payload['message'] ?? payload['error']
        : null;
    final message =
        serverMessage?.toString() ?? 'Request failed (${response.statusCode})';

    throw Exception(message);
  }
}
