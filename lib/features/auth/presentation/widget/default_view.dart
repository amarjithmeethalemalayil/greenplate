import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class DefaultView extends StatelessWidget {
  final Function()? onPressed;
  const DefaultView({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: MyColors.errorColor),
          SizedBox(height: 12.h),
          Text(
            'Something went wrong.\nPlease try again later.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
