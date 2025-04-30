import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/donate/domain/entity/location_entity.dart';

abstract class DonationRepository {
  Future<Either<Failure, LocationEntity>> getCurrentLocation();
}
