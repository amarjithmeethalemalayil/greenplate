import 'package:flutter/material.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;
  const ErrorPage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          errorMessage,
          style: TextStyle(color: MyColors.errorColor),
        ),
      ),
    );
  }
}
