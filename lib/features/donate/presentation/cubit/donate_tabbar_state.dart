part of 'donate_tabbar_cubit.dart';

@immutable
sealed class DonateTabbarState {}

class DonateTabbarInitial extends DonateTabbarState {
  final int selectedIndex;
  final List<String> tabs;

  DonateTabbarInitial({
    this.selectedIndex = 0,
    this.tabs = const ["Donate", "Donations"],
  });

  DonateTabbarInitial copyWith({
    int? selectedIndex,
    List<String>? tabs,
  }) {
    return DonateTabbarInitial(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      tabs: tabs ?? this.tabs,
    );
  }
}
