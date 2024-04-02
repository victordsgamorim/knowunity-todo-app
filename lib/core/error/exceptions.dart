abstract class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

class InternetException extends AppException {
  const InternetException(super.message);
}

class ServerException extends AppException {
  const ServerException(super.message);
}

class CacheException extends AppException {
  const CacheException(super.message);
}
