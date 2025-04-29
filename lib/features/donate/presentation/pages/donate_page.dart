import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/widgets/common_app_bar.dart';
import 'package:green_plate/features/donate/presentation/cubit/donate_tabbar_cubit.dart';
import 'package:green_plate/features/donate/presentation/pages/accept_donation_page.dart';
import 'package:green_plate/features/donate/presentation/pages/donation_page.dart';
import 'package:green_plate/features/donate/presentation/widget/custom_tabbar.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Donate"),
      body: BlocBuilder<DonateTabbarCubit, DonateTabbarState>(
        builder: (context, state) {
          if (state is DonateTabbarInitial) {
            return Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTabBar(
                      tabs: state.tabs,
                      selectedIndex: state.selectedIndex,
                      onTabChanged: (index) {
                        context.read<DonateTabbarCubit>().changeTab(index);
                      },
                    ),
                     SizedBox(height: 20.h),
                    IndexedStack(
                      index: state.selectedIndex,
                      children: [
                        DonationPage(),
                        AcceptDonationPage(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
