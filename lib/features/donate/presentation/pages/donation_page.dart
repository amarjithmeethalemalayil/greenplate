import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/utils/app_snackbar.dart';
import 'package:green_plate/features/donate/presentation/bloc/donation_bloc.dart';
import 'package:green_plate/features/donate/presentation/config/meal_type_list.dart';
import 'package:green_plate/features/donate/presentation/cubit/meal_type_cubit.dart';
import 'package:green_plate/features/donate/presentation/widget/donation_page_btn.dart';
import 'package:green_plate/features/donate/presentation/widget/donation_textfield.dart';
import 'package:green_plate/features/donate/presentation/widget/dot_selector.dart';
import 'package:green_plate/features/donate/presentation/widget/fetch_location_section.dart';
import 'package:green_plate/features/donate/presentation/widget/info_box.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final _formKey = GlobalKey<FormState>();
  final foodNameController = TextEditingController();
  final addressController = TextEditingController();
  final contactNumberController = TextEditingController();
  String mealType = "";
  double? longitude;
  double? latitude;

  @override
  void dispose() {
    foodNameController.dispose();
    addressController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }

  void _donateFood() {
    if (!_formKey.currentState!.validate()) return;
    if (longitude == null || latitude == null) {
      AppSnackbar.show(context, 'Please fetch your location first');
      return;
    }
    context.read<DonationBloc>().add(
          DonateFood(
            mealType: mealType,
            foodName: foodNameController.text.trim(),
            pickupAddress: addressController.text.trim(),
            contactNumber:
                int.tryParse(contactNumberController.text.trim()) ?? 0,
            longitude: longitude!,
            latitude: latitude!,
          ),
        );
  }

  donationCompleted() {
    foodNameController.clear();
    addressController.clear();
    contactNumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DonationBloc, DonationState>(
      listener: (context, state) {
        if (state is DonationError) {
          AppSnackbar.show(context, state.message);
        } else if (state is DonationSuccess) {
          AppSnackbar.show(context, 'Donation submitted successfully!');
          donationCompleted();
        } else if (state is LocationFetched) {
          longitude = state.location.longitude;
          latitude = state.location.latitude;
        }
      },
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const InfoBox(
                message: "You can only Donate food from your current location",
              ),
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
                controller: foodNameController,
                label: "Food name",
                hintText: "Name of the food",
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required field' : null,
              ),
              SizedBox(height: 6.h),
              DonationTextfield(
                controller: addressController,
                label: "Your pickup address",
                hintText: "Your pickup address",
                maxLine: 4,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required field' : null,
              ),
              SizedBox(height: 6.h),
              DonationTextfield(
                controller: contactNumberController,
                label: "Contact number",
                hintText: "Contact number",
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required field';
                  if (int.tryParse(value!) == null) return 'Enter valid number';
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              BlocBuilder<DonationBloc, DonationState>(
                builder: (context, state) {
                  if (state is FetchingLocation) {
                    return FetchLocationSection(
                      isFetched: false,
                      isLoading: true,
                    );
                  }
                  if (state is LocationFetched) {
                    return FetchLocationSection(isFetched: true);
                  }
                  return FetchLocationSection(
                    isFetched: false,
                    onPressedGetLocation: () {
                      context.read<DonationBloc>().add(FetchLocationEvent());
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
              BlocBuilder<DonationBloc, DonationState>(
                builder: (context, state) {
                  return DonationPageBtn(
                    buttonName: "Submit Donation",
                    onPressed: _donateFood,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
