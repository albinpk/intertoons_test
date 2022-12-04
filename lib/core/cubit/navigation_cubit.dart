import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  /// Change bottom navigation.
  void changeTab(int i) {
    emit(state.copyWith(currentTab: i));
  }

  /// Change bottom navigation with data.
  void changeTabWithData(int i, {required Object data}) {
    emit(state.copyWith(currentTab: i, data: data));
  }
}
