import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'donate_tabbar_state.dart';

class DonateTabbarCubit extends Cubit<DonateTabbarInitial> {
  DonateTabbarCubit() : super(DonateTabbarInitial(selectedIndex: 0));

  void changeTab(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
