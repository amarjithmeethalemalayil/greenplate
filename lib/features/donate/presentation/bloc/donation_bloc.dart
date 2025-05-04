import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/features/donate/domain/entity/donation_entity.dart';
import 'package:green_plate/features/donate/domain/entity/location_entity.dart';
import 'package:green_plate/features/donate/domain/usecase/donate_food_to_others.dart';
import 'package:green_plate/features/donate/domain/usecase/fetch_donator_name.dart';
import 'package:green_plate/features/donate/domain/usecase/fetch_location.dart';
import 'package:green_plate/features/donate/domain/usecase/fetch_userid.dart';
import 'package:green_plate/features/donate/domain/usecase/get_donation.dart';
import 'package:green_plate/features/donate/domain/usecase/donation_completed.dart';

part 'donation_event.dart';
part 'donation_state.dart';

class DonationBloc extends Bloc<DonationEvent, DonationState> {
  final FetchLocation fetchLocation;
  final DonateFoodToOthers donateFood;
  final FetchDonatorId fetchUserid;
  final GetDonation getDonation;
  final FetchDonatorName fetchDonatorName;
  final DonationCompleted donationCompleted;

  DonationBloc({
    required this.fetchLocation,
    required this.donateFood,
    required this.fetchUserid,
    required this.getDonation,
    required this.fetchDonatorName,
    required this.donationCompleted,
  }) : super(DonationInitial()) {
    on<FetchLocationEvent>(_onFetchLocation);
    on<DonateFood>(_onSubmitDonation);
    on<GetDonations>(_fetchDonations);
    on<PressDonationComplete>(_completeDonation);
  }

  Future<void> _onFetchLocation(
    FetchLocationEvent event,
    Emitter<DonationState> emit,
  ) async {
    emit(FetchingLocation());
    final result = await fetchLocation();
    result.fold(
      (failure) => emit(LocationError(failure.message)),
      (location) => emit(LocationFetched(
        isFetched: true,
        location: location,
      )),
    );
  }

  Future<void> _onSubmitDonation(
    DonateFood event,
    Emitter<DonationState> emit,
  ) async {
    emit(DonationLoading());
    final userIdResult = await fetchUserid();
    final userId = userIdResult.fold(
      (failure) => 'unknown',
      (id) => id,
    );
    final donatorNameResult = await fetchDonatorName(userId);
    final donatorName = donatorNameResult.fold(
      (failure) => 'unknown',
      (name) => name,
    );
    final donation = DonationEntity(
      donatorId: userId,
      donatorName: donatorName,
      mealType: event.mealType,
      foodName: event.foodName,
      pickupAddress: event.pickupAddress,
      contactNumber: event.contactNumber,
      longitude: event.longitude,
      latitude: event.latitude,
      donationCompleted: false,
    );
    final result = await donateFood(donation);
    result.fold(
      (failure) => emit(DonationError(failure.message)),
      (success) => emit(DonationSuccess(success)),
    );
  }

  Future<void> _fetchDonations(
    GetDonations event,
    Emitter<DonationState> emit,
  ) async {
    emit(DonationLoading());
    final userIdResult = await fetchUserid();
    final userId = userIdResult.fold(
      (failure) => 'unknown',
      (id) => id,
    );
    final locationResult = await fetchLocation();
    await locationResult.fold(
      (failure) async {
        emit(DonationFetchError(failure.message));
      },
      (location) async {
        final donationsResult = await getDonation(
          LocationEntity(
            latitude: location.latitude,
            longitude: location.longitude,
          ),
          userId,
        );
        donationsResult.fold(
          (failure) => emit(DonationFetchError(failure.message)),
          (donations) => emit(DonationFetched(donations)),
        );
      },
    );
  }

  Future<void> _completeDonation(
    PressDonationComplete event,
    Emitter<DonationState> emit,
  ) async {
    final userIdResult = await fetchUserid();
    final userId = userIdResult.fold(
      (failure) => 'unknown',
      (id) => id,
    );
    final locationResult = await fetchLocation();
    if (locationResult.isLeft()) {
      final failure = locationResult.fold((f) => f, (_) => null)!;
      emit(DonationFetchError(failure.message));
      return;
    }
    final success = locationResult.fold((_) => null, (s) => s)!;
    await donationCompleted(
      donation: event.donationEntity,
      currentLatitude: success.latitude,
      currentLongitude: success.longitude,
      currentUserId: userId,
    );

    emit(DonationRequested());
  }
}
