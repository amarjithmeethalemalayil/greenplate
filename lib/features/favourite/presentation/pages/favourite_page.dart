import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/route/recipe_detail_view_page_navigator.dart';
import 'package:green_plate/core/widgets/build_error_text.dart';
import 'package:green_plate/core/widgets/common_app_bar.dart';
import 'package:green_plate/core/widgets/common_loading.dart';
import 'package:green_plate/features/favourite/presentation/widget/recipe_card.dart';
import 'package:green_plate/features/favourite/presentation/bloc/fav_recipes_bloc.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/pages/recipe_detail_view_page.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavRecipesBloc>().add(FetchFavRecipesEvent());
    return Scaffold(
      appBar: CommonAppBar(
        title: "Favourite",
        actions: [
          IconButton(
            onPressed: () =>
                context.read<FavRecipesBloc>().add(FetchFavRecipesEvent()),
            icon: Icon(Icons.replay_outlined),
          ),
        ],
      ),
      body: BlocBuilder<FavRecipesBloc, FavRecipesState>(
        builder: (context, state) {
          if (state is FavRecipesLoading) {
            return CommonLoading();
          } else if (state is FavRecipesError) {
            return BuildErrorText(message: state.message);
          } else if (state is FavRecipesLoaded) {
            final recipes = state.recipes;
            if (recipes.isEmpty) {
              return Center(
                child: Text('There is no Favourite'),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return RecipeCard(
                  recipeName: recipe.title,
                  imagePath: recipe.imageUrl,
                  time: recipe.readyInMinutes,
                  onDelete: () {
                    BlocProvider.of<FavRecipesBloc>(context).add(
                      DeleteFavRecipeEvent(
                        recipe.id.toString(),
                      ),
                    );
                  },
                  onTap: () {
                    RecipeDetailViewPageNavigator.navigateWithPopupAnimation(
                      context,
                      RecipeDetailViewPage(
                        id: recipe.id.toString(),
                      ),
                    );
                  },
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
