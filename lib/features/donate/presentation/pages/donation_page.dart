import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';
import 'package:green_plate/features/donate/presentation/widget/donation_submit_btn.dart';
import 'package:green_plate/features/donate/presentation/widget/donation_textfield.dart';
import 'package:green_plate/features/donate/presentation/widget/dot_selector.dart';
import 'package:green_plate/features/donate/presentation/widget/fetch_location_section.dart';
import 'package:green_plate/features/donate/presentation/widget/info_box.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  int _currentIndex = 0;
  final List<String> _mealTypes = ['Breakfast', 'Lunch', 'Snack', 'Dinner'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10.h,
      children: [
        InfoBox(),
        Text(
          "Select Meal Type",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.h),
        DotSelector(
          itemCount: _mealTypes.length,
          selectedIndex: _currentIndex,
          labels: _mealTypes,
          onSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        SizedBox(height: 10.h),
        DonationTextfield(
          label: "Food name",
          hintText: "Name of the food",
        ),
        SizedBox(height: 6.h),
        DonationTextfield(
          label: "Your pickup address",
          hintText: "Your pickup address",
          maxLine: 4,
        ),
        SizedBox(height: 10.h),
        FetchLocationSection(),
        SizedBox(height: 10.h),
        DonationSubmitBtn(),
      ],
    );
  }
}
