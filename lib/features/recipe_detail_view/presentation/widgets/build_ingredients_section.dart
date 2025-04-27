import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/ingredient_entity.dart';

class BuildIngredientsSection extends StatelessWidget {
  final List<IngredientEntity> extendedIngredients;
  
  const BuildIngredientsSection({
    super.key,
    required this.extendedIngredients,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ingredients:",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          extendedIngredients
              .map((ingredient) => "• ${ingredient.name}")
              .join("\n"),
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }
}
