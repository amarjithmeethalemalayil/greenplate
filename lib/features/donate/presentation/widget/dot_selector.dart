import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class DotSelector extends StatelessWidget {
  final int itemCount;
  final int selectedIndex;
  final List<String> labels;
  final ValueChanged<int> onSelected;

  const DotSelector({
    super.key,
    required this.itemCount,
    required this.selectedIndex,
    required this.labels,
    required this.onSelected,
  }) : assert(labels.length == itemCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: MyColors.donationMealSelectingBgBox,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20.w,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSelectorItem(0),
              SizedBox(height: 30.w),
              _buildSelectorItem(1),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (itemCount > 2) _buildSelectorItem(2),
              if (itemCount > 2) SizedBox(height: 30.h),
              if (itemCount > 3) _buildSelectorItem(3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectorItem(int index) {
    return GestureDetector(
      onTap: () => onSelected(index),
      child: Row(
        spacing: 10.w,
        mainAxisSize: MainAxisSize.min,
        children: [
          selectedIndex == index
              ? Icon(
                  Icons.check_box,
                  color: MyColors.primaryColor,
                )
              : Icon(Icons.check_box_outline_blank),
          Text(
            labels[index],
            style: selectedIndex == index
                ? TextStyle(fontWeight: FontWeight.bold)
                : TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
