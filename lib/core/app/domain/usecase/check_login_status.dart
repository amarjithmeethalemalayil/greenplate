import 'package:green_plate/core/app/domain/repository/login_check_repository.dart';

class CheckLoginStatus {
  final LoginCheckRepository loginCheckRepository;

  CheckLoginStatus(this.loginCheckRepository);

  Future<bool> call() async {
    return await loginCheckRepository.checkLoginStatus();
  }
}
