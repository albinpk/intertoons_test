part of 'cart_cubit.dart';

class CartState extends Equatable {
  const CartState({
    this.items = const [],
  });

  /// Items in cart.
  final List<FeaturedProduct> items;

  @override
  List<Object> get props => [items];

  CartState copyWith({
    List<FeaturedProduct>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory CartState.fromMap(Map<String, dynamic> map) {
    return CartState(
      items: List<FeaturedProduct>.from(
        (map['items'] as List<int>).map<FeaturedProduct>(
          (x) => FeaturedProduct.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartState.fromJson(String source) =>
      CartState.fromMap(json.decode(source) as Map<String, dynamic>);
}
