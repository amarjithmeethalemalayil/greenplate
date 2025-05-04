import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:green_plate/core/app/data/datasource/login_check_local_data_source.dart';
import 'package:green_plate/core/app/data/repository/login_check_repository_impl.dart';
import 'package:green_plate/core/app/domain/repository/login_check_repository.dart';
import 'package:green_plate/core/app/domain/usecase/check_login_status.dart';
import 'package:green_plate/core/app/presentation/cubit/login_decision_cubit.dart';
import 'package:green_plate/core/constants/environment/environments.dart';
import 'package:green_plate/core/service/local_data_service.dart';
import 'package:green_plate/features/ai_recipe/data/datasource/ai_recipe_generator_remote_data_source.dart';
import 'package:green_plate/features/ai_recipe/data/repository/ai_recipe_repository_impl.dart';
import 'package:green_plate/features/ai_recipe/domain/repository/ai_recipe_repository.dart';
import 'package:green_plate/features/ai_recipe/domain/usecase/get_ai_recipe.dart';
import 'package:green_plate/features/ai_recipe/presentation/bloc/ai_recipe_bloc.dart';
import 'package:green_plate/features/ai_recipe/presentation/cubit/ai_recipe_list_cubit.dart';
import 'package:green_plate/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:green_plate/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:green_plate/features/auth/data/repository/auth_repository_impl.dart';
import 'package:green_plate/features/auth/domain/repository/auth_repository.dart';
import 'package:green_plate/features/auth/domain/usecases/log_in.dart';
import 'package:green_plate/features/auth/domain/usecases/save_user.dart';
import 'package:green_plate/features/auth/domain/usecases/sign_up.dart';
import 'package:green_plate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:green_plate/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:green_plate/features/donate/data/datasource/donation_remote_datasource.dart';
import 'package:green_plate/features/donate/data/repository/donation_repository_impl.dart';
import 'package:green_plate/features/donate/domain/repository/donation_repository.dart';
import 'package:green_plate/features/donate/domain/usecase/donate_food_to_others.dart';
import 'package:green_plate/features/donate/domain/usecase/donation_completed.dart';
import 'package:green_plate/features/donate/domain/usecase/fetch_donator_name.dart';
import 'package:green_plate/features/donate/domain/usecase/fetch_location.dart';
import 'package:green_plate/features/donate/domain/usecase/fetch_userid.dart';
import 'package:green_plate/features/donate/domain/usecase/get_donation.dart';
import 'package:green_plate/features/donate/presentation/bloc/donation_bloc.dart';
import 'package:green_plate/features/donate/presentation/cubit/donate_tabbar_cubit.dart';
import 'package:green_plate/features/donate/presentation/cubit/meal_type_cubit.dart';
import 'package:green_plate/features/favourite/data/datasource/fetch_fav_recipes_remote_data_source.dart';
import 'package:green_plate/features/favourite/data/repository/fetch_fav_recipes_repository_impl.dart';
import 'package:green_plate/features/favourite/domain/repository/fetch_fav_recipes_repository.dart';
import 'package:green_plate/features/favourite/domain/usecase/delete_fav_recipe.dart';
import 'package:green_plate/features/favourite/domain/usecase/fetch_current_userid.dart';
import 'package:green_plate/features/favourite/domain/usecase/fetch_fav_recipes.dart';
import 'package:green_plate/features/favourite/presentation/bloc/fav_recipes_bloc.dart';
import 'package:green_plate/features/home/data/datasources/fetch_name_local_datasource.dart';
import 'package:green_plate/features/home/data/datasources/recipe_remote_data_source.dart';
import 'package:green_plate/features/home/data/repository/recipe_repository_impl.dart';
import 'package:green_plate/features/home/domain/repository/recipe_repository.dart';
import 'package:green_plate/features/home/domain/usecases/fetch_name.dart';
import 'package:green_plate/features/home/domain/usecases/get_recipes.dart';
import 'package:green_plate/features/home/presentation/bloc/recipe_bloc.dart';
import 'package:green_plate/features/home/presentation/cubit/tab_bar_cubit.dart';
import 'package:green_plate/features/recipe_detail_view/data/datasources/detail_recipe_remote_data_source.dart';
import 'package:green_plate/features/recipe_detail_view/data/repository/fetch_detail_recipe_repository_impl.dart';
import 'package:green_plate/features/recipe_detail_view/domain/repository/fetch_detail_recipe_repository.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/fetch_userid.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/get_datail_recipe.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/is_saved_in_firebase.dart';
import 'package:green_plate/features/recipe_detail_view/domain/usecase/save_recipe.dart';
import 'package:green_plate/features/recipe_detail_view/presentation/bloc/detail_recipe_bloc.dart';
import 'package:green_plate/features/search_dish/data/datasource/search_remote_data_source.dart';
import 'package:green_plate/features/search_dish/data/repository/search_recipe_repository_impl.dart';
import 'package:green_plate/features/search_dish/domain/repository/search_recipe_repository.dart';
import 'package:green_plate/features/search_dish/domain/usecase/search_dish.dart';
import 'package:green_plate/features/search_dish/presentation/bloc/search_recipe_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final location = Location();
  final client = http.Client();

  getIt.registerLazySingleton(() => firebaseAuth);
  getIt.registerLazySingleton(() => firestore);
  getIt.registerLazySingleton(() => location);
  getIt.registerLazySingleton(() => client);
  getIt.registerLazySingleton(() => LocalDataService());

  await dotenv.load(fileName: ".env");
  final apiKey = dotenv.env['APIKEY']!;
  getIt.registerLazySingleton(() => apiKey);

  _initAuthDependencies();
  _initRecipeDependencies();
  _initAIDependencies();
  _initDonationDependencies();
  _initFavoritesDependencies();
  _initSearchDependencies();
  _initDetailRecipeDependencies();
  _initLoginDecisionDependencies();

  getIt.registerFactory(() => TabBarCubit());
  getIt.registerFactory(() => BottomNavCubit());
  getIt.registerFactory(() => DonateTabbarCubit());
  getIt.registerFactory(() => MealTypeCubit());
  getIt.registerFactory(() => AiRecipeListCubit());
}

void _initAuthDependencies() {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => LogIn(getIt()));
  getIt.registerLazySingleton(() => SignUp(getIt()));
  getIt.registerLazySingleton(() => SaveUser(getIt()));
  getIt.registerFactory(
      () => AuthBloc(logIn: getIt(), signUp: getIt(), saveUser: getIt()));
}

void _initRecipeDependencies() {
  getIt.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(
      client: getIt(),
      baseUrl: Environments.baseUrl,
      apiKey: getIt(),
    ),
  );
  getIt.registerLazySingleton<FetchNameLocalDatasource>(
    () => FetchNameLocalDatasourceImpl(getIt()),
  );
  getIt.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => GetRecipes(getIt()));
  getIt.registerLazySingleton(() => FetchName(getIt()));
  getIt.registerFactory(
      () => RecipeBloc(getRecipes: getIt(), fetchName: getIt()));
}

void _initAIDependencies() {
  getIt.registerLazySingleton<AiRecipeGeneratorRemoteDataSource>(
    () => AiRecipeGeneratorRemoteDataSourceImpl(
      client: getIt(),
      baseUrl: Environments.baseUrl,
      apiKey: getIt(),
    ),
  );
  getIt.registerLazySingleton<AiRecipeRepository>(
    () => AiRecipeRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => GetAiRecipe(getIt()));
  getIt.registerFactory(() => AiRecipeBloc(getIt()));
}

void _initDonationDependencies() {
  getIt.registerLazySingleton<DonationRemoteDatasource>(
    () => DonationRemoteDatasourceImpl(
      location: getIt(),
      db: getIt(),
      auth: getIt(),
    ),
  );
  getIt.registerLazySingleton<DonationRepository>(
    () => DonationRepositoryImpl(
      remoteDatasource: getIt(),
      fetchUseridLocalDatasource: getIt(),
    ),
  );
  getIt.registerLazySingleton(() => FetchLocation(getIt()));
  getIt.registerLazySingleton(() => DonateFoodToOthers(getIt()));
  getIt.registerLazySingleton(() => FetchDonatorId(getIt()));
  getIt.registerLazySingleton(() => GetDonation(getIt()));
  getIt.registerLazySingleton(() => FetchDonatorName(getIt()));
  getIt.registerLazySingleton(() => DonationCompleted(getIt()));
  getIt.registerFactory(
    () => DonationBloc(
      fetchLocation: getIt(),
      donateFood: getIt(),
      fetchUserid: getIt(),
      getDonation: getIt(),
      fetchDonatorName: getIt(),
      donationCompleted: getIt(),
    ),
  );
}

void _initFavoritesDependencies() {
  getIt.registerLazySingleton<FetchFavRecipesRemoteDataSource>(
    () => FetchFavRecipesRemoteDataSourceImpl(
      db: getIt(),
      auth: getIt(),
    ),
  );
  getIt.registerLazySingleton<FetchFavRecipesRepository>(
    () => FetchFavRecipesRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => FetchFavRecipes(getIt()));
  getIt.registerLazySingleton(() => DeleteFavRecipe(getIt()));
  getIt.registerLazySingleton(() => FetchCurrentUserid(getIt()));
  getIt.registerFactory(() => FavRecipesBloc(getIt(), getIt(), getIt()));
}

void _initSearchDependencies() {
  getIt.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(
      client: getIt(),
      baseUrl: Environments.baseUrl,
      apiKey: getIt(),
    ),
  );
  getIt.registerLazySingleton<SearchRecipeRepository>(
    () => SearchRecipeRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => SearchDish(getIt()));
  getIt.registerFactory(() => SearchRecipeBloc(searchDish: getIt()));
}

void _initDetailRecipeDependencies() {
  getIt.registerLazySingleton<DetailRecipeRemoteDataSource>(
    () => DetailRecipeRemoteDataSourceImpl(
      client: getIt(),
      baseUrl: Environments.baseUrl,
      apiKey: getIt(),
      db: getIt(),
      auth: getIt(),
    ),
  );
  getIt.registerLazySingleton<FetchDetailRecipeRepository>(
    () => FetchDetailRecipeRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => GetDatailRecipe(getIt()));
  getIt.registerLazySingleton(() => SaveRecipe(getIt()));
  getIt.registerLazySingleton(() => IsSavedInFirebase(getIt()));
  getIt.registerLazySingleton(() => FetchUserId(getIt()));
  getIt.registerFactory(
    () => DetailRecipeBloc(getIt(), getIt(), getIt(), getIt()),
  );
}

void _initLoginDecisionDependencies() {
  getIt.registerLazySingleton<LoginCheckLocalDataSource>(
    () => LoginCheckLocalDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<LoginCheckRepository>(
    () => LoginCheckRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => CheckLoginStatus(getIt()));
  getIt.registerFactory(() => LoginDecisionCubit(getIt()));
}
