import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/widgets/common_loading.dart';
import 'package:green_plate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:green_plate/features/auth/presentation/pages/login_page.dart';
import 'package:green_plate/features/auth/presentation/widget/app_logo.dart';
import 'package:green_plate/features/auth/presentation/widget/auth_card.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleSignup(BuildContext context) {
    context.read<AuthBloc>().add(
          SignUpRequested(
            name: nameController.text.trim(),
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
          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Account Created. Now login")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
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
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      isSignUp: true,
                      onPressed: () {
                        if (nameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Fill all the fields")),
                          );
                          return;
                        } else {
                          _handleSignup(context);
                        }
                      },
                      route: LoginPage(),
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