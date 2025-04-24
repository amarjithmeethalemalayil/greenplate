import 'package:flutter/material.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

abstract class NavBarItems {
  static List<PersistentBottomNavBarItem> get items => [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home),
      title: "Home",
      activeColorPrimary: MyColors.primaryColor,
      activeColorSecondary: MyColors.whiteColor,
      inactiveColorPrimary: MyColors.highLightTextColor,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.favorite_border),
      title: "Favourite",
      activeColorPrimary: MyColors.primaryColor,
      activeColorSecondary:MyColors.whiteColor,
      inactiveColorPrimary: MyColors.highLightTextColor,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.smart_toy),
      title: "AI Recipe",
      activeColorPrimary: MyColors.primaryColor,
      activeColorSecondary: MyColors.whiteColor,
      inactiveColorPrimary: MyColors.highLightTextColor,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.volunteer_activism),
      title: "Donate",
      activeColorPrimary:MyColors.primaryColor,
      activeColorSecondary: MyColors.whiteColor,
      inactiveColorPrimary: MyColors.highLightTextColor,
    ),
  ];
}
