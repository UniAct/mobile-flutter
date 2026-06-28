import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile_flutter/core/api/api_client.dart';
import 'package:mobile_flutter/core/storage/local_storage.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';
import 'package:mobile_flutter/features/home/dashboard_models.dart';

class DashboardService {
  DashboardService({ApiClient? apiClient, LocalStorage? localStorage})
    : _apiClient = apiClient ?? ApiClient(),
      _localStorage = localStorage ?? LocalStorage();

  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  Future<DashboardData> getDashboard() async {
    try {
      final response = await _apiClient.get('/attendance/mobile/dashboard');
      final data = _extractData(response);
      final dashboard = DashboardData.fromJson(data);
      await _refreshUniversityLogo();

      try {
        await _localStorage.saveDashboardCache(jsonEncode(data));
      } catch (e) {
        debugPrint('[DashboardService] Cache write failed (non-fatal): $e');
      }

      return dashboard;
    } on AppException catch (e) {
      if (e.isNetworkError) {
        final cached = await getCachedDashboard();
        if (cached != null) {
          return cached;
        }

        throw AppException(
          'You are offline and no cached dashboard is available. Please connect to the internet at least once.',
          isNetworkError: true,
        );
      }
      rethrow;
    } catch (_) {
      final cached = await getCachedDashboard();
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  Future<DashboardData?> getCachedDashboard() async {
    try {
      final jsonString = await _localStorage.getDashboardCache();
      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }

      final decoded = jsonDecode(jsonString);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }

      return DashboardData.fromJson(decoded);
    } catch (e) {
      debugPrint('[DashboardService] Cache read failed: $e');
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

  Future<void> _refreshUniversityLogo() async {
    try {
      final response = await _apiClient.get('/university/settings');
      final data = response is Map<String, dynamic>
          ? response['data'] ?? response
          : null;
      final logoUrl = data is Map<String, dynamic>
          ? data['logo_url'] ?? data['logoUrl']
          : null;

      await _localStorage.saveUniversityLogoUrl(logoUrl?.toString());
    } catch (e) {
      debugPrint('[DashboardService] Logo refresh failed (non-fatal): $e');
    }
  }
}
