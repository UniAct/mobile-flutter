class UniversityModel {
  UniversityModel({required this.name});

  final String name;

  factory UniversityModel.fromDynamic(dynamic item) {
    if (item is String) {
      return UniversityModel(name: item);
    }

    if (item is Map<String, dynamic>) {
      final name = (item['name'] ?? item['university_name'] ?? '').toString();
      return UniversityModel(name: name);
    }

    throw Exception('Invalid university item format');
  }
}
