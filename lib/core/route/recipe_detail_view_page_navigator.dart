import 'package:flutter/material.dart';

class RecipeDetailViewPageNavigator {
  static Future<void> navigateWithPopupAnimation(BuildContext context,Widget widget) async {
    await Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => widget,
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: ScaleTransition(
              scale: Tween(begin: 0.50, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.slowMiddle),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 250),
      ),
    );
  }
}


