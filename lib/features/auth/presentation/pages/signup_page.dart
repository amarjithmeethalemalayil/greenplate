import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:green_plate/core/route/app_router.dart';
import 'package:green_plate/core/utils/app_snackbar.dart';
import 'package:green_plate/core/widgets/common_loading.dart';
import 'package:green_plate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:green_plate/features/auth/presentation/widget/app_logo.dart';
import 'package:green_plate/features/auth/presentation/widget/auth_card.dart';
import 'package:green_plate/features/auth/presentation/widget/default_view.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final signupUsecase = SignUpRequested(
        name: name,
        email: email,
        password: password,
      );
      context.read<AuthBloc>().add(signupUsecase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            AppSnackbar.show(context, state.message);
          }
          if (state is SignUpSuccess) {
            AppSnackbar.show(context, "Account Created. Now login");
            context.go(AppRouter.login);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return CommonLoading();
          } else if (state is AuthInitial) {
            return _buildSignupView();
          }
          return DefaultView(onPressed: () => context.pop());
        },
      ),
    );
  }

  Widget _buildSignupView() {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SafeArea(
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 20.h,
                ),
                child: Column(
                  children: [
                    AppLogo(),
                    SizedBox(height: 40.h),
                    AuthCard(
                      isSignUp: true,
                      nameController: _nameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      route: AppRouter.login,
                      onPressed: () => _handleSignup(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
