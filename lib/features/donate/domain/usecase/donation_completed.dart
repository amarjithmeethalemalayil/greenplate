import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/donate/domain/entity/donation_entity.dart';
import 'package:green_plate/features/donate/domain/repository/donation_repository.dart';

class DonationCompleted {
  final DonationRepository repository;

  DonationCompleted(this.repository);

  Future<Either<Failure, void>> call({
    required double currentLatitude,
    required double currentLongitude,
    required DonationEntity donation,
    required String currentUserId,
  }) async {
    return await repository.donationComplete(
      currentLatitude,
      currentLongitude,
      donation,
      currentUserId,
    );
  }
}
