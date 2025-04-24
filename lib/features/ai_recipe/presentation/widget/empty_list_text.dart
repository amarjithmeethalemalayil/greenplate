import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class EmptyListText extends StatelessWidget {
  const EmptyListText({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fastfood,
              size: 50.sp,
              color: MyColors.highLightTextColor,
            ),
            SizedBox(height: 16.h),
            Text(
              "Add your ingredients",
              style: TextStyle(
                fontSize: 18.sp,
                color:MyColors.blackColor,
              ),
            ),
            Text(
              "Example: tomatoes, onions, chicken",
              style: TextStyle(
                fontSize: 14.sp,
                color: MyColors.highLightTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
