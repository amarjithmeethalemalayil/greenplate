import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/widgets/common_loading.dart';
import 'package:green_plate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:green_plate/features/auth/presentation/pages/signup_page.dart';
import 'package:green_plate/features/auth/presentation/widget/app_logo.dart';
import 'package:green_plate/features/auth/presentation/widget/auth_card.dart';
import 'package:green_plate/features/bottom_nav/presentation/pages/bottom_nav.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn(BuildContext context) {
    context.read<AuthBloc>().add(
          LoginRequested(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BottomNav()),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return CommonLoading();
          }
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLogo(),
                    SizedBox(height: 30.h),
                    AuthCard(
                      emailController: emailController,
                      passwordController: passwordController,
                      onPressed: () {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Fill all the fields")),
                          );
                          return;
                        } else {
                          _handleSignIn(context);
                        }
                      },
                      route: SignupPage(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}