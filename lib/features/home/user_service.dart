import 'dart:convert';

import 'package:mobile_flutter/core/storage/local_storage.dart';
import 'package:mobile_flutter/features/auth/user_model.dart';

class UserService {
  UserService({LocalStorage? localStorage})
    : _localStorage = localStorage ?? LocalStorage();

  final LocalStorage _localStorage;

  Future<UserModel> getCurrentUser() async {
    final token = await _localStorage.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Missing token. Please login again.');
    }

    final data = _decodeTokenPayload(token);
    return UserModel.fromJson(data);
  }

  Future<void> logout() {
    return _localStorage.clearToken();
  }

  Map<String, dynamic> _decodeTokenPayload(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token format');
    }

    final normalized = base64Url.normalize(parts[1]);
    final payload = utf8.decode(base64Url.decode(normalized));
    final decoded = jsonDecode(payload);

    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    throw Exception('Invalid token payload');
  }
}
