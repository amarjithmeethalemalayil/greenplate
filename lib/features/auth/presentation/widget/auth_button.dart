import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class AuthButton extends StatelessWidget {
  final String iconPurpose;
  final Function()? onPressed;
  const AuthButton({
    super.key,
    required this.iconPurpose,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
        ),
        child: Center(
          child: Text(
            iconPurpose,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: MyColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
