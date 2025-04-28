import 'package:green_plate/features/auth/domain/entity/user_entity.dart';
import 'package:green_plate/features/auth/domain/repository/auth_repository.dart';

class SaveUser {
  final AuthRepository authRepository;
  SaveUser(this.authRepository);
  Future<void> call(UserEntity userentity) async {
    return await authRepository.saveUserDataAndStatus(userentity);
  }
}
