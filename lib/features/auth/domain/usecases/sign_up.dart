import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/core/entity/user_entity.dart';
import 'package:green_plate/features/auth/domain/repository/auth_repository.dart';

class SignUp {
  final AuthRepository authRepository;
  SignUp(this.authRepository);

  Future<Either<Failure, UserEntity>> call(
    String name,
    String email,
    String password,
  ) async {
    return await authRepository.signUp(name, email, password);
  }
}
