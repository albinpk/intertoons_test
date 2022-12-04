import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/featured_product_model.dart';

part 'cart_state.dart';

class CartCubit extends HydratedCubit<CartState> {
  CartCubit() : super(const CartState());

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
