abstract class Failure {
  final String message;
  final StackTrace stackTrace;

  const Failure(this.message, [this.stackTrace = StackTrace.empty]);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, [super.stackTrace]);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, [super.stackTrace]);
}