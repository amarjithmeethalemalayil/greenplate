import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/donate/domain/repository/donation_repository.dart';

class FetchDonatorId {
  final DonationRepository repository;

  FetchDonatorId(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.fetchUserId();
  }
}
