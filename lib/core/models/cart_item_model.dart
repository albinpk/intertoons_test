import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'product_base_model.dart';

/// The cart item model.
class CartItem extends Equatable {
  const CartItem({
    required this.id,
    required this.productId,
    required this.productCount,
  });

  /// The cart item id.
  final String id;

  /// The product id.
  final int productId;

  /// The product count.
  final int productCount;

  @override
  List<Object> get props => [id, productId, productCount];

  static const _uuid = Uuid();

  factory CartItem.fromProduct(ProductBase product) {
    return CartItem(
      id: _uuid.v4(),
      productId: product.id,
      productCount: 1,
    );
  }

  CartItem copyWith({
    String? id,
    int? productId,
    int? productCount,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productCount: productCount ?? this.productCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'productCount': productCount,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      productId: map['productId'] as int,
      productCount: map['productCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
