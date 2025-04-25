abstract class AppException implements Exception {
  final String message;
  final StackTrace stackTrace;

  const AppException(this.message, [this.stackTrace = StackTrace.empty]);
}

class ServerException extends AppException {
  const ServerException(super.message, [super.stackTrace]);
}

class CacheException extends AppException {
  const CacheException(super.message, [super.stackTrace]);
}