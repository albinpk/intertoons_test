import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions/time_of_day_extension.dart';
import 'best_seller_product_model.dart';
import 'featured_product_model.dart';
import 'product_variation_model.dart';

/// The product platform class.
///
/// This is the base class for the [FeaturedProduct] and [BestSellerProduct] classes.
class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.isVeg,
    required this.price,
    this.specialPrice,
    required this.sku,
    this.categoryId,
    this.categoryName,
    required this.imageUrl,
    this.variations,
    this.availableFrom,
    this.availableTo,
  });

  /// Product id.
  final int id;

  /// Product name.
  final String name;

  /// Product description.
  final String description;

  /// Whether this product is vegetarian or not.
  final bool isVeg;

  /// Product price.
  final double price;

  /// Product special price.
  final double? specialPrice;

  /// Product stock keeping unit.
  final String sku;

  /// Product category id.
  final int? categoryId;

  /// Product category name.
  final String? categoryName;

  /// Product image.
  final String imageUrl;

  /// List of product variations.
  final List<ProductVariation>? variations;

  /// The time this product starts selling.
  ///
  /// see [availableTo].
  final TimeOfDay? availableFrom;

  /// The time this product stops selling.
  ///
  /// see [availableFrom].
  final TimeOfDay? availableTo;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      isVeg,
      price,
      specialPrice,
      sku,
      categoryId,
      categoryName,
      imageUrl,
      variations,
      availableFrom,
      availableTo,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      kId: id,
      kName: name,
      kDescription: description,
      kIsVeg: isVeg,
      kPrice: price,
      kSpecialPrice: specialPrice,
      kSku: sku,
      kCategoryId: categoryId,
      kCategoryName: categoryName,
      kImageUrl: imageUrl,
      kVariations: variations?.map((x) => x.toMap()).toList(),
      kAvailableFrom: availableFrom?.toStringShort(),
      kAvailableTo: availableTo?.toStringShort(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map[kId] as int,
      name: map[kName] as String,
      description: map[kDescription] as String,
      isVeg: map[kIsVeg] == '1' ? true : false,
      price: double.parse(map[kPrice]),
      specialPrice: map[kSpecialPrice] != null
          ? map[kSpecialPrice] == 0
              ? null
              : double.parse(map[kSpecialPrice])
          : null,
      sku: map[kSku] as String,
      categoryId: map[kCategoryId] != null ? map[kCategoryId] as int : null,
      categoryName:
          map[kCategoryName] != null ? map[kCategoryName] as String : null,
      // TODO: fix null image
      imageUrl: map[kImageUrl] as String? ??
          'https://images.unsplash.com/flagged/photo-1593005510509-d05b264f1c9c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      variations: map[kVariations] != null
          ? List<ProductVariation>.from(
              (map[kVariations] as List).map<ProductVariation?>(
                (x) => ProductVariation.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      availableFrom: map[kAvailableFrom] != null
          ? TimeOfDayX.fromString(map[kAvailableFrom])
          : null,
      availableTo: map[kAvailableTo] != null
          ? TimeOfDayX.fromString(map[kAvailableTo])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  static const kId = 'id';
  static const kName = 'name';
  static const kDescription = 'description';
  static const kIsVeg = 'is_veg';
  static const kPrice = 'price';
  static const kSpecialPrice = 'special_price';
  static const kSku = 'sku';
  static const kCategoryId = 'category_id';
  static const kCategoryName = 'category_name';
  static const kImageUrl = 'image';
  static const kVariations = 'variations';
  static const kAvailableFrom = 'available_from';
  static const kAvailableTo = 'available_to';
}
