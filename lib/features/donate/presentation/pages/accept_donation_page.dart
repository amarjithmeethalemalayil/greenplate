import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/features/donate/presentation/bloc/donation_bloc.dart';
import 'package:green_plate/features/donate/presentation/widget/accept_donation_box.dart';
import 'package:green_plate/features/donate/presentation/widget/info_box.dart';

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
                  "You can only get Donations around 5km from your current Location",
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
                return Column(
                  children: List.generate(
                    state.donation.length,
                    (index) {
                      final donation = state.donation[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: AcceptDonationBox(
                          mealTypeName: donation.mealType,
                          donatorName: donation.donatorName,
                          nameOfTheFood: donation.foodName,
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
