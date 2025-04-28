import 'package:green_plate/core/constants/keys/keys.dart';
import 'package:green_plate/core/service/local_data_service.dart';

abstract interface class LoginCheckLocalDataSource {
  Future<bool> checkLoginStatus();
}

class LoginCheckLocalDataSourceImpl implements LoginCheckLocalDataSource {
  final LocalDataService localDataService;

  LoginCheckLocalDataSourceImpl(this.localDataService);

  @override
  Future<bool> checkLoginStatus() async {
    try {
      final res = await localDataService.getBool(Keys.loginStatus);
      return res ?? false;
    } catch (e) {
      return false;
    }
  }
}
