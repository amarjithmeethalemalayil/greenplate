// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:green_plate/core/widgets/build_error_text.dart';
// import 'package:green_plate/core/widgets/common_loading.dart';
// import 'package:green_plate/features/recipe_detail_view/domain/entity/recipe_detail_entity.dart';
// import 'package:green_plate/features/recipe_detail_view/presentation/bloc/detail_recipe_bloc.dart';
// import 'package:green_plate/features/recipe_detail_view/presentation/widgets/build_ingredients_section.dart';
// import 'package:green_plate/features/recipe_detail_view/presentation/widgets/build_instructions_section.dart';
// import 'package:green_plate/features/recipe_detail_view/presentation/widgets/build_recipe_title.dart';
// import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_credits_info.dart';
// import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_detail_page_appbar.dart';
// import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_details_section.dart';
// import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_image_section.dart';

// class RecipeDetailViewPage extends StatelessWidget {
//   final String id;
//   const RecipeDetailViewPage({super.key, required this.id});

//   @override
//   Widget build(BuildContext context) {
//     context.read<DetailRecipeBloc>().add(FetchDetailRecipeEvent(id));
//     return Scaffold(
//       appBar: RecipeDetailPageAppbar(),
//       body: BlocBuilder<DetailRecipeBloc, DetailRecipeState>(
//         builder: (context, state) {
//           if (state is DetailRecipeLoading) {
//             return CommonLoading();
//           } else if (state is DetailRecipeLoaded) {
//             return _buildRecipeDetail(state.recipe);
//           } else if (state is DetailRecipeError) {
//             return BuildErrorText(message: state.message);
//           } else {
//             return BuildErrorText(message: 'Something went wrong.');
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildRecipeDetail(RecipeDetailEntity recipeDetailEntity) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(horizontal: 30.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 10.h),
//           RecipeImageSection(recipeDetailEntity: recipeDetailEntity),
//           SizedBox(height: 20.h),
//           BuildRecipeTitle(title: recipeDetailEntity.title),
//           SizedBox(height: 15.h),
//           RecipeDetailsSection(recipeDetailEntity: recipeDetailEntity),
//           SizedBox(height: 20.h),
//           RecipeCreditsInfo(recipeDetailEntity: recipeDetailEntity),
//           SizedBox(height: 25.h),
//           BuildIngredientsSection(
//             extendedIngredients: recipeDetailEntity.extendedIngredients,
//           ),
//           SizedBox(height: 25.h),
//           BuildInstructionsSection(
//             instructions: recipeDetailEntity.instructions,
//           ),
//           SizedBox(height: 30.h),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/entity/recipe_entity.dart';
import 'package:green_plate/core/widgets/build_error_text.dart';
import 'package:green_plate/core/widgets/common_loading.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/bloc/detail_recipe_bloc.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/widgets/recipe_detail_page_base.dart';

class RecipeDetailViewPage extends StatelessWidget {
  final String id;
  const RecipeDetailViewPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<DetailRecipeBloc>().add(FetchDetailRecipeEvent(id));
    //return RecipeDetailPageBase();
    return BlocBuilder<DetailRecipeBloc, DetailRecipeState>(
      builder: (context, state) {
        if (state is DetailRecipeLoading) {
          return CommonLoading();
        } else if (state is DetailRecipeLoaded) {
          final recipeDetailEntity = state.recipe;
          return RecipeDetailPageBase(
            isSaved: state.isSaved,
            recipeDetailEntity: recipeDetailEntity,
            onTap: () {
              final recipe = RecipeEntity(
                id: recipeDetailEntity.id,
                title: recipeDetailEntity.title,
                imageUrl: recipeDetailEntity.image,
                readyInMinutes: recipeDetailEntity.readyInMinutes,
              );
              context.read<DetailRecipeBloc>().add(
                    SaveRecipeToFirebase(
                      recipe: recipe,
                      recipeDetailEntity: recipeDetailEntity,
                    ),
                  );
            },
          );
        } else if (state is RecipeSavedToFirebase) {
          final recipeDetailEntity = state.recipeDetailEntity;
          return RecipeDetailPageBase(
            isSaved: state.isSaved,
            recipeDetailEntity: recipeDetailEntity,
          );
        } else if (state is DetailRecipeError) {
          return BuildErrorText(message: state.message);
        } else if(state is DetailRecipeLoading){
          return CommonLoading();
        } else {
          return BuildErrorText(message: 'Something went wrong.');
        }
      },
    );
  }
}
