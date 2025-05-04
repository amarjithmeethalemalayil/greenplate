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
import 'package:restart_app/restart_app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final loginEvent = LoginRequested(email: email, password: password);
      context.read<AuthBloc>().add(loginEvent);
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
          if (state is LoginSuccess) {
            context.go(AppRouter.home);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return CommonLoading();
          } else if (state is AuthInitial) {
            return _buildLoginView();
          }
          return DefaultView(onPressed: () async => await Restart.restartApp());
        },
      ),
    );
  }

  Widget _buildLoginView() {
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
                    _commonSpace(),
                    AppLogo(),
                    _commonSpace(),
                    AuthCard(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      route: AppRouter.signUp,
                      onPressed: () => _handleSignIn(),
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

  Widget _commonSpace() {
    return SizedBox(height: 60.h);
  }
}
