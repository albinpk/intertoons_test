import 'product_base.dart';

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
}
