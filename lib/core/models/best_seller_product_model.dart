import '../extensions/time_of_day_extension.dart';
import 'product_model.dart';
import 'product_variation_model.dart';

class BestSellerProduct extends Product {
  const BestSellerProduct({
    required super.id,
    required super.name,
    required super.description,
    required super.isVeg,
    required super.price,
    required super.sku,
    required super.imageUrl,
    super.categoryId,
    super.categoryName,
    super.specialPrice,
    super.variations,
    super.availableFrom,
    super.availableTo,
    required this.orderCount,
  });

  /// Product order count.
  final int? orderCount;

  factory BestSellerProduct.fromMap(Map<String, dynamic> map) {
    return BestSellerProduct(
      id: map[Product.kId] as int,
      name: map[Product.kName] as String,
      description: map[Product.kDescription] as String,
      isVeg: map[Product.kIsVeg] == '1' ? true : false,
      price: double.parse(map[Product.kPrice]),
      specialPrice: map[Product.kSpecialPrice] != null
          ? map[Product.kSpecialPrice] == 0
              ? null
              : double.parse(map[Product.kSpecialPrice])
          : null,
      sku: map[Product.kSku] as String,
      categoryId: map[Product.kCategoryId] != null
          ? int.parse(map[Product.kCategoryId])
          : null,
      categoryName: map[Product.kCategoryName] != null
          ? map[Product.kCategoryName] as String
          : null,
      imageUrl: map[Product.kImageUrl] as String,
      variations: map[Product.kVariations] != null
          ? List<ProductVariation>.from(
              (map[Product.kVariations] as List).map<ProductVariation?>(
                (x) => ProductVariation.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      availableFrom: map[Product.kAvailableFrom] != null
          ? TimeOfDayX.fromString(map[Product.kAvailableFrom])
          : null,
      availableTo: map[Product.kAvailableTo] != null
          ? TimeOfDayX.fromString(map[Product.kAvailableTo])
          : null,
      orderCount: map[_kOrderCount] != null ? map[_kOrderCount] as int : null,
    );
  }

  static const _kOrderCount = 'order_count';
}
