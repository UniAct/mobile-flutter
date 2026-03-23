import 'package:mobile_flutter/core/api/api_client.dart';
import 'package:mobile_flutter/features/auth/university_model.dart';

class UniversityService {
  UniversityService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<List<UniversityModel>> getUniversities() async {
    dynamic response;

    try {
      response = await _apiClient.get(
        '/public/university/list',
        requiresAuth: false,
      );
    } catch (_) {
      response = await _apiClient.get('/university/list', requiresAuth: false);
    }

    final list = _extractList(response);
    return list
        .map(UniversityModel.fromDynamic)
        .where((u) => u.name.isNotEmpty)
        .toList();
  }

  List<dynamic> _extractList(dynamic response) {
    if (response is List<dynamic>) {
      return response;
    }

    if (response is Map<String, dynamic>) {
      final data = response['data'];
      if (data is List<dynamic>) {
        return data;
      }
    }

    throw Exception('Invalid university list response');
  }
}
