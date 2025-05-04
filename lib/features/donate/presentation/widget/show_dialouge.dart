import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showDonationDetailBottomSheet({
  required BuildContext context,
  required String donatorName,
  required String mealType,
  required String contactNumber,
  required String pickupAddress,
  required String foodName,
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Center(
              child: Text(
                'Donation Details',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            _buildInfoTile(Icons.person, 'Donator', donatorName),
            _buildInfoTile(Icons.restaurant_menu, 'Meal Type', mealType),
            _buildInfoTile(Icons.fastfood_rounded, 'Food name', foodName),
            _buildInfoTile(Icons.phone, 'Contact', contactNumber),
            _buildInfoTile(Icons.location_on, 'Pickup Address', pickupAddress),
          ],
        ),
      );
    },
  );
}

Widget _buildInfoTile(IconData icon, String title, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: Row(
      children: [
        Icon(icon, size: 20.sp, color: Colors.grey[700]),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
              SizedBox(height: 2.h),
              Text(value,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ],
          ),
        ),
      ],
    ),
  );
}
