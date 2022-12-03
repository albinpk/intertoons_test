import 'package:flutter/material.dart';

import 'product_base.dart';

/// Featured product model.
class FeaturedProduct extends ProductBase {
  const FeaturedProduct({
    required super.id,
    required super.name,
    required super.sku,
    required super.categoryId,
    required super.categoryName,
    required super.isVeg,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.variations,
    required this.specialPrice,
    required this.availableFrom,
    required this.availableTo,
  });

  /// Product special price.
  final double specialPrice;

  /// The time this featured product starts selling.
  ///
  /// see [availableTo].
  final TimeOfDay availableFrom;

  /// The time this featured product stops selling.
  ///
  /// see [availableFrom].
  final TimeOfDay availableTo;

  @override
  List<Object> get props => [
        ...super.props,
        specialPrice,
        availableFrom,
        availableTo,
      ];
}
