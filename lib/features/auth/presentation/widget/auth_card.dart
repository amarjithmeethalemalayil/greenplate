import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';
import 'package:green_plate/features/auth/presentation/widget/auth_button.dart';
import 'package:green_plate/features/auth/presentation/widget/auth_tect_field.dart';

class AuthCard extends StatelessWidget {
  final bool isSignUp;
  final Function()? onPressed;
  final TextEditingController? nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Widget route;

  const AuthCard({
    super.key,
    this.isSignUp = false,
    this.onPressed,
    this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return _buildLoginSignUpSpace(
      children: [
        Text(
          isSignUp ? "Create Account" : "Welcome Back!",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          isSignUp ? "Sign up to get started" : "Login to continue",
          style: TextStyle(
            fontSize: 16.sp,
            color: MyColors.shadowColor,
          ),
        ),
        SizedBox(height: 30.h),
        if (isSignUp) ...[
          AuthTectField(
            obscureText: false,
            controller: nameController ?? TextEditingController(),
            hintText: "Name",
          ),
          SizedBox(height: 20.h),
        ],
        AuthTectField(
          obscureText: false,
          controller: emailController,
          hintText: "Email",
        ),
        SizedBox(height: 20.h),
        AuthTectField(
          obscureText: true,
          controller: passwordController,
          hintText: "Password",
        ),
        SizedBox(height: 30.h),
        AuthButton(
          iconPurpose: isSignUp ? "Sign Up" : "Login",
          onPressed: onPressed,
        ),
        SizedBox(height: 20.h),
        _buildRichText(
          isSignUp: isSignUp,
          context: context,
          route: route,
        ),
      ],
    );
  }

  Widget _buildLoginSignUpSpace({required List<Widget> children}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 30.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildRichText({
    required bool isSignUp,
    required BuildContext context,
    required Widget route,
  }) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: RichText(
        text: TextSpan(
          text: isSignUp
              ? "Already have an account? "
              : "Don't have an account? ",
          style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 16.sp,
          ),
          children: [
            TextSpan(
              text: isSignUp ? "Sign In" : "Sign Up",
              style: TextStyle(
                color: MyColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => route,
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
