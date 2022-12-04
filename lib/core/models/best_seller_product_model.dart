import 'dart:convert';

import 'product_base_model.dart';
import 'product_variation_model.dart';

/// Best seller product model.
class BestSellerProduct extends ProductBase {
  const BestSellerProduct({
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
    required this.orderCount,
    required this.menuStatus,
  });

  /// Order count.
  final int orderCount;

  /// Menu status.
  final bool menuStatus;

  @override
  List<Object> get props => [
        ...super.props,
        orderCount,
        menuStatus,
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

  factory BestSellerProduct.fromMap(Map<String, dynamic> map) {
    return BestSellerProduct(
      id: map[_kId] as int,
      name: map[_kName] as String,
      sku: map[_kSku] as String,
      categoryId: map[_kCategoryId] as String,
      categoryName: map[_kCategoryName] as String,
      isVeg: (map[_kIsVeg] as String) == "1" ? true : false,
      description: map[_kDescription] as String,
      price: double.parse(map[_kPrice] as String),
      imageUrl: map[_kImageUrl] as String,
      variations: map[_kVariations] == null
          ? []
          : List<ProductVariation>.from(
              (map[_kVariations] as List).map<ProductVariation>(
                (x) => ProductVariation.fromMap(x),
              ),
            ),
      orderCount: map[_kOrderCount] as int? ?? 0,
      menuStatus: (map[_kMenuStatus] as String) == '1' ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory BestSellerProduct.fromJson(String source) =>
      BestSellerProduct.fromMap(json.decode(source) as Map<String, dynamic>);

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
  static const _kOrderCount = 'order_count';
  static const _kMenuStatus = 'menu_status';
}
