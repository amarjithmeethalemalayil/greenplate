import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/donate/domain/repository/donation_repository.dart';

class FetchDonatorName {
  final DonationRepository repository;

  FetchDonatorName(this.repository);

  Future<Either<Failure, String>> call(String uid) async {
    return await repository.fetchUserName(uid);
  }
}
