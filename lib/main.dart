import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/environment/environments.dart';
import 'package:green_plate/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:green_plate/features/bottom_nav/presentation/pages/bottom_nav.dart';
import 'package:green_plate/features/home/data/datasources/recipe_remote_data_source.dart';
import 'package:green_plate/features/home/data/repository/recipe_repository_impl.dart';
import 'package:green_plate/features/home/domain/usecases/get_recipes.dart';
import 'package:green_plate/features/home/presentation/bloc/recipe_bloc.dart';
import 'package:green_plate/features/home/presentation/cubit/tab_bar_cubit.dart';
import 'package:green_plate/features/recipe_detail_view/data/datasources/detail_recipe_remote_data_source.dart';
import 'package:green_plate/features/recipe_detail_view/data/repository/fetch_detail_recipe_repository_impl.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/get_datail_recipe.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/bloc/detail_recipe_bloc.dart';
import 'package:green_plate/features/search_dish/data/datasource/search_remote_data_source.dart';
import 'package:green_plate/features/search_dish/data/repository/search_recipe_repository_impl.dart';
import 'package:green_plate/features/search_dish/domain/usecase/search_dish.dart';
import 'package:green_plate/features/search_dish/presentation/bloc/search_recipe_bloc.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final client = http.Client();
    final apiKey = dotenv.env['APIKEY'];
    return ScreenUtilInit(
      designSize: const Size(375.0, 812.0),
      minTextAdapt: true,
      builder: (context, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => TabBarCubit()),
            BlocProvider(create: (_) => BottomNavCubit()),
            BlocProvider(
              create: (_) => RecipeBloc(
                getRecipes: GetRecipes(
                  RecipeRepositoryImpl(
                    RecipeRemoteDataSourceImpl(
                      client: client,
                      baseUrl: Environments.baseUrl,
                      apiKey: apiKey!,
                    ),
                  ),
                ),
              ),
            ),
            BlocProvider(
              create: (_) => DetailRecipeBloc(
                GetDatailRecipe(
                  FetchDetailRecipeRepositoryImpl(
                    DetailRecipeRemoteDataSourceImpl(
                      client: client,
                      baseUrl: Environments.baseUrl,
                      apiKey: apiKey!,
                    ),
                  ),
                ),
              ),
            ),
            BlocProvider(
              create: (_) => SearchRecipeBloc(
                searchDish: SearchDish(
                  SearchRecipeRepositoryImpl(
                    SearchRemoteDataSourceImpl(
                      client: client,
                      baseUrl: Environments.baseUrl,
                      apiKey: apiKey!,
                    ),
                  ),
                ),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Green Plate',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
              useMaterial3: true,
            ),
            home: BottomNav(),
          ),
        );
      },
    );
  }
}
