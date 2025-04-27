import 'package:flutter/material.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';
import 'package:green_plate/core/widgets/common_app_bar.dart';

class RecipeDetailPageAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isSaved;
  final Function()? onTap;

  const RecipeDetailPageAppbar({
    super.key,
    this.onTap,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: 'Recipe Details',
      actions: [
        IconButton(
          onPressed: onTap,
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_outline,
            color: MyColors.blackColor,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
