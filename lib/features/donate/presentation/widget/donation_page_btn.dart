import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class DonationPageBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonName;
  final Color? btnColor;

  const DonationPageBtn({
    super.key,
    this.onPressed,
    required this.buttonName,
    this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55.h,
        width: 315.w,
        decoration: BoxDecoration(
          color: btnColor ?? MyColors.primaryColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: MyColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
