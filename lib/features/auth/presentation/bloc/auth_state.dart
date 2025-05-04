part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class SignUpSuccess extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

