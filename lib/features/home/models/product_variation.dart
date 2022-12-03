import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Product variation mode.
class ProductVariation extends Equatable {
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
  final double specialPrice;

  @override
  List<Object> get props => [id, title, price, specialPrice];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _kId: id,
      _kTitle: title,
      _kPrice: price,
      _kSpecialPrice: specialPrice,
    };
  }

  factory ProductVariation.fromMap(Map<String, dynamic> map) {
    return ProductVariation(
      id: map[_kId] as int,
      title: map[_kTitle] as String,
      price: map[_kPrice] as String,
      specialPrice: map[_kSpecialPrice] is int
          ? map[_kSpecialPrice].toDouble()
          : double.parse(map[_kSpecialPrice]),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductVariation.fromJson(String source) =>
      ProductVariation.fromMap(json.decode(source) as Map<String, dynamic>);

  static const _kSpecialPrice = 'special_price';
  static const _kPrice = 'price';
  static const _kTitle = 'title';
  static const _kId = 'id';
}
