part of 'home_view_cubit.dart';

/// Home view status.
enum HomeViewStatus { initial, loading, success, failure }

@immutable
class HomeViewState extends Equatable {
  const HomeViewState({
    this.status = HomeViewStatus.initial,
    this.sliderBanners = const [],
    this.featuredProducts = const [],
    this.additionalBanners = const [],
    this.bestSellerProducts = const [],
    this.allProducts = const [],
  });

  /// HomeView status
  final HomeViewStatus status;

  /// List of [SliderBanner]s.
  final List<SliderBanner> sliderBanners;

  /// List of [FeaturedProduct]s.
  final List<FeaturedProduct> featuredProducts;

  /// List of additional [SliderBanner]s.
  final List<SliderBanner> additionalBanners;

  /// List of [BestSellerProduct]s.
  final List<BestSellerProduct> bestSellerProducts;

  /// List of products.
  final List<ProductBase> allProducts;

  HomeViewState copyWith({
    HomeViewStatus? status,
    List<SliderBanner>? sliderBanners,
    List<FeaturedProduct>? featuredProducts,
    List<SliderBanner>? additionalBanners,
    List<BestSellerProduct>? bestSellerProducts,
    List<ProductBase>? allProducts,
  }) {
    return HomeViewState(
      status: status ?? this.status,
      sliderBanners: sliderBanners ?? this.sliderBanners,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      additionalBanners: additionalBanners ?? this.additionalBanners,
      bestSellerProducts: bestSellerProducts ?? this.bestSellerProducts,
      allProducts: allProducts ?? this.allProducts,
    );
  }

  @override
  List<Object> get props {
    return [
      status,
      sliderBanners,
      featuredProducts,
      additionalBanners,
      bestSellerProducts,
      allProducts,
    ];
  }
}
