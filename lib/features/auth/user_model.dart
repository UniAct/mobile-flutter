class UserModel {
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.universityName,
    required this.roles,
  });

  final String userId;
  final String name;
  final String email;
  final String universityName;
  final List<String> roles;

  String get primaryRole {
    if (roles.isEmpty) {
      return 'No role';
    }
    return roles.first;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rolesRaw = json['roles'];
    final parsedRoles = rolesRaw is List
        ? rolesRaw.map((e) => e.toString()).toList()
        : <String>[];

    return UserModel(
      userId: (json['user_id'] ?? json['id'] ?? '').toString(),
      name:
          (json['name'] ??
                  json['full_name'] ??
                  json['username'] ??
                  json['email'] ??
                  'Unknown User')
              .toString(),
      email: (json['email'] ?? '').toString(),
      universityName: (json['university_name'] ?? json['university'] ?? '')
          .toString(),
      roles: parsedRoles,
    );
  }
}
