import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/assets/asset_helper.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      height: 150.h,
      child: Image.asset(
        AssetHelper.appLogo,
      ),
    );
  }
}
