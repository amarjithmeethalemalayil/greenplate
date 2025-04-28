import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/auth/domain/entity/user_entity.dart';
import 'package:green_plate/features/auth/domain/repository/auth_repository.dart';

class LogIn {
  final AuthRepository authRepository;
  LogIn(this.authRepository);

  Future<Either<Failure, UserEntity>> call(
    String email,
    String password,
  ) async {
    return await authRepository.signIn(email, password);
  }
}
