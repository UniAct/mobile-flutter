class LearningGroupCourse {
  const LearningGroupCourse({
    required this.id,
    required this.code,
    required this.name,
    required this.credits,
  });

  final int id;
  final String code;
  final String name;
  final int credits;

  factory LearningGroupCourse.fromJson(Map<String, dynamic> json) {
    return LearningGroupCourse(
      id: _toInt(json['id']),
      code: (json['code'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      credits: _toInt(json['credits']),
    );
  }
}

class LearningGroupSummary {
  const LearningGroupSummary({
    required this.groupId,
    required this.groupName,
    required this.accessCode,
    required this.allowStudentPosts,
    required this.course,
    required this.myRole,
  });

  final int groupId;
  final String groupName;
  final String? accessCode;
  final bool allowStudentPosts;
  final LearningGroupCourse course;
  final String myRole;

  bool get isOwner => myRole.toLowerCase() == 'owner';
  bool get canPost => isOwner || allowStudentPosts;

  factory LearningGroupSummary.fromJson(Map<String, dynamic> json) {
    return LearningGroupSummary(
      groupId: _toInt(json['groupId']),
      groupName: (json['groupName'] ?? '').toString(),
      accessCode: json['accessCode']?.toString(),
      allowStudentPosts: json['allowStudentPosts'] == true,
      course: LearningGroupCourse.fromJson(
        (json['course'] as Map<String, dynamic>?) ?? const {},
      ),
      myRole: (json['myRole'] ?? 'Member').toString(),
    );
  }
}

class LearningGroupDetails extends LearningGroupSummary {
  const LearningGroupDetails({
    required super.groupId,
    required super.groupName,
    required super.accessCode,
    required super.allowStudentPosts,
    required super.course,
    required super.myRole,
    required this.memberCount,
  });

  final int memberCount;

  factory LearningGroupDetails.fromJson(Map<String, dynamic> json) {
    final summary = LearningGroupSummary.fromJson(json);
    return LearningGroupDetails(
      groupId: summary.groupId,
      groupName: summary.groupName,
      accessCode: summary.accessCode,
      allowStudentPosts: summary.allowStudentPosts,
      course: summary.course,
      myRole: summary.myRole,
      memberCount: _toInt(json['memberCount']),
    );
  }
}

class LearningGroupAttachment {
  const LearningGroupAttachment({
    required this.attachmentId,
    required this.fileName,
    required this.fileType,
    required this.url,
    required this.fileSize,
  });

  final int attachmentId;
  final String fileName;
  final String fileType;
  final String url;
  final int? fileSize;

  factory LearningGroupAttachment.fromJson(Map<String, dynamic> json) {
    return LearningGroupAttachment(
      attachmentId: _toInt(json['attachmentId']),
      fileName: (json['fileName'] ?? 'Attachment').toString(),
      fileType: (json['fileType'] ?? '').toString(),
      url: (json['url'] ?? '').toString(),
      fileSize: _toNullableInt(json['fileSize']),
    );
  }
}

class LearningGroupPost {
  const LearningGroupPost({
    required this.postId,
    required this.postType,
    required this.content,
    required this.dueDate,
    required this.isPinned,
    required this.isEdited,
    required this.createdAt,
    required this.authorName,
    required this.attachments,
    required this.commentCount,
  });

  final int postId;
  final String postType;
  final String? content;
  final DateTime? dueDate;
  final bool isPinned;
  final bool isEdited;
  final DateTime? createdAt;
  final String authorName;
  final List<LearningGroupAttachment> attachments;
  final int commentCount;

  factory LearningGroupPost.fromJson(Map<String, dynamic> json) {
    final author = (json['author'] as Map<String, dynamic>?) ?? const {};
    final first = (author['firstName'] ?? '').toString();
    final last = (author['lastName'] ?? '').toString();
    return LearningGroupPost(
      postId: _toInt(json['postId']),
      postType: (json['postType'] ?? 'MATERIAL').toString(),
      content: json['content']?.toString(),
      dueDate: _toDate(json['dueDate']),
      isPinned: json['isPinned'] == true,
      isEdited: json['isEdited'] == true,
      createdAt: _toDate(json['createdAt']),
      authorName: '$first $last'.trim().isEmpty ? 'Unknown' : '$first $last'.trim(),
      attachments: (json['attachments'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(LearningGroupAttachment.fromJson)
          .toList(),
      commentCount: _toInt(json['commentCount']),
    );
  }
}

class LearningGroupComment {
  const LearningGroupComment({
    required this.id,
    required this.content,
    required this.authorName,
    required this.createdAt,
  });

  final int id;
  final String content;
  final String authorName;
  final DateTime? createdAt;

  factory LearningGroupComment.fromJson(Map<String, dynamic> json) {
    final author = (json['author'] as Map<String, dynamic>?) ?? const {};
    final first = (author['firstName'] ?? '').toString();
    final last = (author['lastName'] ?? '').toString();
    return LearningGroupComment(
      id: _toInt(json['commentId'] ?? json['id']),
      content: (json['content'] ?? '').toString(),
      authorName: '$first $last'.trim().isEmpty ? 'Unknown' : '$first $last'.trim(),
      createdAt: _toDate(json['createdAt']),
    );
  }
}

int _toInt(dynamic value) {
  if (value is int) return value;
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

int? _toNullableInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}

DateTime? _toDate(dynamic value) {
  if (value == null) return null;
  return DateTime.tryParse(value.toString())?.toLocal();
}
