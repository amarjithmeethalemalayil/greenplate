part of 'donation_bloc.dart';

@immutable
sealed class DonationState {}

final class DonationInitial extends DonationState {}

final class FetchingLocation extends DonationState {}

final class LocationFetched extends DonationState {
  final bool isFetched;
  final LocationEntity location;

  LocationFetched({
    required this.isFetched,
    required this.location,
  });
}

final class LocationError extends DonationState {
  final String message;

  LocationError(this.message);
}

final class DonationLoading extends DonationState {}

final class DonationSuccess extends DonationState {
  final bool isDonated;
  DonationSuccess(this.isDonated);
}

final class DonationError extends DonationState {
  final String message;

  DonationError(this.message);
}

final class DonationFetched extends DonationState {
  final List<DonationEntity> donation;

  DonationFetched(this.donation);
}

final class DonationFetchError extends DonationState{
  final String message;

  DonationFetchError(this.message);
}
