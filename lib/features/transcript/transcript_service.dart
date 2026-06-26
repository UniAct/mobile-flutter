import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile_flutter/core/api/api_client.dart';
import 'package:mobile_flutter/core/storage/local_storage.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';
import 'package:mobile_flutter/features/transcript/transcript_models.dart';

class TranscriptService {
  TranscriptService({ApiClient? apiClient, LocalStorage? localStorage})
    : _apiClient = apiClient ?? ApiClient(),
      _localStorage = localStorage ?? LocalStorage();

  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  Future<TranscriptData> getTranscript() async {
    try {
      final response = await _apiClient.get('/transcripts/me');
      final data = _extractData(response);
      return _cacheAndReturn(data);
    } on AppException catch (e) {
      if (_isRouteNotFound(e)) {
        try {
          final userId = await _currentUserId();
          if (userId != null) {
            final response = await _apiClient.get(
              '/transcripts/students/$userId',
            );
            final data = _extractData(response);
            return _cacheAndReturn(data);
          }
        } catch (fallbackError) {
          debugPrint('[TranscriptService] Fallback failed: $fallbackError');
        }
      }

      if (e.isNetworkError) {
        final cached = await getCachedTranscript();
        if (cached != null) {
          return cached;
        }

        throw AppException(
          'You are offline and no cached transcript is available yet.',
          isNetworkError: true,
        );
      }
      rethrow;
    } catch (_) {
      final cached = await getCachedTranscript();
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  Future<TranscriptData> _cacheAndReturn(Map<String, dynamic> data) async {
    final transcript = TranscriptData.fromJson(data);

    try {
      await _localStorage.saveTranscriptCache(jsonEncode(data));
    } catch (e) {
      debugPrint('[TranscriptService] Cache write failed (non-fatal): $e');
    }

    return transcript;
  }

  Future<int?> _currentUserId() async {
    final token = await _localStorage.getToken();
    if (token == null || token.isEmpty) {
      return null;
    }

    final parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }

    final normalized = base64Url.normalize(parts[1]);
    final payload = utf8.decode(base64Url.decode(normalized));
    final decoded = jsonDecode(payload);
    if (decoded is! Map<String, dynamic>) {
      return null;
    }

    final rawId = decoded['id'];
    if (rawId is int && rawId > 0) {
      return rawId;
    }

    final parsed = int.tryParse(rawId?.toString() ?? '');
    return parsed != null && parsed > 0 ? parsed : null;
  }

  bool _isRouteNotFound(AppException exception) {
    final message = exception.message.toLowerCase();
    return exception.statusCode == 404 &&
        message.contains('route') &&
        message.contains('not found');
  }

  Future<TranscriptData?> getCachedTranscript() async {
    try {
      final jsonString = await _localStorage.getTranscriptCache();
      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }

      final decoded = jsonDecode(jsonString);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }

      return TranscriptData.fromJson(decoded);
    } catch (e) {
      debugPrint('[TranscriptService] Cache read failed: $e');
      return null;
    }
  }

  Map<String, dynamic> _extractData(dynamic response) {
    if (response is Map<String, dynamic>) {
      final data = response['data'];
      if (data is Map<String, dynamic>) {
        return data;
      }
      return response;
    }

    return <String, dynamic>{};
  }
}
