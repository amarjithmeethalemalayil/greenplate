import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';
import 'package:green_plate/features/bottom_nav/presentation/config/nav_items.dart';
import 'package:green_plate/features/bottom_nav/presentation/config/nav_screens.dart';
import 'package:green_plate/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        final controller = PersistentTabController(initialIndex: currentIndex);
        return PersistentTabView(
          context,
          controller: controller,
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
        );
      },
    );
  }
}
