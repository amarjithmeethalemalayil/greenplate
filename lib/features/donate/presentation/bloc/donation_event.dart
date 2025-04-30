part of 'donation_bloc.dart';

@immutable
sealed class DonationEvent {}

class FetchLocationEvent extends DonationEvent {}
