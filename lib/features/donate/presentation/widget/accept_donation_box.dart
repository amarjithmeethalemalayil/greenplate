import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';
import 'package:green_plate/features/donate/presentation/widget/donation_page_btn.dart';

class AcceptDonationBox extends StatelessWidget {
  final String mealTypeName;
  final String donatorName;
  final String nameOfTheFood;

  const AcceptDonationBox({
    super.key,
    required this.mealTypeName,
    required this.donatorName,
    required this.nameOfTheFood,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315.w,
      child: Card(
        color: MyColors.unSelectedColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        elevation: 6,
        shadowColor: MyColors.highLightTextColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 20.h,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meal Type: $mealTypeName",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: MyColors.blackColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Name of the donator: $donatorName",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: MyColors.blackColor,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "Food Name: $nameOfTheFood",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: MyColors.blackColor,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "view all details",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: MyColors.blackColor,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  _buildLocationSeation(),
                ],
              ),
              SizedBox(height: 20.h),
              DonationPageBtn(
                buttonName: "Interest",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSeation() {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: MyColors.shadowColor,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(10.sp),
      child: Icon(
        Icons.location_on,
        size: 30.sp,
        color: MyColors.urlColor,
      ),
    );
  }
}
