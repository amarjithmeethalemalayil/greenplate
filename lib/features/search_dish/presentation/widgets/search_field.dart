import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class SearchField extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String)? onSubmitted;
  const SearchField({
    super.key,
    required this.searchController,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: MyColors.shadowColor),
        ),
        child: Center(
          child: TextField(
            controller: searchController,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search for recipes...",
              icon: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
