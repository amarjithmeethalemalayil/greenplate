import 'package:green_plate/core/constants/keys/keys.dart';
import 'package:green_plate/core/model/user_model.dart';
import 'package:green_plate/core/service/local_data_service.dart';

abstract interface class FetchNameLocalDatasource {
  Future<String> fetchUserName();
}

class FetchNameLocalDatasourceImpl implements FetchNameLocalDatasource {
  final LocalDataService localDataService;

  FetchNameLocalDatasourceImpl(this.localDataService);

  @override
  Future<String> fetchUserName() async {
    try {
      final res = await localDataService.getUserJson(Keys.saveUserData);
      if (res != null) {
        final user = UserModel.fromMap(res);
        return user.name;
      } else {
        return 'unknown';
      }
    } catch (e) {
      return 'unknown';
    }
  }
}
