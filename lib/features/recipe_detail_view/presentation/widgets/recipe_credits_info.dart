import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';

class RecipeCreditsInfo extends StatelessWidget {
  final RecipeDetailEntity recipeDetailEntity;

  const RecipeCreditsInfo({
    super.key,
    required this.recipeDetailEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Credits: ${recipeDetailEntity.creditsText}",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "License: ${recipeDetailEntity.license}",
          style: TextStyle(fontSize: 16.sp),
        ),
        Text(
          "Source: ${recipeDetailEntity.sourceName}",
          style: TextStyle(fontSize: 16.sp),
        ),
        Text(
          "Source URL: ${recipeDetailEntity.sourceUrl}",
          style: TextStyle(
            fontSize: 16.sp,
            color: MyColors.urlColor,
          ),
        ),
      ],
    );
  }
}
