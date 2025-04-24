import 'package:flutter/material.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class RecipeSearchTextfield extends StatelessWidget {
  const RecipeSearchTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:  BorderSide(color: MyColors.blackColor),
        ),
        prefixIcon: const Icon(Icons.search),
        hintText: "Search recipe",
      ),
    );
  }
}
