import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/assets/asset_helper.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class HomeBanner extends StatelessWidget {
  final Function()? onTap;
  const HomeBanner({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      width: 315.w,
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 15.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: MyColors.bannerCardListColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: MyColors.shadowColor,
            blurRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Create a recipe with\nyour ingredients",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: MyColors.whiteColor,
                  height: 1.3,
                ),
              ),
              InkWell(
                onTap: onTap,
                child: Container(
                  height: 40.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: MyColors.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.shadowColor,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Try",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.primaryColor,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: MyColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100.h,
            width: 100.w,
            child: Image.asset(AssetHelper.homeBannerImage),
          ),
        ],
      ),
    );
  }
}
