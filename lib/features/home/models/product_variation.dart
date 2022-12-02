/// Product variation mode.
class ProductVariation {
  const ProductVariation({
    required this.id,
    required this.title,
    required this.price,
    required this.specialPrice,
  });

  /// Product variation id.
  final int id;

  /// Product variation title.
  final String title;

  /// Product variation price.
  final String price;

  /// Product variation special price.
  final String specialPrice;
}
