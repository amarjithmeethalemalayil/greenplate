import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/auth/domain/entity/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, UserEntity>> signUp(
    String name,
    String email,
    String password,
  );
  Future<void> saveUserDataAndStatus(UserEntity userentity);
}
