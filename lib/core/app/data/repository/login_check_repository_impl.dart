import 'package:green_plate/core/app/data/datasource/login_check_local_data_source.dart';
import 'package:green_plate/core/app/domain/repository/login_check_repository.dart';

class LoginCheckRepositoryImpl implements LoginCheckRepository {
  final LoginCheckLocalDataSource loginCheckLocalDataSource;

  LoginCheckRepositoryImpl(this.loginCheckLocalDataSource);

  @override
  Future<bool> checkLoginStatus() async {
    try {
      final status = await loginCheckLocalDataSource.checkLoginStatus();
      return status;
    } catch (e) {
      return false;
    }
  }
}
