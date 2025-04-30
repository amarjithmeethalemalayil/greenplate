import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/donate/domain/entity/location_entity.dart';
import 'package:green_plate/features/donate/domain/repository/donation_repository.dart';

class FetchLocation {
  final DonationRepository repository;

  FetchLocation(this.repository);

  Future<Either<Failure, LocationEntity>> call() async {
    return await repository.getCurrentLocation();
  }
}
