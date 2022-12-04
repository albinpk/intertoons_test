part of 'cart_cubit.dart';

class CartState extends Equatable {
  const CartState({
    this.items = const [],
  });

  /// Items in cart.
  final List<CartItem> items;

  @override
  List<Object> get props => [items];

  CartState copyWith({
    List<CartItem>? items,
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
      items: List<CartItem>.from(
        (map['items'] as List).map<CartItem>(
          (x) => CartItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartState.fromJson(String source) =>
      CartState.fromMap(json.decode(source) as Map<String, dynamic>);
}
