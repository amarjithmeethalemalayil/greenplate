import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/assets/asset_helper.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class AcceptDonationBox extends StatelessWidget {
  const AcceptDonationBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315.w,
      child: Card(
        color: MyColors.unSelectedColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 20.h,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      image: DecorationImage(
                        image: AssetImage(AssetHelper.homeBannerImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Food Type: Lunch",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: MyColors.blackColor,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Food Name: Vegetable Rice",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: MyColors.blackColor,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Donated by: John Doe",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: MyColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                height: 45.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Interest",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
