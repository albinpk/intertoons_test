import 'package:equatable/equatable.dart';

import 'featured_product.dart';
import 'product_variation.dart';

/// The product base class.
///
/// This is the base class for the [FeaturedProduct] class.
abstract class ProductBase extends Equatable {
  const ProductBase({
    required this.id,
    required this.name,
    required this.sku,
    required this.categoryId,
    required this.categoryName,
    required this.isVeg,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.variations,
  });

  /// Product id.
  final int id;

  /// Product name.
  final String name;

  /// Product stock keeping unit.
  final String sku;

  /// Product category id.
  final String categoryId;

  /// Product category name.
  final String categoryName;

  /// Whether this product is vegetarian or not.
  final bool isVeg;

  /// Product description.
  final String description;

  /// Product price.
  final double price;

  /// Product image.
  final String imageUrl;

  /// List of product variations.
  final List<ProductVariation> variations;

  @override
  List<Object> get props {
    return [
      id,
      name,
      sku,
      categoryId,
      categoryName,
      isVeg,
      description,
      price,
      imageUrl,
      variations,
    ];
  }
}
