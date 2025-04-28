abstract class Failure {
  final String message;
  final StackTrace stackTrace;

  const Failure(this.message, [this.stackTrace = StackTrace.empty]);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, [super.stackTrace]);
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure(super.message, [super.stackTrace]);
}

class EmailAlreadyInUseFailure extends Failure {
  const EmailAlreadyInUseFailure(super.message, [super.stackTrace]);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message, [super.stackTrace]);
}