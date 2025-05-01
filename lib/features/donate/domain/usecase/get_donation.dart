import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/donate/domain/entity/donation_entity.dart';
import 'package:green_plate/features/donate/domain/entity/location_entity.dart';
import 'package:green_plate/features/donate/domain/repository/donation_repository.dart';

class GetDonation {
  final DonationRepository repository;

  GetDonation(this.repository);

  Future<Either<Failure, List<DonationEntity>>> call(
    LocationEntity location,
    String userId,
  ) async {
    return await repository.getDonation(location, userId);
  }
}
