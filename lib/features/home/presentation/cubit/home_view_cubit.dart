import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/types.dart';
import '../../models/featured_product.dart';
import '../../models/slider_banner.dart';
import '../../repositories/home_repository.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
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
          sliderBanners: _getSliderBannersFromJson(json),
          featuredProducts: _getFeaturedProductsFromJson(json),
        ),
      );
    } catch (err) {
      log(err.toString());
      emit(state.copyWith(status: HomeViewStatus.failure));
    }
  }

  /// Refetch home data.
  void refresh() => _getHomeData();

  /// Extract and return list of [SliderBanner]s.
  List<SliderBanner> _getSliderBannersFromJson(MapData json) {
    try {
      if (!(json['data'] as MapData).containsKey('slider_banners')) {
        throw 'No banners';
      }

      return (json['data']['slider_banners'] as List)
          .map((e) => SliderBanner.fromMap(e))
          .toList();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  /// Extract and return list of [FeaturedProduct]s.
  List<FeaturedProduct> _getFeaturedProductsFromJson(MapData json) {
    try {
      if (!(json['data'] as MapData).containsKey('featured_products')) {
        throw 'No Featured products';
      }

      return (json['data']['featured_products'] as List)
          .map((e) => FeaturedProduct.fromMap(e))
          .toList();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }
}
