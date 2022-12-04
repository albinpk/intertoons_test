part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  const NavigationState({
    this.currentTab = 0,
  });

  /// Current tab index.
  final int currentTab;

  @override
  List<Object> get props => [currentTab];

  NavigationState copyWith({
    int? currentTab,
  }) {
    return NavigationState(
      currentTab: currentTab ?? this.currentTab,
    );
  }
}
