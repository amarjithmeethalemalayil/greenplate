import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';
import 'package:green_plate/core/widgets/common_app_bar.dart';
import 'package:green_plate/core/widgets/common_loading.dart';
import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/bloc/detail_recipe_bloc.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_credits_info.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_details_section.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_image_section.dart';

class RecipeDetailViewPage extends StatelessWidget {
  final String id;
  const RecipeDetailViewPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<DetailRecipeBloc>().add(FetchDetailRecipeEvent(id));
    return Scaffold(
      appBar: const CommonAppBar(title: 'Recipe Details'),
      body: BlocBuilder<DetailRecipeBloc, DetailRecipeState>(
        builder: (context, state) {
          if (state is DetailRecipeLoading) {
            return CommonLoading();
          } else if (state is DetailRecipeLoaded) {
            return _buildRecipeDetail(state.recipe);
          } else if (state is DetailRecipeError) {
            return _buildError(state.message);
          } else {
            return _buildError('Something went wrong.');
          }
        },
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(child: Text('Error: $message'));
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
          _buildRecipeTitle(recipeDetailEntity.title),
          SizedBox(height: 15.h),
          RecipeDetailsSection(recipeDetailEntity: recipeDetailEntity),
          SizedBox(height: 20.h),
          RecipeCreditsInfo(recipeDetailEntity: recipeDetailEntity),
          SizedBox(height: 25.h),
          _buildIngredients(recipeDetailEntity),
          SizedBox(height: 25.h),
          _buildInstructions(recipeDetailEntity),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildRecipeTitle(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: MyColors.blackColor,
        ),
      ),
    );
  }

  Widget _buildIngredients(RecipeDetailEntity recipeDetailEntity) {
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
          recipeDetailEntity.extendedIngredients
              .map((ingredient) => "• ${ingredient.name}")
              .join("\n"),
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildInstructions(RecipeDetailEntity recipeDetailEntity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Instructions:",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          recipeDetailEntity.instructions,
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }
}
