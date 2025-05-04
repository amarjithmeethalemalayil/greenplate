import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/datasource/fetch_userid_local_datasource.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/donate/data/datasource/donation_remote_datasource.dart';
import 'package:green_plate/features/donate/data/model/donation_model.dart';
import 'package:green_plate/features/donate/data/model/location_model.dart';
import 'package:green_plate/features/donate/domain/entity/donation_entity.dart';
import 'package:green_plate/features/donate/domain/entity/location_entity.dart';
import 'package:green_plate/features/donate/domain/repository/donation_repository.dart';

class DonationRepositoryImpl implements DonationRepository {
  final DonationRemoteDatasource remoteDatasource;
  final FetchUseridLocalDatasource fetchUseridLocalDatasource;

  DonationRepositoryImpl({
    required this.remoteDatasource,
    required this.fetchUseridLocalDatasource,
  });

  @override
  Future<Either<Failure, LocationModel>> getCurrentLocation() async {
    try {
      final location = await remoteDatasource.getCurrentLocation();
      return Right(location);
    } on ServerException catch (e, stackTrace) {
      return Left(ServerFailure(e.message, stackTrace));
    } on AppException catch (e, stackTrace) {
      return Left(UnknownFailure(e.message, stackTrace));
    } catch (e, stackTrace) {
      return Left(UnknownFailure(
        'Unexpected error occurred while fetching location: ${e.toString()}',
        stackTrace,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> donateFood(DonationEntity donation) async {
    try {
      final newDonation = DonationModel.fromEntity(donation);
      final isSaved = await remoteDatasource.createDonation(newDonation);
      return right(isSaved);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> fetchUserId() async {
    try {
      final name = await fetchUseridLocalDatasource.fetchUserId();
      return right(name);
    } catch (e, st) {
      return left(UnknownFailure(e.toString(), st));
    }
  }

  @override
  Future<Either<Failure, List<DonationModel>>> getDonation(
    LocationEntity location,
    String userId,
  ) async {
    try {
      final locationModel = LocationModel(
        latitude: location.latitude,
        longitude: location.longitude,
      );
      final donations =
          await remoteDatasource.getDonation(locationModel, userId);
      return Right(donations);
    } on ServerException catch (e, stackTrace) {
      return Left(ServerFailure(e.message, stackTrace));
    } on AppException catch (e, stackTrace) {
      return Left(UnknownFailure(e.message, stackTrace));
    } catch (e, stackTrace) {
      return Left(UnknownFailure(
        'Unexpected error occurred while fetching donations: ${e.toString()}',
        stackTrace,
      ));
    }
  }

  @override
  Future<Either<Failure, String>> fetchUserName(String uid) async {
    try {
      final name = await remoteDatasource.fetchDonatorName(uid);
      return right(name);
    } on ServerException catch (e, stackTrace) {
      return left(ServerFailure(e.message, stackTrace));
    } on AppException catch (e, stackTrace) {
      return left(UnknownFailure(e.message, stackTrace));
    } catch (e, stackTrace) {
      return left(UnknownFailure(
        'Unexpected error occurred while fetching user name: ${e.toString()}',
        stackTrace,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> donationComplete(
    double currentLatitude,
    double currentLongitude,
    DonationEntity donation,
    String currentUserId,
  ) async {
    try {
      final donationModel = DonationModel.fromEntity(donation);
      await remoteDatasource.donationCompleted(
        currentLatitude,
        currentLongitude,
        donationModel,
        currentUserId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(UnknownFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
