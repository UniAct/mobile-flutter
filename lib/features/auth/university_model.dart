class UniversityModel {
  UniversityModel({required this.name, this.logoUrl});

  final String name;
  final String? logoUrl;

  factory UniversityModel.fromDynamic(dynamic item) {
    if (item is String) {
      return UniversityModel(name: item);
    }

    if (item is Map<String, dynamic>) {
      final name = (item['name'] ?? item['university_name'] ?? '').toString();
      final settings = item['settings'];
      final logoUrl =
          item['logo_url'] ??
          item['logoUrl'] ??
          (settings is Map<String, dynamic>
              ? settings['logo_url'] ?? settings['logoUrl']
              : null);

      return UniversityModel(
        name: name,
        logoUrl: logoUrl?.toString().trim().isEmpty == true
            ? null
            : logoUrl?.toString(),
      );
    }

    throw Exception('Invalid university item format');
  }
}
