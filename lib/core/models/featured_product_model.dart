import 'dart:convert';

import 'package:flutter/material.dart';
import 'product_variation_model.dart';

import 'product_base_model.dart';

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

  /// Return `true` if the product has a discount price.
  bool get hasDiscount => specialPrice != 0;

  @override
  List<Object> get props => [
        ...super.props,
        specialPrice,
        availableFrom,
        availableTo,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _kId: id,
      _kName: name,
      _kSku: sku,
      _kCategoryId: categoryId,
      _kCategoryName: categoryName,
      _kIsVeg: isVeg,
      _kDescription: description,
      _kPrice: price,
      _kImageUrl: imageUrl,
      _kVariations: variations.map((x) => x.toMap()).toList(),
    };
  }

  factory FeaturedProduct.fromMap(Map<String, dynamic> map) {
    return FeaturedProduct(
      id: map[_kId] as int,
      name: map[_kName] as String,
      sku: map[_kSku] as String,
      categoryId: map[_kCategoryId] as String,
      categoryName: map[_kCategoryName] as String,
      isVeg: (map[_kIsVeg] as String) == "1" ? true : false,
      description: map[_kDescription] as String,
      price: double.parse(map[_kPrice] as String),
      imageUrl: map[_kImageUrl] as String,
      variations: List<ProductVariation>.from(
        (map[_kVariations] as List).map<ProductVariation>(
          (x) => ProductVariation.fromMap(x),
        ),
      ),
      specialPrice: map[_kSpecialPrice] is int
          ? map[_kSpecialPrice].toDouble()
          : double.parse(map[_kSpecialPrice]),
      availableFrom: TimeOfDay(
        hour: int.parse((map[_kAvailableFrom] as String).split(':')[0]),
        minute: int.parse((map[_kAvailableFrom] as String).split(':')[1]),
      ),
      availableTo: TimeOfDay(
        hour: int.parse((map[_kAvailableTo] as String).split(':')[0]),
        minute: int.parse((map[_kAvailableTo] as String).split(':')[1]),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeaturedProduct.fromJson(String source) =>
      FeaturedProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  static const _kId = 'id';
  static const _kName = 'name';
  static const _kSku = 'sku';
  static const _kCategoryId = 'category_id';
  static const _kCategoryName = 'category_name';
  static const _kIsVeg = 'is_veg';
  static const _kDescription = 'description';
  static const _kPrice = 'price';
  static const _kImageUrl = 'image';
  static const _kVariations = 'variations';
  static const _kSpecialPrice = 'special_price';
  static const _kAvailableFrom = 'available_from';
  static const _kAvailableTo = 'available_from';
}
