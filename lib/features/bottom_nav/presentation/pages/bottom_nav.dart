import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';
import 'package:green_plate/features/bottom_nav/presentation/config/nav_items.dart';
import 'package:green_plate/features/bottom_nav/presentation/config/nav_screens.dart';
import 'package:green_plate/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late final PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    final currentIndex = context.read<BottomNavCubit>().state;
    _controller = PersistentTabController(initialIndex: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomNavCubit, int>(
      listener: (context, currentIndex) {
        _controller.jumpToTab(currentIndex);
      },
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: NavScreens.screens,
        items: NavBarItems.items,
        backgroundColor: MyColors.whiteColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarStyle: NavBarStyle.style7,
        onItemSelected: (index) {
          context.read<BottomNavCubit>().updateIndex(index);
        },
      ),
    );
  }
}
