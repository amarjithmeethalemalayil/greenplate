import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class FetchLocationSection extends StatelessWidget {
  const FetchLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Current location",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 55.h,
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.shadowColor),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    "Fetch Current Location",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 1,
              child: Container(
                height: 55.h,
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                    child: Icon(Icons.my_location, color: MyColors.whiteColor)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
