import 'package:flutter/material.dart';
import 'package:green_plate/core/constants/assets/asset_helper.dart';
import 'package:green_plate/core/widgets/common_app_bar.dart';
import 'package:green_plate/core/widgets/recipe_box.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Favourite"),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: 4,
        itemBuilder: (context, index) => RecipeBox(
          recipeName: "Noodle",
          imagePath: AssetHelper.homeBannerImage,
          time: "10",
          isSaved: true,
        ),
      ),
    );
  }
}
