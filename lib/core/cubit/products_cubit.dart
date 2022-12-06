import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../mixins/json_extraction_mixin.dart';
import '../models/product_model.dart';
import '../repositories/products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> with JsonExtractionMixin {
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
      final products = extractListFromJson(
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
}
