import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';
import 'package:green_plate/core/route/recipe_detail_view_page_navigator.dart';
import 'package:green_plate/core/widgets/common_app_bar.dart';
import 'package:green_plate/core/widgets/common_loading.dart';
import 'package:green_plate/features/ai_recipe/presentation/bloc/ai_recipe_bloc.dart';
import 'package:green_plate/features/ai_recipe/presentation/cubit/ai_recipe_list_cubit.dart';
import 'package:green_plate/features/ai_recipe/presentation/widget/empty_list_text.dart';
import 'package:green_plate/features/ai_recipe/presentation/widget/input_section.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/pages/recipe_detail_view_page.dart';

class AiRecipePage extends StatefulWidget {
  const AiRecipePage({super.key});

  @override
  State<AiRecipePage> createState() => _AiRecipePageState();
}

class _AiRecipePageState extends State<AiRecipePage> {
  final _listController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _listController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addIngredient() {
    context.read<AiRecipeListCubit>().addIngredient(_listController.text);
    _listController.clear();
    _focusNode.requestFocus();
  }

  void _removeIngredient(int index) {
    context.read<AiRecipeListCubit>().removeIngredient(index);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ingredient removed'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _fetchRecipe() {
    final ingredientState = context.read<AiRecipeListCubit>().state;
    if (ingredientState is AiRecipeListLoaded) {
      final ingredients =
          ingredientState.ingredients.map((e) => e['name'] as String).toList();
      context.read<AiRecipeBloc>().add(FetchAiRecipeEvent(ingredients));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Create Recipe"),
      body: BlocConsumer<AiRecipeBloc, AiRecipeState>(
        listener: (context, state) {
          if (state is AiRecipeLoaded) {
            RecipeDetailViewPageNavigator.navigateWithPopupAnimation(
              context,
              RecipeDetailViewPage(
                id: state.aiRecipe.id.toString(),
              ),
            );
          }
          if (state is AiRecipeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AiRecipeLoading) {
            return CommonLoading();
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                BlocBuilder<AiRecipeListCubit, AiRecipeListState>(
                  builder: (context, state) {
                    return switch (state) {
                      AiRecipeListInitial() => const EmptyListText(),
                      AiRecipeListLoaded(ingredients: final ingredients) =>
                        Expanded(
                          child: Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children: ingredients.map((ingredient) {
                                return Chip(
                                  backgroundColor: ingredient['color'],
                                  label: Text(ingredient['name']),
                                  deleteIcon: Icon(Icons.close, size: 16.sp),
                                  onDeleted: () {
                                    _removeIngredient(
                                      ingredients.indexOf(ingredient),
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: MyColors.blackColor,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      AiRecipeListError(message: final message) => Text(
                          message,
                          style: TextStyle(color: MyColors.errorColor),
                        ),
                    };
                  },
                ),
                InputSection(
                  controller: _listController,
                  focusNode: _focusNode,
                  onPressed: _addIngredient,
                  onPressToGetRecipe: _fetchRecipe,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
