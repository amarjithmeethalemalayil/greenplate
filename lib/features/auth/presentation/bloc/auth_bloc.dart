import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/features/auth/domain/entity/user_entity.dart';
import 'package:green_plate/features/auth/domain/usecases/log_in.dart';
import 'package:green_plate/features/auth/domain/usecases/save_user.dart';
import 'package:green_plate/features/auth/domain/usecases/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogIn logIn;
  final SignUp signUp;
  final SaveUser saveUser;

  AuthBloc({
    required this.logIn,
    required this.signUp,
    required this.saveUser,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_handleLogin);
    on<SignUpRequested>(_handleSignUp);
  }

  Future<void> _handleLogin(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await logIn(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) {
        saveUserData(user);
        emit(LoginSuccess());
      },
    );
  }

  Future<void> _handleSignUp(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await signUp(event.name, event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.toString())),
      (user) {
        emit(SignUpSuccess());
      },
    );
  }

  Future<void> saveUserData(UserEntity user) async {
    await saveUser(user);
  }
}
