import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/features/donate/presentation/bloc/donation_bloc.dart';
import 'package:green_plate/features/donate/presentation/config/meal_type_list.dart';
import 'package:green_plate/features/donate/presentation/widget/donation_page_btn.dart';
import 'package:green_plate/features/donate/presentation/widget/donation_textfield.dart';
import 'package:green_plate/features/donate/presentation/widget/dot_selector.dart';
import 'package:green_plate/features/donate/presentation/widget/fetch_location_section.dart';
import 'package:green_plate/features/donate/presentation/widget/info_box.dart';
import 'package:green_plate/features/donate/presentation/cubit/meal_type_cubit.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final foodNameController = TextEditingController();
  final locationController = TextEditingController();
  final contactNumberController = TextEditingController();
  String mealType = "";

  @override
  void dispose() {
    foodNameController.dispose();
    locationController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InfoBox(),
        SizedBox(height: 10.h),
        Text(
          "Select Meal Type",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        BlocBuilder<MealTypeCubit, MealTypeState>(
          builder: (context, state) {
            int selectedMealIndex = 0;
            if (state is MealTypeSelected) {
              selectedMealIndex = state.selectedMealIndex;
              mealType = MealTypeList.mealTypeList[selectedMealIndex];
              print(
                "selected food = $mealType",
              );
            }
            return DotSelector(
              itemCount: MealTypeList.mealTypeList.length,
              selectedIndex: selectedMealIndex,
              labels: MealTypeList.mealTypeList,
              onSelected: (index) {
                context.read<MealTypeCubit>().selectMealType(index);
              },
            );
          },
        ),
        SizedBox(height: 10.h),
        DonationTextfield(
          label: "Food name",
          hintText: "Name of the food",
        ),
        SizedBox(height: 6.h),
        DonationTextfield(
          label: "Your pickup address",
          hintText: "Your pickup address",
          maxLine: 4,
        ),
        SizedBox(height: 6.h),
        DonationTextfield(
          label: "Contact number",
          hintText: "Contact number",
        ),
        SizedBox(height: 10.h),
        BlocBuilder<DonationBloc, DonationState>(
          builder: (context, state) {
            if (state is LoactionFetched) {
              print("location longitude = ${state.location.longitude}");
              print("location latitude = ${state.location.latitude}");
              return FetchLocationSection(isFetched: state.isFetched);
            } if(state is FetchingLocation){
              return Center(child: CircularProgressIndicator(),);
            }
            return FetchLocationSection(
              isFetched: false,
              onPressedGetLocation: () {
                context.read<DonationBloc>().add(FetchLocationEvent());
              },
            );
          },
        ),
        SizedBox(height: 10.h),
        DonationPageBtn(
          buttonName: "Submit Donation",
        ),
      ],
    );
  }
}
