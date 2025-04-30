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

class WrongCredentialsException extends AppException {
  const WrongCredentialsException(super.message, [super.stackTrace]);
}

class EmailAlreadyInUseException extends AppException {
  const EmailAlreadyInUseException(super.message, [super.stackTrace]);
}

class LocationServiceDisabledException extends AppException {
  const LocationServiceDisabledException(super.message, super.stackTrace);
}

class LocationPermissionDeniedException extends AppException {
  const LocationPermissionDeniedException(super.message, super.stackTrace);
}

class LocationPermissionPermanentlyDeniedException extends AppException {
  const LocationPermissionPermanentlyDeniedException(super.message, super.stackTrace);
}

class LocationPermissionRestrictedException extends AppException {
  const LocationPermissionRestrictedException(super.message, super.stackTrace);
}

class InvalidLocationDataException extends AppException {
  const InvalidLocationDataException(super.message, super.stackTrace);
}

class LocationFetchingException extends AppException {
  const LocationFetchingException(super.message, super.stackTrace);
}