import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class LogoutBtn extends StatelessWidget {
  final Function()? logOutPressed;
  const LogoutBtn({
    super.key,
    this.logOutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: logOutPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 40.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 5.0,
      ),
      child: Text(
        "Logout",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: MyColors.whiteColor,
        ),
      ),
    );
  }
}
