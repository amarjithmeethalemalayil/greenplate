import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:green_plate/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:green_plate/features/auth/data/model/user_model.dart';
import 'package:green_plate/features/auth/domain/entity/user_entity.dart';
import 'package:green_plate/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this.authLocalDataSource);

  @override
  Future<Either<Failure, UserModel>> signIn(
    String email,
    String password,
  ) async {
    try {
      final userModel = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(userModel);
    } on WrongCredentialsException catch (e) {
      return Left(InvalidCredentialsFailure(e.message, e.stackTrace));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.stackTrace));
    } catch (e, stackTrace) {
      return Left(UnknownFailure(
        'Unexpected sign-in error: ${e.toString()}',
        stackTrace,
      ));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final userModel = await _remoteDataSource.signup(
        name: name,
        email: email,
        password: password,
      );
      return Right(userModel);
    } on EmailAlreadyInUseException catch (e) {
      return Left(EmailAlreadyInUseFailure(e.message, e.stackTrace));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.stackTrace));
    } catch (e, stackTrace) {
      return Left(UnknownFailure(
        'Unexpected sign-up error: ${e.toString()}',
        stackTrace,
      ));
    }
  }

  @override
  Future<void> saveUserDataAndStatus(UserEntity userentity) async {
    try {
      final userModel = UserModel(
        id: userentity.id,
        email: userentity.email,
        name: userentity.name,
      );
      await authLocalDataSource.saveUserDataAndStatus(userModel);
    } catch (e, stackTrace) {
      throw CacheException(
        'Failed to save user data locally: ${e.toString()}',
        stackTrace,
      );
    }
  }
}
