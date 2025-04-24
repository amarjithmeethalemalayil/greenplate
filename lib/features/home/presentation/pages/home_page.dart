import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/features/home/presentation/cubit/tab_bar_cubit.dart';
import 'package:green_plate/features/home/presentation/pages/show_page.dart';
import 'package:green_plate/features/home/presentation/widgets/home_banner.dart';
import 'package:green_plate/features/home/presentation/widgets/home_header.dart';
import 'package:green_plate/features/home/presentation/widgets/home_tabbar.dart';
import 'package:green_plate/features/home/presentation/widgets/recipe_search_textfield.dart';

final imageAddress =
    "https://static.vecteezy.com/system/resources/previews/029/364/950/non_2x/3d-carton-of-boy-going-to-school-ai-photo.jpg";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> _tabs = const [
    'All',
    'Breakfast',
    'Lunch',
    'Snacks',
    'Dinner',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      context.read<TabBarCubit>().changeTab(_tabController.index);
    }
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
              HomeHeader(username: "Amar", imageUrl: imageAddress),
              SizedBox(height: 30.h),
              const RecipeSearchTextfield(),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => ShowPage())),
                child: HomeBanner(),
              ),
              SizedBox(height: 25.h),
              BlocBuilder<TabBarCubit, int>(
                builder: (context, selectedIndex) {
                  if (_tabController.index != selectedIndex) {
                    _tabController.animateTo(selectedIndex);
                  }
                  return HomeTabBar(
                    tabs: _tabs,
                    controller: _tabController,
                    onTabSelected: (index) =>
                        context.read<TabBarCubit>().changeTab(index),
                  );
                },
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _tabs
                      .map((tab) => Center(child: Text('$tab Recipes')))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
