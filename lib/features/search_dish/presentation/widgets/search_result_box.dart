import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class SearchResultBox extends StatelessWidget {
  final String imageUrl;
  final String title;
  const SearchResultBox({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: MyColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: MyColors.shadowColor,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.network(
            imageUrl,
            height: 100.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
