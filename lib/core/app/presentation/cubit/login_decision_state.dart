part of 'login_decision_cubit.dart';

@immutable
sealed class LoginDecisionState {}

final class LoginDecisionInitial extends LoginDecisionState {}

class AlreadyLoggedIn extends LoginDecisionState {}

class LoginDecisionError extends LoginDecisionState {
  final String error;

  LoginDecisionError(this.error);
}
