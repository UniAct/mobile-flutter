import 'package:equatable/equatable.dart';

class SyncQueueModel extends Equatable {
  final int id;
  final String
  actionType; // mark_attendance, delete_attendance, update_attendance
  final String entityType; // attendance, session, course, etc
  final int entityId;
  final String payloadJson;
  final DateTime createdAt;
  final String syncStatus; // pending, syncing, synced, failed
  final int retryCount;
  final String? lastError;
  final DateTime? lastRetryAt;
  final DateTime? nextRetryAt;

  const SyncQueueModel({
    required this.id,
    required this.actionType,
    required this.entityType,
    required this.entityId,
    required this.payloadJson,
    required this.createdAt,
    required this.syncStatus,
    required this.retryCount,
    this.lastError,
    this.lastRetryAt,
    this.nextRetryAt,
  });

  bool get isPending => syncStatus == 'pending';
  bool get isSyncing => syncStatus == 'syncing';
  bool get isSuccess => syncStatus == 'synced' || syncStatus == 'success';
  bool get isFailed => syncStatus == 'failed';

  SyncQueueModel copyWith({
    int? id,
    String? actionType,
    String? entityType,
    int? entityId,
    String? payloadJson,
    DateTime? createdAt,
    String? syncStatus,
    int? retryCount,
    String? lastError,
    DateTime? lastRetryAt,
    DateTime? nextRetryAt,
  }) {
    return SyncQueueModel(
      id: id ?? this.id,
      actionType: actionType ?? this.actionType,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      lastRetryAt: lastRetryAt ?? this.lastRetryAt,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    actionType,
    entityType,
    entityId,
    payloadJson,
    createdAt,
    syncStatus,
    retryCount,
    lastError,
    lastRetryAt,
    nextRetryAt,
  ];
}
