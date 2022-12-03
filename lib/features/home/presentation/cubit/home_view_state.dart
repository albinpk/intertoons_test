part of 'home_view_cubit.dart';

/// Home view status.
enum HomeViewStatus { initial, loading, success, failure }

@immutable
class HomeViewState {
  const HomeViewState({
    this.status = HomeViewStatus.initial,
    this.sliderBanners = const [],
    this.featuredProducts = const [],
  });

  final HomeViewStatus status;
  final List<SliderBanner> sliderBanners;
  final List<FeaturedProduct> featuredProducts;

  HomeViewState copyWith({
    HomeViewStatus? status,
    List<SliderBanner>? sliderBanners,
    List<FeaturedProduct>? featuredProducts,
  }) {
    return HomeViewState(
      status: status ?? this.status,
      sliderBanners: sliderBanners ?? this.sliderBanners,
      featuredProducts: featuredProducts ?? this.featuredProducts,
    );
  }
}
