import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_flutter/app/router.dart';
import 'package:mobile_flutter/core/config/app_config.dart';
import 'package:mobile_flutter/core/storage/local_storage.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';

class ApiClient {
  ApiClient({LocalStorage? localStorage})
    : _localStorage = localStorage ?? LocalStorage();

  final LocalStorage _localStorage;
  bool _handlingSessionExpiry = false;

  Future<dynamic> get(
    String path, {
    bool requiresAuth = true,
    Map<String, String>? headers,
  }) async {
    final requestHeaders = await _buildHeaders(
      requiresAuth: requiresAuth,
      extraHeaders: headers,
    );

    try {
      final response = await http
          .get(_buildUri(path), headers: requestHeaders)
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw SocketException('Connection timeout'),
          );
      return _handleResponse(response);
    } on SocketException {
      throw AppException(
        'Backend is disconnected. Please make sure the server is running and reachable.',
        isNetworkError: true,
      );
    } on http.ClientException catch (e) {
      throw _mapClientException(e);
    }
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

    try {
      final response = await http
          .post(
            _buildUri(path),
            headers: requestHeaders,
            body: body == null ? null : jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw SocketException('Connection timeout'),
          );

      return _handleResponse(response);
    } on SocketException {
      throw AppException(
        'Backend is disconnected. Please make sure the server is running and reachable.',
        isNetworkError: true,
      );
    } on http.ClientException catch (e) {
      throw _mapClientException(e);
    }
  }

  Future<dynamic> patch(
    String path, {
    bool requiresAuth = true,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final requestHeaders = await _buildHeaders(
      requiresAuth: requiresAuth,
      extraHeaders: headers,
    );

    try {
      final response = await http
          .patch(
            _buildUri(path),
            headers: requestHeaders,
            body: body == null ? null : jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw SocketException('Connection timeout'),
          );

      return _handleResponse(response);
    } on SocketException {
      throw AppException(
        'Backend is disconnected. Please make sure the server is running and reachable.',
        isNetworkError: true,
      );
    } on http.ClientException catch (e) {
      throw _mapClientException(e);
    }
  }

  Future<dynamic> multipartPost(
    String path, {
    bool requiresAuth = true,
    Map<String, String>? headers,
    Map<String, String>? fields,
    List<http.MultipartFile>? files,
  }) async {
    final requestHeaders = await _buildHeaders(
      requiresAuth: requiresAuth,
      extraHeaders: headers,
      includeJsonContentType: false,
    );

    try {
      final request = http.MultipartRequest('POST', _buildUri(path))
        ..headers.addAll(requestHeaders)
        ..fields.addAll(fields ?? const <String, String>{});

      if (files != null) {
        request.files.addAll(files);
      }

      final streamed = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw SocketException('Connection timeout'),
      );
      final response = await http.Response.fromStream(streamed);
      return _handleResponse(response);
    } on SocketException {
      throw AppException(
        'Backend is disconnected. Please make sure the server is running and reachable.',
        isNetworkError: true,
      );
    } on http.ClientException catch (e) {
      throw _mapClientException(e);
    }
  }

  Future<dynamic> put(
    String path, {
    bool requiresAuth = true,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final requestHeaders = await _buildHeaders(
      requiresAuth: requiresAuth,
      extraHeaders: headers,
    );

    try {
      final response = await http
          .put(
            _buildUri(path),
            headers: requestHeaders,
            body: body == null ? null : jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw SocketException('Connection timeout'),
          );

      return _handleResponse(response);
    } on SocketException {
      throw AppException(
        'Backend is disconnected. Please make sure the server is running and reachable.',
        isNetworkError: true,
      );
    } on http.ClientException catch (e) {
      throw _mapClientException(e);
    }
  }

  Future<dynamic> delete(
    String path, {
    bool requiresAuth = true,
    Map<String, String>? headers,
  }) async {
    final requestHeaders = await _buildHeaders(
      requiresAuth: requiresAuth,
      extraHeaders: headers,
    );

    try {
      final response = await http
          .delete(_buildUri(path), headers: requestHeaders)
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw SocketException('Connection timeout'),
          );

      return _handleResponse(response);
    } on SocketException {
      throw AppException(
        'Backend is disconnected. Please make sure the server is running and reachable.',
        isNetworkError: true,
      );
    } on http.ClientException catch (e) {
      throw _mapClientException(e);
    }
  }

  Uri _buildUri(String path) {
    final base = AppConfig.baseUrl;
    if (base.isEmpty) {
      throw AppException(
        'API base URL is not configured. Check your .env file.',
        isNetworkError: true,
      );
    }

    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$base$normalizedPath');
  }

  Future<Map<String, String>> _buildHeaders({
    required bool requiresAuth,
    Map<String, String>? extraHeaders,
    bool includeJsonContentType = true,
  }) async {
    final headers = <String, String>{
      if (includeJsonContentType) 'Content-Type': 'application/json',
      if (extraHeaders != null) ...extraHeaders,
    };

    if (!requiresAuth) {
      return headers;
    }

    final token = await _localStorage.getToken();
    if (token == null || token.isEmpty) {
      throw AppException('Your session has expired. Please login again.');
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

    final message = _extractServerMessage(payload);
    if (response.statusCode == 401) {
      _expireSession();
      throw AppException(
        message ?? 'Session expired, please log in again.',
        statusCode: response.statusCode,
      );
    }

    if (response.statusCode == 403) {
      final lowerMessage = (message ?? '').toLowerCase();
      if (lowerMessage.contains('token expired') ||
          lowerMessage.contains('invalid token')) {
        _expireSession();
        throw AppException(
          lowerMessage.contains('expired')
              ? 'Session expired, please log in again.'
              : 'Your session is invalid. Please log in again.',
          statusCode: response.statusCode,
        );
      }

      throw AppException(
        message ?? 'You do not have permission to perform this action.',
        statusCode: response.statusCode,
      );
    }

    throw AppException(
      message ?? _defaultHttpMessage(response.statusCode),
      statusCode: response.statusCode,
    );
  }

  void _expireSession() {
    if (_handlingSessionExpiry) {
      return;
    }

    _handlingSessionExpiry = true;
    _localStorage.clearToken().whenComplete(() {
      final navigator = AppRouter.navigatorKey.currentState;
      if (navigator != null && !AppRouter.isOnLoginRoute) {
        navigator.pushNamedAndRemoveUntil(
          AppRouter.loginRoute,
          (route) => false,
        );
      }
      _handlingSessionExpiry = false;
    });
  }

  AppException _mapClientException(http.ClientException exception) {
    final lower = exception.message.toLowerCase();

    if (lower.contains('connection refused') ||
        lower.contains('actively refused') ||
        lower.contains('refused the network connection')) {
      return AppException(
        'Backend is disconnected. Please make sure the server is running and reachable.',
        isNetworkError: true,
      );
    }

    if (lower.contains('failed host lookup') ||
        lower.contains('network is unreachable')) {
      return AppException(
        'No internet connection. Please check your network and try again.',
        isNetworkError: true,
      );
    }

    return AppException(
      'Unable to reach the server right now. Please try again shortly.',
      isNetworkError: true,
    );
  }

  String? _extractServerMessage(dynamic payload) {
    if (payload is! Map<String, dynamic>) {
      return null;
    }

    // Handle structured validation responses from backend Zod validator
    // e.g. { status: 'fail', data: { body: { field: { _errors: [...] } } } }
    try {
      if (payload['status'] == 'fail' && payload['data'] != null) {
        return jsonEncode(payload['data']);
      }
    } catch (_) {}

    final direct = payload['message'] ?? payload['error'];
    if (direct != null && direct.toString().trim().isNotEmpty) {
      return direct.toString();
    }

    final data = payload['data'];
    if (data is Map<String, dynamic>) {
      final dataMessage = data['message'] ?? data['error'];
      if (dataMessage != null && dataMessage.toString().trim().isNotEmpty) {
        return dataMessage.toString();
      }
    }

    return null;
  }

  String _defaultHttpMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check your input and try again.';
      case 401:
        return 'Authentication failed. Please login again.';
      case 403:
        return 'You do not have permission to perform this action.';
      case 404:
        return 'Requested resource was not found.';
      case 409:
        return 'Request conflict detected. Please refresh and retry.';
      case 422:
        return 'Some fields are invalid. Please review your input.';
      case 500:
      case 502:
      case 503:
      case 504:
        return 'Backend is disconnected or unavailable at the moment. Please try again shortly.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
