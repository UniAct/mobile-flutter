import 'package:flutter/foundation.dart';

/// Conflict resolver using timestamp-based strategy
///
/// Rules:
/// - Latest update always wins (compare updated_at timestamps)
/// - If local is newer: Don't update, let background sync upload local version
/// - If server is newer: Update local from server
/// - Conflicts are logged for diagnostics
class ConflictResolver {
  /// Compare timestamps and determine if local should be updated
  /// Returns true if server version is newer and local should be updated
  bool shouldUpdateLocalFromServer({
    required DateTime localUpdatedAt,
    required DateTime serverUpdatedAt,
  }) {
    final isServerNewer = serverUpdatedAt.isAfter(localUpdatedAt);

    if (isServerNewer) {
      debugPrint('[ConflictResolver] Server version is newer, updating local');
    } else if (serverUpdatedAt.isBefore(localUpdatedAt)) {
      debugPrint('[ConflictResolver] Local version is newer, keeping local');
    } else {
      debugPrint('[ConflictResolver] Timestamps equal, keeping local');
    }

    return isServerNewer;
  }

  /// Resolve conflict between local and server records
  /// Returns the record that should be persisted
  Map<String, dynamic> resolve({
    required Map<String, dynamic> local,
    required Map<String, dynamic> server,
    required String localTimestampField,
    required String serverTimestampField,
  }) {
    try {
      final localUpdatedAt = DateTime.parse(local[localTimestampField] ?? '');
      final serverUpdatedAt = DateTime.parse(
        server[serverTimestampField] ?? '',
      );

      if (shouldUpdateLocalFromServer(
        localUpdatedAt: localUpdatedAt,
        serverUpdatedAt: serverUpdatedAt,
      )) {
        debugPrint('[ConflictResolver] Using server version');
        return server;
      } else {
        debugPrint('[ConflictResolver] Using local version');
        return local;
      }
    } catch (e) {
      debugPrint('[ConflictResolver] Error parsing timestamps: $e');
      // Default to local on parse error
      return local;
    }
  }
}
