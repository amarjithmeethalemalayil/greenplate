import 'package:fpdart/fpdart.dart';
import 'package:green_plate/core/error/failures.dart';
import 'package:green_plate/features/donate/domain/entity/donation_entity.dart';
import 'package:green_plate/features/donate/domain/repository/donation_repository.dart';

class DonateFoodToOthers {
  final DonationRepository repository;

  DonateFoodToOthers(this.repository);

  Future<Either<Failure, bool>> call(DonationEntity donation) async {
    return await repository.donateFood(donation);
  }
}
