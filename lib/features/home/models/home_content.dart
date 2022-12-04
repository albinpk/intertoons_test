import 'package:equatable/equatable.dart';

import '../../../core/models/best_seller_product_model.dart';
import '../../../core/models/featured_product_model.dart';
import 'slider_banner.dart';

/// Home contents model
class HomeContent extends Equatable {
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

  @override
  List<Object> get props =>
      [sliderBanners, featuredProducts, bestSellerProducts];
}
