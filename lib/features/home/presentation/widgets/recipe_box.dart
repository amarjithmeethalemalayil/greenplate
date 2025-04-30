import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class RecipeBox extends StatelessWidget {
  final String recipeName;
  final String imagePath;
  final String time;
  final Function()? onTap;

  const RecipeBox({
    super.key,
    required this.recipeName,
    required this.imagePath,
    required this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 230.h,
        width: 150.w,
        child: Stack(
          children: [
            Positioned(
              top: 55.h,
              left: 0,
              child: Container(
                height: 200.h,
                width: 150.w,
                padding: EdgeInsets.only(
                  top: 66.h,
                  left: 10.w,
                  right: 10.w,
                  bottom: 20.h,
                ),
                decoration: BoxDecoration(
                  color: MyColors.recipeBoxColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      recipeName,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: MyColors.blackColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Text(
                      "Time",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: MyColors.shadowColor,
                      ),
                    ),
                    Text(
                      "$time min",
                      style: TextStyle(
                        color: MyColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: SizedBox(
                  height: 120.h,
                  width: 110.w,
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
