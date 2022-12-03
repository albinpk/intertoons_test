import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/types.dart';
import '../../models/best_seller_product.dart';
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
          sliderBanners: _getListItemFromJson(
            json,
            'slider_banners',
            SliderBanner.fromMap,
          ),
          featuredProducts: _getListItemFromJson(
            json,
            'featured_products',
            FeaturedProduct.fromMap,
          ),
          additionalBanners: _getListItemFromJson(
            json,
            'additional_banners',
            SliderBanner.fromMap,
          ),
          bestSellerProducts: _getListItemFromJson(
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

  /// Extract and return the list of [T] contained in the [key]
  /// from the given [map] using the [converter] function.
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
