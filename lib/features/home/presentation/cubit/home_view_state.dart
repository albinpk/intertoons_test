part of 'home_view_cubit.dart';

/// Home view status.
enum HomeViewStatus { initial, loading, success, failure }

@immutable
class HomeViewState {
  const HomeViewState({
    this.status = HomeViewStatus.initial,
    this.sliderBanners = const [],
  });

  final HomeViewStatus status;
  final List<SliderBanner> sliderBanners;

  HomeViewState copyWith({
    HomeViewStatus? status,
    List<SliderBanner>? sliderBanners,
  }) {
    return HomeViewState(
      status: status ?? this.status,
      sliderBanners: sliderBanners ?? this.sliderBanners,
    );
  }
}
