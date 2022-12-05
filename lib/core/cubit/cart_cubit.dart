import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends HydratedCubit<CartState> {
  CartCubit() : super(const CartState());

  /// Add a product to shopping cart.
  ///
  /// If the given [product] exists in the cart, then increment its count by 1.
  void addToCart(Product product) {
    final index = state.items.indexWhere((e) => e.productId == product.id);
    if (index >= 0) {
      final items = [...state.items];
      final item = items.removeAt(index);
      final updatedItem = item.copyWith(productCount: item.productCount + 1);
      items.insert(index, updatedItem);
      return emit(state.copyWith(items: items));
    }

    emit(
      state.copyWith(
        items: [
          CartItem.fromProduct(product),
          ...state.items,
        ],
      ),
    );
  }

  /// Decrease given [product]s count by 1.
  ///
  /// Remove the [product] if its count is 1.
  void removeFromCart(Product product) {
    final index = state.items.indexWhere((e) => e.productId == product.id);
    assert(index != -1);
    final items = [...state.items];
    final item = items.removeAt(index);
    if (item.productCount > 1) {
      final updatedItem = item.copyWith(productCount: item.productCount - 1);
      items.insert(index, updatedItem);
    }
    emit(state.copyWith(items: items));
  }

  /// Delete a product to shopping cart.
  void deleteFromCart(Product product) {
    final index = state.items.indexWhere((e) => e.productId == product.id);
    assert(index != -1);
    final items = [...state.items]..removeAt(index);
    emit(state.copyWith(items: items));
  }

  @override
  CartState fromJson(Map<String, dynamic> json) => CartState.fromMap(json);

  @override
  Map<String, dynamic> toJson(CartState state) => state.toMap();

  @override
  void onError(Object error, StackTrace stackTrace) {
    log(
      'An error has occurred.',
      name: 'CartCubit',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(error, stackTrace);
  }
}
