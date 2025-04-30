part of 'donation_bloc.dart';

@immutable
sealed class DonationState {}

final class DonationInitial extends DonationState {}

final class FetchingLocation extends DonationState{}

final class LoactionFetched extends DonationState {
  final bool isFetched;
  final LocationEntity location;

  LoactionFetched({
    required this.isFetched,
    required this.location,
  });
}

final class LocationError extends DonationState {
  final String message;

  LocationError(this.message);
}
