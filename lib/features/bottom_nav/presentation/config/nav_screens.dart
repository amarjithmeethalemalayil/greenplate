import 'package:flutter/material.dart';
import 'package:green_plate/features/ai_recipe/presentation/pages/ai_recipe_page.dart';
import 'package:green_plate/features/donate/presentation/pages/donate_page.dart';
import 'package:green_plate/features/favourite/presentation/pages/favourite_page.dart';
import 'package:green_plate/features/home/presentation/pages/home_page.dart';

abstract class NavScreens {
  static List<Widget> get screens => const [
    HomePage(),
    FavouritePage(),
    AiRecipePage(),
    DonatePage(),
  ];
}
