part of 'donation_bloc.dart';

@immutable
sealed class DonationEvent {}

class FetchLocationEvent extends DonationEvent {}

class DonateFood extends DonationEvent {
  final String? donatorId;
  final String mealType;
  final String foodName;
  final String pickupAddress;
  final int contactNumber;
  final double longitude;
  final double latitude;

  DonateFood({
    this.donatorId,
    required this.mealType,
    required this.foodName,
    required this.pickupAddress,
    required this.contactNumber,
    required this.longitude,
    required this.latitude,
  });
}

class GetDonations extends DonationEvent {}

class PressDonationComplete extends DonationEvent {
  final DonationEntity donationEntity;

  PressDonationComplete({
    required this.donationEntity,
  });
}
