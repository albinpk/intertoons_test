import 'dart:convert';

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
}
