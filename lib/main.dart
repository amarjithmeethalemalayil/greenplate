import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/app/presentation/cubit/login_decision_cubit.dart';
import 'package:green_plate/core/route/app_router.dart';
import 'package:green_plate/dependency_injection.dart';
import 'package:green_plate/features/ai_recipe/presentation/bloc/ai_recipe_bloc.dart';
import 'package:green_plate/features/ai_recipe/presentation/cubit/ai_recipe_list_cubit.dart';
import 'package:green_plate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:green_plate/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:green_plate/features/donate/presentation/bloc/donation_bloc.dart';
import 'package:green_plate/features/donate/presentation/cubit/donate_tabbar_cubit.dart';
import 'package:green_plate/features/donate/presentation/cubit/meal_type_cubit.dart';
import 'package:green_plate/features/favourite/presentation/bloc/fav_recipes_bloc.dart';
import 'package:green_plate/features/home/presentation/bloc/recipe_bloc.dart';
import 'package:green_plate/features/home/presentation/cubit/tab_bar_cubit.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/bloc/detail_recipe_bloc.dart';
import 'package:green_plate/features/search_dish/presentation/bloc/search_recipe_bloc.dart';
import 'package:green_plate/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375.0, 812.0),
      minTextAdapt: true,
      builder: (context, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<TabBarCubit>()),
            BlocProvider(create: (_) => getIt<BottomNavCubit>()),
            BlocProvider(create: (_) => getIt<RecipeBloc>()),
            BlocProvider(create: (_) => getIt<DetailRecipeBloc>()),
            BlocProvider(create: (_) => getIt<SearchRecipeBloc>()),
            BlocProvider(create: (_) => getIt<AiRecipeBloc>()),
            BlocProvider(create: (_) => getIt<AiRecipeListCubit>()),
            BlocProvider(create: (_) => getIt<FavRecipesBloc>()),
            BlocProvider(create: (_) => getIt<AuthBloc>()),
            BlocProvider(create: (_) => getIt<LoginDecisionCubit>()),
            BlocProvider(create: (_) => getIt<DonateTabbarCubit>()),
            BlocProvider(create: (_) => getIt<MealTypeCubit>()),
            BlocProvider(create: (_) => getIt<DonationBloc>()),
          ],
          child: MaterialApp.router(
            title: 'Green Plate',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
              useMaterial3: true,
            ),
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
