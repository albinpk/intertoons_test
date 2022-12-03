import 'best_seller_product.dart';
import 'featured_product.dart';
import 'slider_banner.dart';

/// Home contents model
class HomeContent {
  const HomeContent({
    required this.sliderBanners,
    required this.featuredProducts,
    required this.bestSellerProducts,
  });

  /// List of [SliderBanner]s.
  final List<SliderBanner> sliderBanners;

  /// List of [FeaturedProduct]s.
  final List<FeaturedProduct> featuredProducts;

  /// List of [BestSellerProduct]s.
  final List<BestSellerProduct> bestSellerProducts;
}
