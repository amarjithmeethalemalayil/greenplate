import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/route/recipe_detail_view_page_navigator.dart';
import 'package:green_plate/core/widgets/common_loading.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/pages/recipe_detail_view_page.dart';
import 'package:green_plate/features/search_dish/presentation/bloc/search_recipe_bloc.dart';
import 'package:green_plate/features/search_dish/presentation/widgets/search_field.dart';
import 'package:green_plate/features/search_dish/presentation/widgets/search_result_box.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      context.read<SearchRecipeBloc>().add(SearchRecipeRequested(query: query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              Row(
                children: [
                  BackButton(),
                  SearchField(
                    searchController: _searchController,
                    onSubmitted: (_) => _onSearch(),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              BlocBuilder<SearchRecipeBloc, SearchRecipeState>(
                builder: (context, state) {
                  if (state is SearchRecipeLoading) {
                    return CommonLoading();
                  } else if (state is SearchRecipeError) {
                    return Center(child: Text(state.message));
                  } else if (state is SearchRecipeLoaded) {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: state.recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = state.recipes[index];
                          return GestureDetector(
                            onTap: () {
                              RecipeDetailViewPageNavigator
                                  .navigateWithPopupAnimation(
                                context,
                                RecipeDetailViewPage(
                                  id: recipe.id.toString(),
                                ),
                              );
                            },
                            child: SearchResultBox(
                              imageUrl: recipe.imageUrl,
                              title: recipe.title,
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("Search for recipes..."),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
