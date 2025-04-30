import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class FetchLocationSection extends StatelessWidget {
  final bool isFetched;
  final Function()? onPressedGetLocation;
  const FetchLocationSection({
    super.key,
    required this.isFetched,
    this.onPressedGetLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Current Location",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: MyColors.blackColor,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 55.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: isFetched
                      ? MyColors.whiteColor
                      : MyColors.transparentColor,
                  border: Border.all(color: MyColors.shadowColor),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: isFetched
                      ? [
                          BoxShadow(
                            color: MyColors.shadowColor,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisAlignment: isFetched
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: isFetched
                      ? [
                          Icon(
                            Icons.check_circle,
                            color: MyColors.successColor,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Location Fetched",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: MyColors.successColor,
                            ),
                          ),
                        ]
                      : [
                          Text(
                            "Fetch Current Location",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: MyColors.blackColor,
                            ),
                          ),
                        ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: onPressedGetLocation,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.shadowColor,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.my_location,
                      size: 22.sp,
                      color: MyColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
