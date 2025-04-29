import 'package:green_plate/core/constants/keys/keys.dart';
import 'package:green_plate/core/model/user_model.dart';
import 'package:green_plate/core/service/local_data_service.dart';

abstract interface class FetchUseridLocalDatasource {
  Future<String> fetchUserId();
}

class FetchUseridLocalDatasourceImpl implements FetchUseridLocalDatasource {
  final LocalDataService localDataService;

  FetchUseridLocalDatasourceImpl(this.localDataService);
  @override
  Future<String> fetchUserId() async {
    try {
      final res = await localDataService.getUserJson(Keys.saveUserData);
      if (res != null) {
        final user = UserModel.fromMap(res);
        return user.id;
      } else {
        return 'unknown';
      }
    } catch (e) {
      return 'unknown';
    }
  }
}
