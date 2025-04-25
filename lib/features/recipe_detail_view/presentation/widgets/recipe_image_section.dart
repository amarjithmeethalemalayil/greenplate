import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/assets/asset_helper.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';

class RecipeImageSection extends StatelessWidget {
  final RecipeDetailEntity recipeDetailEntity;
  const RecipeImageSection({
    super.key,
    required this.recipeDetailEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'recipe-hero-${recipeDetailEntity.id}',
      child: SizedBox(
        height: 250.h,
        width: 315.w,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: recipeDetailEntity.image.isNotEmpty
                ? Image.network(
                    recipeDetailEntity.image,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    AssetHelper.homeBannerImage,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
