import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/app/presentation/cubit/login_decision_cubit.dart';
import 'package:green_plate/core/error/error_page.dart';
import 'package:green_plate/features/auth/presentation/pages/login_page.dart';
import 'package:green_plate/features/bottom_nav/presentation/pages/bottom_nav.dart';

class LoginDecisionPage extends StatelessWidget {
  const LoginDecisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LoginDecisionCubit>().checkLoginStatus();
    return Scaffold(
      body: BlocBuilder<LoginDecisionCubit, LoginDecisionState>(
        builder: (context, state) {
          if (state is AlreadyLoggedIn) {
            return BottomNav();
          } else if (state is LoginDecisionInitial) {
            return LoginPage();
          }else if (state is LoginDecisionError) {
            return ErrorPage(errorMessage: state.error);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
