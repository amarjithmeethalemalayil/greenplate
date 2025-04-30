import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_plate/features/donate/domain/entity/location_entity.dart';
import 'package:green_plate/features/donate/domain/usecase/fetch_location.dart';

part 'donation_event.dart';
part 'donation_state.dart';

class DonationBloc extends Bloc<DonationEvent, DonationState> {
  final FetchLocation fetchLocation;
  DonationBloc(this.fetchLocation) : super(DonationInitial()) {
    on<FetchLocationEvent>(_onFetchLocation);
  }
  Future<void> _onFetchLocation(
    FetchLocationEvent event,
    Emitter<DonationState> emit,
  ) async {
    emit(FetchingLocation());
    final result = await fetchLocation();
    result.fold(
      (failure) => emit(LocationError(failure.message)),
      (location) => emit(LoactionFetched(isFetched: true, location: location)),
    );
  }
}
