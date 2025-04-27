import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/route/recipe_detail_view_page_navigator.dart';
import 'package:green_plate/core/widgets/common_loading.dart';
import 'package:green_plate/core/widgets/recipe_box.dart';
import 'package:green_plate/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:green_plate/features/home/presentation/bloc/recipe_bloc.dart';
import 'package:green_plate/features/home/presentation/config/tabbar_list.dart';
import 'package:green_plate/features/home/presentation/cubit/tab_bar_cubit.dart';
import 'package:green_plate/features/home/presentation/widgets/home_banner.dart';
import 'package:green_plate/features/home/presentation/widgets/home_header.dart';
import 'package:green_plate/features/home/presentation/widgets/home_tabbar.dart';
import 'package:green_plate/features/home/presentation/widgets/recipe_search_textfield.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/pages/recipe_detail_view_page.dart';
import 'package:green_plate/features/search_dish/presentation/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: TabbarList.tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _fetchRecipesForTab(0);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      final selectedIndex = _tabController.index;
      context.read<TabBarCubit>().changeTab(selectedIndex);
      _fetchRecipesForTab(selectedIndex);
    }
  }

  void _fetchRecipesForTab(int tabIndex) {
    final category = _mapTabIndexToCategory(tabIndex);
    context.read<RecipeBloc>().add(FetchRecipes(category));
  }

  String _mapTabIndexToCategory(int index) {
    return TabbarList.tabs[index].toLowerCase();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 20.h,
          ).copyWith(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(username: "Amar"),
              SizedBox(height: 30.h),
              RecipeSearchTextfield(widget: SearchPage()),
              SizedBox(height: 20.h),
              HomeBanner(
                onTap: () => context.read<BottomNavCubit>().updateIndex(2),
              ),
              SizedBox(height: 25.h),
              BlocBuilder<TabBarCubit, int>(
                builder: (context, selectedIndex) {
                  if (_tabController.index != selectedIndex) {
                    _tabController.animateTo(selectedIndex);
                  }
                  return HomeTabBar(
                    tabs: TabbarList.tabs,
                    controller: _tabController,
                    onTabSelected: (index) {
                      context.read<TabBarCubit>().changeTab(index);
                      _fetchRecipesForTab(index);
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: BlocBuilder<RecipeBloc, RecipeState>(
                  builder: (context, state) {
                    if (state is RecipeLoading) {
                      return CommonLoading();
                    } else if (state is RecipeError) {
                      return Center(child: Text(state.message));
                    } else if (state is RecipeLoaded) {
                      return ListView.builder(
                        itemCount: state.recipes.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final recipe = state.recipes[index];
                          return Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: GestureDetector(
                              onTap: () => RecipeDetailViewPageNavigator
                                  .navigateWithPopupAnimation(
                                context,
                                RecipeDetailViewPage(
                                  id: recipe.id.toString(),
                                ),
                              ),
                              child: RecipeBox(
                                recipeName: recipe.title,
                                imagePath: recipe.imageUrl,
                                time: '${recipe.readyInMinutes}',
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: Text('Select a category'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
