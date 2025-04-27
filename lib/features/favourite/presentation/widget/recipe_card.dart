import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class RecipeCard extends StatelessWidget {
  final String recipeName;
  final String imagePath;
  final int time;
  final VoidCallback onDelete;
  final Function()? onTap;

  const RecipeCard({
    super.key,
    required this.recipeName,
    required this.imagePath,
    required this.time,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imagePath,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildTextSection(),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 8.0,
              child: IconButton(
                icon: Icon(Icons.delete, color: MyColors.errorColor),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipeName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 4.h),
          Text(
            "Time: ${time.toString()} mins",
            style: TextStyle(
              color: MyColors.shadowColor,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
