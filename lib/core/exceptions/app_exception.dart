enum AppExceptionCode {
  none,
  noContent,
  notInternet,
  genericError,
  notFound,
}

class AppException implements Exception {
  final AppExceptionCode error;

  AppException(this.error);
}
