import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/app/data/datasource/login_check_local_data_source.dart';
import 'package:green_plate/core/app/data/repository/login_check_repository_impl.dart';
import 'package:green_plate/core/app/domain/usecase/check_login_status.dart';
import 'package:green_plate/core/app/presentation/cubit/login_decision_cubit.dart';
import 'package:green_plate/core/app/presentation/page/login_decision_page.dart';
import 'package:green_plate/core/constants/environment/environments.dart';
import 'package:green_plate/core/service/local_data_service.dart';
import 'package:green_plate/features/ai_recipe/data/datasource/ai_recipe_generator_remote_data_source.dart';
import 'package:green_plate/features/ai_recipe/data/repository/ai_recipe_repository_impl.dart';
import 'package:green_plate/features/ai_recipe/domain/usecase/get_ai_recipe.dart';
import 'package:green_plate/features/ai_recipe/presentation/bloc/ai_recipe_bloc.dart';
import 'package:green_plate/features/ai_recipe/presentation/cubit/ai_recipe_list_cubit.dart';
import 'package:green_plate/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:green_plate/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:green_plate/features/auth/data/repository/auth_repository_impl.dart';
import 'package:green_plate/features/auth/domain/usecases/log_in.dart';
import 'package:green_plate/features/auth/domain/usecases/save_user.dart';
import 'package:green_plate/features/auth/domain/usecases/sign_up.dart';
import 'package:green_plate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:green_plate/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:green_plate/features/donate/data/datasource/donation_remote_datasource.dart';
import 'package:green_plate/features/donate/data/repository/donation_repository_impl.dart';
import 'package:green_plate/features/donate/domain/usecase/fetch_location.dart';
import 'package:green_plate/features/donate/presentation/bloc/donation_bloc.dart';
import 'package:green_plate/features/donate/presentation/cubit/donate_tabbar_cubit.dart';
import 'package:green_plate/features/donate/presentation/cubit/meal_type_cubit.dart';
import 'package:green_plate/features/favourite/data/datasource/fetch_fav_recipes_remote_data_source.dart';
import 'package:green_plate/features/favourite/data/repository/fetch_fav_recipes_repository_impl.dart';
import 'package:green_plate/features/favourite/domain/usecase/delete_fav_recipe.dart';
import 'package:green_plate/features/favourite/domain/usecase/fetch_current_userid.dart';
import 'package:green_plate/features/favourite/domain/usecase/fetch_fav_recipes.dart';
import 'package:green_plate/features/favourite/presentation/bloc/fav_recipes_bloc.dart';
import 'package:green_plate/features/home/data/datasources/fetch_name_local_datasource.dart';
import 'package:green_plate/features/home/data/datasources/recipe_remote_data_source.dart';
import 'package:green_plate/features/home/data/repository/recipe_repository_impl.dart';
import 'package:green_plate/features/home/domain/usecases/fetch_name.dart';
import 'package:green_plate/features/home/domain/usecases/get_recipes.dart';
import 'package:green_plate/features/home/presentation/bloc/recipe_bloc.dart';
import 'package:green_plate/features/home/presentation/cubit/tab_bar_cubit.dart';
import 'package:green_plate/features/recipe_detail_view/data/datasources/detail_recipe_remote_data_source.dart';
import 'package:green_plate/core/datasource/fetch_userid_local_datasource.dart';
import 'package:green_plate/features/recipe_detail_view/data/repository/fetch_detail_recipe_repository_impl.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/fetch_userid.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/get_datail_recipe.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/is_saved_in_firebase.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/save_recipe.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/bloc/detail_recipe_bloc.dart';
import 'package:green_plate/features/search_dish/data/datasource/search_remote_data_source.dart';
import 'package:green_plate/features/search_dish/data/repository/search_recipe_repository_impl.dart';
import 'package:green_plate/features/search_dish/domain/usecase/search_dish.dart';
import 'package:green_plate/features/search_dish/presentation/bloc/search_recipe_bloc.dart';
import 'package:green_plate/firebase_options.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final client = http.Client();
    final apiKey = dotenv.env['APIKEY'];
    final db = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
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
                    FetchNameLocalDatasourceImpl(
                      LocalDataService(),
                    ),
                  ),
                ),
                fetchName: FetchName(
                  RecipeRepositoryImpl(
                    RecipeRemoteDataSourceImpl(
                      client: client,
                      baseUrl: Environments.baseUrl,
                      apiKey: apiKey,
                    ),
                    FetchNameLocalDatasourceImpl(
                      LocalDataService(),
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
                      db: db,
                      auth: auth,
                    ),
                    FetchUseridLocalDatasourceImpl(
                      LocalDataService(),
                    ),
                  ),
                ),
                SaveRecipe(
                  FetchDetailRecipeRepositoryImpl(
                    DetailRecipeRemoteDataSourceImpl(
                      client: client,
                      baseUrl: Environments.baseUrl,
                      apiKey: apiKey,
                      db: db,
                      auth: auth,
                    ),
                    FetchUseridLocalDatasourceImpl(
                      LocalDataService(),
                    ),
                  ),
                ),
                IsSavedInFirebase(
                  FetchDetailRecipeRepositoryImpl(
                    DetailRecipeRemoteDataSourceImpl(
                      client: client,
                      baseUrl: Environments.baseUrl,
                      apiKey: apiKey,
                      db: db,
                      auth: auth,
                    ),
                    FetchUseridLocalDatasourceImpl(
                      LocalDataService(),
                    ),
                  ),
                ),
                FetchUserId(
                  FetchDetailRecipeRepositoryImpl(
                    DetailRecipeRemoteDataSourceImpl(
                      client: client,
                      baseUrl: Environments.baseUrl,
                      apiKey: apiKey,
                      db: db,
                      auth: auth,
                    ),
                    FetchUseridLocalDatasourceImpl(
                      LocalDataService(),
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
            BlocProvider(create: (context) => AiRecipeListCubit()),
            BlocProvider(
              create: (context) => AiRecipeBloc(
                GetAiRecipe(
                  AiRecipeRepositoryImpl(
                    AiRecipeGeneratorRemoteDataSourceImpl(
                      client: client,
                      baseUrl: Environments.baseUrl,
                      apiKey: apiKey!,
                    ),
                  ),
                ),
              ),
            ),
            BlocProvider(
              create: (context) => FavRecipesBloc(
                FetchFavRecipes(
                  FetchFavRecipesRepositoryImpl(
                    FetchFavRecipesRemoteDataSourceImpl(
                      db: db,
                      auth: auth,
                    ),
                    FetchUseridLocalDatasourceImpl(
                      LocalDataService(),
                    ),
                  ),
                ),
                DeleteFavRecipe(
                  FetchFavRecipesRepositoryImpl(
                    FetchFavRecipesRemoteDataSourceImpl(
                      db: db,
                      auth: auth,
                    ),
                    FetchUseridLocalDatasourceImpl(
                      LocalDataService(),
                    ),
                  ),
                ),
                FetchCurrentUserid(
                  FetchFavRecipesRepositoryImpl(
                    FetchFavRecipesRemoteDataSourceImpl(
                      db: db,
                      auth: auth,
                    ),
                    FetchUseridLocalDatasourceImpl(
                      LocalDataService(),
                    ),
                  ),
                ),
              ),
            ),
            BlocProvider(
              create: (context) => AuthBloc(
                logIn: LogIn(
                  AuthRepositoryImpl(
                    AuthRemoteDataSourceImpl(auth, db),
                    AuthLocalDataSourceImpl(LocalDataService()),
                  ),
                ),
                signUp: SignUp(
                  AuthRepositoryImpl(
                    AuthRemoteDataSourceImpl(auth, db),
                    AuthLocalDataSourceImpl(LocalDataService()),
                  ),
                ),
                saveUser: SaveUser(
                  AuthRepositoryImpl(
                    AuthRemoteDataSourceImpl(auth, db),
                    AuthLocalDataSourceImpl(LocalDataService()),
                  ),
                ),
              ),
            ),
            BlocProvider(
              create: (context) => LoginDecisionCubit(
                CheckLoginStatus(
                  LoginCheckRepositoryImpl(
                    LoginCheckLocalDataSourceImpl(
                      LocalDataService(),
                    ),
                  ),
                ),
              ),
            ),
            BlocProvider(create: (context) => DonateTabbarCubit()),
            BlocProvider(create: (context) => MealTypeCubit()),
            BlocProvider(
              create: (context) => DonationBloc(
                FetchLocation(
                  DonationRepositoryImpl(
                    remoteDatasource: DonationRemoteDatasourceImpl(
                      Location(),
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
            home: LoginDecisionPage(),
          ),
        );
      },
    );
  }
}
