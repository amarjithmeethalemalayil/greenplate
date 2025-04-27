import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/widgets/build_ingredients_section.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/widgets/build_instructions_section.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/widgets/build_recipe_title.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_credits_info.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_detail_page_appbar.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_details_section.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_image_section.dart';

class RecipeDetailPageBase extends StatelessWidget {
  final RecipeDetailEntity recipeDetailEntity;
  final bool isSaved;
  final Function()? onTap;

  const RecipeDetailPageBase({
    super.key,
    required this.recipeDetailEntity,
    required this.isSaved,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeDetailPageAppbar(
        isSaved: isSaved,
        onTap: onTap,
      ),
      body: _buildRecipeDetail(recipeDetailEntity),
    );
  }

  Widget _buildRecipeDetail(RecipeDetailEntity recipeDetailEntity) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          RecipeImageSection(recipeDetailEntity: recipeDetailEntity),
          SizedBox(height: 20.h),
          BuildRecipeTitle(title: recipeDetailEntity.title),
          SizedBox(height: 15.h),
          RecipeDetailsSection(recipeDetailEntity: recipeDetailEntity),
          SizedBox(height: 20.h),
          RecipeCreditsInfo(recipeDetailEntity: recipeDetailEntity),
          SizedBox(height: 25.h),
          BuildIngredientsSection(
            extendedIngredients: recipeDetailEntity.extendedIngredients,
          ),
          SizedBox(height: 25.h),
          BuildInstructionsSection(
            instructions: recipeDetailEntity.instructions,
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
