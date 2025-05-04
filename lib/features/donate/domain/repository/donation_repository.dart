import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/donate/domain/entity/donation_entity.dart';
import 'package:green_plate/features/donate/domain/entity/location_entity.dart';

abstract class DonationRepository {
  Future<Either<Failure, LocationEntity>> getCurrentLocation();
  Future<Either<Failure, bool>> donateFood(DonationEntity donation);
  Future<Either<Failure, String>> fetchUserId();
  Future<Either<Failure, List<DonationEntity>>> getDonation(
    LocationEntity location,
    String userId,
  );
  Future<Either<Failure, String>> fetchUserName(String uid);
  Future<Either<Failure, void>> donationComplete(
    double currentLatitude,
    double currentLongitude,
    DonationEntity donation,
    String currentUserId,
  );
}
