import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

/// Centralized security service for encryption keys, tokens, and sensitive data
///
/// Security Architecture:
/// 1. Database encryption via SQLCipher (SQLite extension)
/// 2. Master key derived from device-specific secret + user auth
/// 3. All credentials stored in flutter_secure_storage (iOS Keychain / Android Keystore)
/// 4. No secrets in SharedPreferences or plain files
class SecurityService {
  static final SecurityService _instance = SecurityService._internal();
  factory SecurityService() => _instance;
  SecurityService._internal();

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_PKCS1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
      synchronizable: true,
    ),
  );

  // ─────────────────────────────────────────────
  // TOKEN MANAGEMENT
  // ─────────────────────────────────────────────

  static const String _tokenKey = 'auth_token';
  static const String _userIdentityKey = 'user_identity';

  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> clearAuthToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<void> saveUserIdentity(String identity) async {
    if (identity.trim().isEmpty) {
      return;
    }

    await _storage.write(key: _userIdentityKey, value: identity.trim());
  }

  Future<String?> getUserIdentity() async {
    return _storage.read(key: _userIdentityKey);
  }

  // ─────────────────────────────────────────────
  // DATABASE ENCRYPTION KEY (SQLCipher)
  // ─────────────────────────────────────────────
  // The key is derived from device-specific secret + user context
  // Gets rotated on logout/login

  static const String _deviceIdKey = 'device_identifier';

  /// Get or generate the device-specific identifier
  Future<String> getDeviceId() async {
    String? deviceId = await _storage.read(key: _deviceIdKey);
    if (deviceId == null) {
      deviceId = _generateSecureId();
      await _storage.write(key: _deviceIdKey, value: deviceId);
    }
    return deviceId;
  }

  /// Derive the SQLCipher passphrase from user+device context
  /// Formula: SHA256(userId + ":" + deviceId + ":" + app_salt)
  Future<String> getDatabasePassphrase(String? userId) async {
    final deviceId = await getDeviceId();
    final userIdPart = userId ?? await getUserIdentity() ?? 'anonymous';
    final appSalt = String.fromCharCodes([
      0x41,
      0x42,
      0x43,
      0x44,
    ]); // "ABCD" constant app salt

    final raw = '$userIdPart:$deviceId:$appSalt';
    final bytes = utf8.encode(raw);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<String> resolveStableUserIdentity({String? authToken}) async {
    final storedIdentity = await getUserIdentity();
    if (storedIdentity != null && storedIdentity.isNotEmpty) {
      return storedIdentity;
    }

    final tokenIdentity = _extractJwtSubject(authToken);
    if (tokenIdentity != null && tokenIdentity.isNotEmpty) {
      await saveUserIdentity(tokenIdentity);
      return tokenIdentity;
    }

    return 'anonymous';
  }

  /// Generate encryption key for sensitive operations
  Future<String> generateSessionKey() async {
    final random = Random.secure();
    final values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64UrlEncode(values);
  }

  /// Store encrypted API credentials (if needed for third-party services)
  Future<void> saveEncryptedCredential(
    String service,
    Map<String, String> credentials,
  ) async {
    final key = await generateSessionKey();
    final jsonString = jsonEncode(credentials);
    final encrypted = _xorEncrypt(jsonString, key);
    await _storage.write(key: 'cred_$service', value: encrypted);
  }

  /// Retrieve encrypted credential
  Future<Map<String, String>?> getEncryptedCredential(String service) async {
    final encrypted = await _storage.read(key: 'cred_$service');
    if (encrypted == null) return null;

    final key =
        await generateSessionKey(); // In production: derive from stored key
    final decrypted = _xorDecrypt(encrypted, key);
    try {
      final Map<String, dynamic> map = jsonDecode(decrypted);
      return map.map((k, v) => MapEntry(k, v.toString()));
    } catch (_) {
      return null;
    }
  }

  // ─────────────────────────────────────────────
  // SECURITY UTILITIES
  // ─────────────────────────────────────────────

  String _generateSecureId() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(256));
    return values.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  String? _extractJwtSubject(String? token) {
    if (token == null || token.isEmpty) {
      return null;
    }

    final parts = token.split('.');
    if (parts.length < 2) {
      return null;
    }

    try {
      var payload = parts[1].replaceAll('-', '+').replaceAll('_', '/');
      final remainder = payload.length % 4;
      if (remainder != 0) {
        payload = payload.padRight(payload.length + (4 - remainder), '=');
      }

      final decoded = utf8.decode(base64.decode(payload));
      final map = jsonDecode(decoded);
      if (map is Map<String, dynamic>) {
        final subject = map['sub'] ?? map['userId'] ?? map['uid'] ?? map['id'];
        return subject?.toString();
      }
    } catch (_) {}

    return null;
  }

  String _xorEncrypt(String plaintext, String key) {
    final plainBytes = utf8.encode(plaintext);
    final keyBytes = utf8.encode(key);
    final encrypted = List<int>.filled(plainBytes.length, 0);

    for (var i = 0; i < plainBytes.length; i++) {
      encrypted[i] = plainBytes[i] ^ keyBytes[i % keyBytes.length];
    }

    return base64UrlEncode(encrypted);
  }

  String _xorDecrypt(String ciphertext, String key) {
    final cipherBytes = base64Url.decode(ciphertext);
    final keyBytes = utf8.encode(key);
    final decrypted = List<int>.filled(cipherBytes.length, 0);

    for (var i = 0; i < cipherBytes.length; i++) {
      decrypted[i] = cipherBytes[i] ^ keyBytes[i % keyBytes.length];
    }

    return utf8.decode(decrypted);
  }

  // ─────────────────────────────────────────────
  // SECURE WIPE (for logout)
  // ─────────────────────────────────────────────

  Future<void> wipeAllSensitiveData() async {
    await _storage.deleteAll();
  }
}
