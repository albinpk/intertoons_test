part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  const NavigationState({
    this.currentTab = 0,
    this.data,
  });

  /// Current tab index.
  final int currentTab;

  /// Data for the tab.
  final Object? data;

  @override
  List<Object?> get props => [currentTab, data];

  NavigationState copyWith({
    int? currentTab,
    Object? data,
  }) {
    return NavigationState(
      currentTab: currentTab ?? this.currentTab,
      data: data,
    );
  }
}
