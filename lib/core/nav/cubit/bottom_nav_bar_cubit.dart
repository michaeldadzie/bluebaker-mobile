import 'package:bloc/bloc.dart';
import 'package:bluebaker/core/nav/enums/bottom_nav_item.dart';
import 'package:equatable/equatable.dart';


part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit()
      : super(const BottomNavBarState(selectedItem: BottomNavItem.home));

  void updateSelectedItem(BottomNavItem item) {
    if (item != state.selectedItem) {
      emit(BottomNavBarState(selectedItem: item));
    }
  }
}
