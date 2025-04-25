import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class HomeHeader extends StatelessWidget {
  final String username;

  const HomeHeader({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello $username",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: MyColors.blackColor,
              ),
            ),
            Text(
              "What are you cooking today?",
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: MyColors.highLightTextColor,
              ),
            ),
          ],
        ),
        Icon(Icons.account_circle_rounded, size: 35.sp)
      ],
    );
  }
}
