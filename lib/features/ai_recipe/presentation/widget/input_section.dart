import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class InputSection extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onPressed;
  final VoidCallback onPressToGetRecipe;
  
  const InputSection({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onPressed,
    required this.onPressToGetRecipe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56.h,
              decoration: BoxDecoration(
                color: MyColors.whiteColor,
                border: Border.all(color: MyColors.blackColor),
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: MyColors.shadowColor,
                    blurRadius: 4.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 15.h,
                  ),
                  border: InputBorder.none,
                  hintText: "Add an ingredient...",
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    color: MyColors.highLightTextColor,
                  ),
                ),
                style: TextStyle(fontSize: 16.sp),
                onSubmitted: (_) => onPressed(),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            height: 56.h,
            width: 56.h,
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: MyColors.shadowColor,
                  blurRadius: 4.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onPressToGetRecipe,
              icon: Icon(
                Icons.send,
                color: MyColors.whiteColor,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}