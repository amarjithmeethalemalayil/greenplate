import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_plate/core/app/presentation/page/login_decision_page.dart';
import 'package:green_plate/features/auth/presentation/pages/login_page.dart';
import 'package:green_plate/features/auth/presentation/pages/signup_page.dart';
import 'package:green_plate/features/bottom_nav/presentation/pages/bottom_nav.dart';

class AppRouter {
  static const String decisionMaker = '/decision-maker';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String home = '/home';

  static const String loginRouteName = 'login';
  static const String signUpRouteName = 'sign-up';
  static const String decisionMakerRouteName = 'decision-maker';
  static const String homeRouteName = 'home';

  static final router = GoRouter(
    debugLogDiagnostics: true, 
    initialLocation: decisionMaker,
    routes: [
      GoRoute(
        path: decisionMaker,
        name: decisionMakerRouteName,
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const LoginDecisionPage(),
        ),
      ),

      GoRoute(
        path: login,
        name: loginRouteName,
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: signUp,
        name: signUpRouteName,
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const SignupPage(),
        ),
      ),
      GoRoute(
        path: home,
        name: homeRouteName,
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const BottomNav(),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Page not found: ${state.uri.path}',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    ),
  );

  static Page _buildPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}