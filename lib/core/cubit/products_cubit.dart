import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product_model.dart';
import '../repositories/products_repository.dart';
import '../types.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required ProductsRepository productsRepository})
      : _repository = productsRepository,
        super(const ProductsState()) {
    _getProducts();
  }

  final ProductsRepository _repository;

  /// Fetch products from api.
  void _getProducts() async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      final json = await _repository.fetchProducts();
      if (!json.containsKey('data')) throw 'No data';
      final products = _getListItemFromJson(
        json,
        'products',
        Product.fromMap,
      );
      emit(state.copyWith(products: products, status: ProductsStatus.succuss));
    } catch (err) {
      log(err.toString());
      emit(state.copyWith(status: ProductsStatus.failure));
    }
  }

  // TODO: Reuse
  List<T> _getListItemFromJson<T>(
    MapData map,
    String key,
    T Function(MapData map) converter,
  ) {
    try {
      if (!(map['data'] as MapData).containsKey(key)) {
        throw 'No $key in the json';
      }

      return (map['data'][key] as List)
          .map<T>((e) => converter(e as MapData))
          .toList();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }
}
