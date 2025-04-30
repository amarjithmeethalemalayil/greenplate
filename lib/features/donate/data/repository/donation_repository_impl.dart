import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/donate/data/datasource/donation_remote_datasource.dart';
import 'package:green_plate/features/donate/data/model/location_model.dart';
import 'package:green_plate/features/donate/domain/repository/donation_repository.dart';

class DonationRepositoryImpl implements DonationRepository {
  final DonationRemoteDatasource remoteDatasource;

  DonationRepositoryImpl({required this.remoteDatasource});

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
}
