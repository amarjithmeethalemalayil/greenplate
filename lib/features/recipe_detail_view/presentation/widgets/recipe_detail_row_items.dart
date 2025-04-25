import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeDetailRowItems extends StatelessWidget {
  final String purpose;
  final String value;
  const RecipeDetailRowItems({
    super.key,
    required this.purpose,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          purpose,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
