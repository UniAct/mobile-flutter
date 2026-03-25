class AppException implements Exception {
  AppException(this.message, {this.isNetworkError = false, this.statusCode});

  final String message;
  final bool isNetworkError;
  final int? statusCode;

  @override
  String toString() => message;
}
