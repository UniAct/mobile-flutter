import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_flutter/core/api/api_client.dart';
import 'package:mobile_flutter/core/storage/local_storage.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';
import 'package:mobile_flutter/features/learning_groups/learning_group_models.dart';

class PickedLearningGroupFile {
  const PickedLearningGroupFile({required this.name, required this.path});

  final String name;
  final String path;
}

class LearningGroupService {
  LearningGroupService({ApiClient? apiClient, LocalStorage? localStorage})
    : _apiClient = apiClient ?? ApiClient(),
      _localStorage = localStorage ?? LocalStorage();

  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  Future<List<LearningGroupSummary>> getMyGroups() async {
    try {
      final response = await _apiClient.get('/learning-group');
      await _saveCache('groups', response);
      return _parseGroupList(_extractData(response));
    } on AppException catch (e) {
      if (e.isNetworkError) {
        final cached = await _readCache('groups');
        if (cached != null) return _parseGroupList(_extractData(cached));
      }
      rethrow;
    } catch (_) {
      final cached = await _readCache('groups');
      if (cached != null) return _parseGroupList(_extractData(cached));
      rethrow;
    }
  }

  Future<LearningGroupDetails> getDetails(int groupId) async {
    final cacheKey = 'details_$groupId';
    try {
      final response = await _apiClient.get('/learning-group/$groupId');
      await _saveCache(cacheKey, response);
      return _parseDetails(_extractData(response));
    } on AppException catch (e) {
      if (e.isNetworkError) {
        final cached = await _readCache(cacheKey);
        if (cached != null) return _parseDetails(_extractData(cached));
      }
      rethrow;
    } catch (_) {
      final cached = await _readCache(cacheKey);
      if (cached != null) return _parseDetails(_extractData(cached));
      rethrow;
    }
  }

  Future<List<LearningGroupPost>> getPosts(
    int groupId, {
    String? postType,
  }) async {
    final query = postType == null ? '' : '?postType=$postType';
    final cacheKey = 'posts_${groupId}_${postType ?? 'ALL'}';
    try {
      final response = await _apiClient.get('/learning-group/$groupId/posts$query');
      await _saveCache(cacheKey, response);
      return _parsePosts(_extractData(response));
    } on AppException catch (e) {
      if (e.isNetworkError) {
        final cached = await _readCache(cacheKey);
        if (cached != null) return _parsePosts(_extractData(cached));
      }
      rethrow;
    } catch (_) {
      final cached = await _readCache(cacheKey);
      if (cached != null) return _parsePosts(_extractData(cached));
      rethrow;
    }
  }

  Future<LearningGroupPost> createPost({
    required int groupId,
    required String postType,
    required String? content,
    required DateTime? dueDate,
    required List<PickedLearningGroupFile> files,
  }) async {
    final fields = <String, String>{'postType': postType};
    final trimmed = content?.trim() ?? '';
    if (trimmed.isNotEmpty) {
      fields['content'] = trimmed;
    }
    if (postType == 'ASSIGNMENT' && dueDate != null) {
      fields['dueDate'] = dueDate.toUtc().toIso8601String();
    }

    final uploadFiles = <http.MultipartFile>[];
    for (final file in files) {
      uploadFiles.add(await http.MultipartFile.fromPath('files', file.path));
    }

    final response = await _apiClient.multipartPost(
      '/learning-group/$groupId/posts',
      fields: fields,
      files: uploadFiles,
    );
    final data = _extractData(response);
    return LearningGroupPost.fromJson(
      data is Map<String, dynamic> ? data : const {},
    );
  }

  Future<void> togglePin(int groupId, int postId) async {
    await _apiClient.patch('/learning-group/$groupId/posts/$postId/pin');
  }

  Future<void> deletePost(int groupId, int postId) async {
    await _apiClient.delete('/learning-group/$groupId/posts/$postId');
  }

  Future<List<LearningGroupComment>> getComments(int groupId, int postId) async {
    final response = await _apiClient.get(
      '/learning-group/$groupId/posts/$postId/comments',
    );
    final data = _extractData(response);
    return _parseComments(data);
  }

  Future<LearningGroupComment> createComment(
    int groupId,
    int postId,
    String content,
  ) async {
    final response = await _apiClient.post(
      '/learning-group/$groupId/posts/$postId/comments',
      body: {'content': content},
    );
    final data = _extractData(response);
    return LearningGroupComment.fromJson(
      data is Map<String, dynamic> ? data : const {},
    );
  }

  Future<LearningGroupSummary> join(String accessCode) async {
    final response = await _apiClient.post(
      '/learning-group/join',
      body: {'accessCode': accessCode},
    );
    final data = _extractData(response);
    final groupId = _toInt((data as Map<String, dynamic>?)?['groupId']);
    return LearningGroupSummary(
      groupId: groupId,
      groupName: (data?['groupName'] ?? '').toString(),
      accessCode: accessCode,
      allowStudentPosts: false,
      course: const LearningGroupCourse(id: 0, code: '', name: '', credits: 0),
      myRole: 'Member',
    );
  }

  Future<Map<String, dynamic>> syncMaterials(int groupId) async {
    final response = await _apiClient.post('/ai/groups/$groupId/sync');
    final data = _extractData(response);
    return data is Map<String, dynamic> ? data : const {};
  }

  dynamic _extractData(dynamic response) {
    if (response is Map<String, dynamic> && response.containsKey('data')) {
      return response['data'];
    }
    return response;
  }

  List<LearningGroupSummary> _parseGroupList(dynamic data) {
    final items = data is List<dynamic> ? data : const <dynamic>[];
    return _dedupeBy<int, LearningGroupSummary>(
      items
        .whereType<Map<String, dynamic>>()
        .map(LearningGroupSummary.fromJson)
        .where((group) => group.groupId > 0),
      (group) => group.groupId,
    );
  }

  LearningGroupDetails _parseDetails(dynamic data) {
    return LearningGroupDetails.fromJson(
      data is Map<String, dynamic> ? data : const {},
    );
  }

  List<LearningGroupPost> _parsePosts(dynamic data) {
    final page = data is Map<String, dynamic> ? data : const {};
    final items = page['items'] as List<dynamic>? ?? const [];
    return _dedupeBy<int, LearningGroupPost>(
      items
        .whereType<Map<String, dynamic>>()
        .map(LearningGroupPost.fromJson)
        .where((post) => post.postId > 0),
      (post) => post.postId,
    );
  }

  List<LearningGroupComment> _parseComments(dynamic data) {
    final items = data is List<dynamic> ? data : const <dynamic>[];
    return _dedupeBy<int, LearningGroupComment>(
      items
          .whereType<Map<String, dynamic>>()
          .map(LearningGroupComment.fromJson)
          .where((comment) => comment.id > 0),
      (comment) => comment.id,
    );
  }

  Future<void> _saveCache(String key, dynamic response) async {
    try {
      await _localStorage.saveLearningGroupsCache(key, jsonEncode(response));
    } catch (e) {
      debugPrint('[LearningGroupService] Cache write failed: $e');
    }
  }

  Future<dynamic> _readCache(String key) async {
    try {
      final raw = await _localStorage.getLearningGroupsCache(key);
      if (raw == null || raw.isEmpty) return null;
      return jsonDecode(raw);
    } catch (e) {
      debugPrint('[LearningGroupService] Cache read failed: $e');
      return null;
    }
  }

  List<T> _dedupeBy<K, T>(Iterable<T> items, K Function(T item) keyOf) {
    final result = <T>[];
    final seen = <K>{};
    for (final item in items) {
      if (seen.add(keyOf(item))) {
        result.add(item);
      }
    }
    return result;
  }

  int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
