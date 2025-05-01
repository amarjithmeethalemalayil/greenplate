import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class InfoBox extends StatelessWidget {
  final String message;
  const InfoBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: MyColors.infoBoxColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: MyColors.orangeColor, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: MyColors.orangeColor,
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13.sp,
                color: MyColors.infoTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
