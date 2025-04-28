import 'package:green_plate/core/constants/keys/keys.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/service/local_data_service.dart';
import 'package:green_plate/features/auth/data/model/user_model.dart';

abstract interface class AuthLocalDataSource {
  Future<void> saveUserDataAndStatus(UserModel userModel);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalDataService localDataService;

  AuthLocalDataSourceImpl(this.localDataService);

  @override
  Future<void> saveUserDataAndStatus(UserModel userModel) async {
    try {
      final userJson = userModel.toJson();
      await Future.wait([
        localDataService.saveBool(Keys.loginStatus, true),
        localDataService.saveUserJson(Keys.saveUserData, userJson),
      ]);
    } on FormatException catch (e, stackTrace) {
      throw CacheException(
        'Failed to serialize user data: ${e.message}',
        stackTrace,
      );
    } catch (e, stackTrace) {
      throw CacheException(
        'Failed to save user data: ${e.toString()}',
        stackTrace,
      );
    }
  }
}
