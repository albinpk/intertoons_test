import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/mixins/json_extraction_mixin.dart';
import '../../../../core/models/best_seller_product_model.dart';
import '../../../../core/models/featured_product_model.dart';
import '../../../../core/models/product_model.dart';
import '../../models/slider_banner.dart';
import '../../repositories/home_repository.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> with JsonExtractionMixin {
  HomeViewCubit({required HomeRepository homeRepository})
      : _repository = homeRepository,
        super(const HomeViewState()) {
    _getHomeData();
  }

  final HomeRepository _repository;

  Future<void> _getHomeData() async {
    emit(state.copyWith(status: HomeViewStatus.loading));
    try {
      final json = await _repository.fetchHomeData();
      if (!json.containsKey('data')) throw 'No data';
      emit(
        state.copyWith(
          status: HomeViewStatus.success,
          sliderBanners: extractListFromJson(
            json,
            'slider_banners',
            SliderBanner.fromMap,
          ),
          featuredProducts: extractListFromJson(
            json,
            'featured_products',
            FeaturedProduct.fromMap,
          ),
          additionalBanners: extractListFromJson(
            json,
            'additional_banners',
            SliderBanner.fromMap,
          ),
          bestSellerProducts: extractListFromJson(
            json,
            'bestseller_products',
            BestSellerProduct.fromMap,
          ),
        ),
      );
    } catch (err) {
      log(err.toString());
      emit(state.copyWith(status: HomeViewStatus.failure));
    }
  }

  /// Refetch home data.
  void refresh() => _getHomeData();
}
