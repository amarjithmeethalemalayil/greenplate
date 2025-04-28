part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({
    required this.email,
    required this.password,
  });
}

class SignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignUpRequested({
    required this.name,
    required this.email,
    required this.password,
  });
}
