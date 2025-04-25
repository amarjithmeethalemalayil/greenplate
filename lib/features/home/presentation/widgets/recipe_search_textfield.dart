import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class RecipeSearchTextfield extends StatelessWidget {
  final Widget widget;
  const RecipeSearchTextfield({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) => widget),
        );
      },
      child: Container(
        height: 55.h,
        padding: EdgeInsets.only(left: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: MyColors.shadowColor,
          ),
        ),
        child: Center(
          child: Row(
            spacing: 20.w,
            children: [Icon(Icons.search), Text("Search dishes")],
          ),
        ),
      ),
    );
  }
}
