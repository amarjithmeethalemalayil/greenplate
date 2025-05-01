import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class FetchLocationSection extends StatelessWidget {
  final bool isFetched;
  final bool isLoading;
  final VoidCallback? onPressedGetLocation;
  
  const FetchLocationSection({
    super.key,
    required this.isFetched,
    this.onPressedGetLocation,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        SizedBox(height: 12.h),
        _buildLocationRow(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      "Current Location",
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: MyColors.blackColor,
      ),
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        _buildStatusContainer(),
        SizedBox(width: 12.w),
        _buildFetchButton(),
      ],
    );
  }

  Widget _buildStatusContainer() {
    return Expanded(
      flex: 2,
      child: Container(
        height: 55.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: isFetched ? MyColors.whiteColor : MyColors.transparentColor,
          border: Border.all(color: MyColors.shadowColor),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: isFetched ? [_defaultBoxShadow] : [],
        ),
        child: _buildStatusContent(),
      ),
    );
  }

  Widget _buildStatusContent() {
    if (isLoading) {
      return Center(
        child: Text(
          "Fetching...",
          style: TextStyle(
            fontSize: 14.sp,
            color: MyColors.blackColor,
          ),
        ),
      );
    }
    return isFetched
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
            ],
          )
        : Center(
            child: Text(
              "Fetch Current Location",
              style: TextStyle(
                fontSize: 14.sp,
                color: MyColors.blackColor,
              ),
            ),
          );
  }

  Widget _buildFetchButton() {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: isLoading ? null : onPressedGetLocation,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          height: 55.h,
          decoration: BoxDecoration(
            color: isLoading ? MyColors.shadowColor : MyColors.primaryColor,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [_defaultBoxShadow],
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      color: MyColors.whiteColor,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(
                    Icons.my_location,
                    size: 22.sp,
                    color: MyColors.whiteColor,
                  ),
          ),
        ),
      ),
    );
  }

  BoxShadow get _defaultBoxShadow => BoxShadow(
        color: MyColors.shadowColor,
        blurRadius: 5,
        offset: const Offset(2, 2),
      );
}