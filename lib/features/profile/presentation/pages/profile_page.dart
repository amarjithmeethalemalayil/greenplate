import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';
import 'package:green_plate/core/widgets/common_app_bar.dart';
import 'package:green_plate/features/profile/presentation/widget/logout_btn.dart';
import 'package:green_plate/features/profile/presentation/widget/option_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Profile"),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle_rounded,
                size: 80.sp,
                color: MyColors.blackColor,
              ),
              SizedBox(height: 20.h),
              Text(
                "John Doe",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: MyColors.blackColor,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "john.doe@example.com",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: MyColors.highLightTextColor,
                ),
              ),
              SizedBox(height: 32.h),
              OptionSection(),
              SizedBox(height: 32.h),
              LogoutBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
