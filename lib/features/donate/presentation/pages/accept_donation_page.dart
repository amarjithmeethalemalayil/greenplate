import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/utils/app_snackbar.dart';
import 'package:green_plate/features/donate/presentation/bloc/donation_bloc.dart';
import 'package:green_plate/features/donate/presentation/widget/accept_donation_box.dart';
import 'package:green_plate/features/donate/presentation/widget/info_box.dart';
import 'package:green_plate/features/donate/presentation/widget/show_dialouge.dart';

class AcceptDonationPage extends StatelessWidget {
  const AcceptDonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DonationBloc>().add(GetDonations());
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: InfoBox(
              message:
                  "You can only view donations within a 5 km radius of your current location.\n Please be responsive if you express interest, make sure to collect the food.",
            ),
          ),
          SizedBox(height: 10.h),
          BlocBuilder<DonationBloc, DonationState>(
            builder: (context, state) {
              if (state is DonationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DonationFetchError) {
                return Text(state.message);
              } else if (state is DonationFetched) {
                if (state.donation.isEmpty) {
                  return Center(
                    child:
                        Text("There are no donations available at the moment."),
                  );
                } else {
                  return Column(
                    children: List.generate(
                      state.donation.length,
                      (index) {
                        final donation = state.donation[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: BlocListener<DonationBloc, DonationState>(
                            listener: (context, state) {
                              if (state is DonationFetchError) {
                                AppSnackbar.show(context, state.message);
                              } else if (state is DonationRequested) {
                                AppSnackbar.show(context, 'Donation requested');
                              }
                            },
                            child: AcceptDonationBox(
                              mealTypeName: donation.mealType,
                              donatorName: donation.donatorName,
                              nameOfTheFood: donation.foodName,
                              viewMorePressed: () {
                                showDonationDetailBottomSheet(
                                  context: context,
                                  donatorName: donation.donatorName,
                                  mealType: donation.mealType,
                                  foodName: donation.foodName,
                                  contactNumber: donation.contactNumber.toString(),
                                  pickupAddress: donation.pickupAddress,
                                );
                              },
                              onPressedIntrest: () {
                                context.read<DonationBloc>().add(
                                      PressDonationComplete(
                                        donationEntity: donation,
                                      ),
                                    );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

