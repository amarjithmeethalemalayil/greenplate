import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/app/domain/usecase/check_login_status.dart';

part 'login_decision_state.dart';

class LoginDecisionCubit extends Cubit<LoginDecisionState> {
  final CheckLoginStatus status;
  LoginDecisionCubit(this.status) : super(LoginDecisionInitial());

  Future<void> checkLoginStatus() async {
    try {
      final isLoggedIn = await status();
      if (isLoggedIn) {
        emit(AlreadyLoggedIn());
      } else {
        emit(LoginDecisionInitial());
      }
    } catch (e) {
      emit(LoginDecisionError('Error checking login status: $e'));
    }
  }
}
