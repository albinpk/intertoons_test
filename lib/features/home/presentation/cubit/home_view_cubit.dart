import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      final res = await _repository.fetchHomeData();
      final banners = _getSliderBannersFromJson(res);
      emit(state.copyWith(
        sliderBanners: banners,
        status: HomeViewStatus.success,
      ));
    } catch (err) {
      log(err.toString());
      emit(state.copyWith(status: HomeViewStatus.failure));
    }
  }

  /// Refetch home data.
  void refresh() => _getHomeData();

  /// Extract and return list of [SliderBanner]s.
  List<SliderBanner> _getSliderBannersFromJson(Map<String, dynamic> json) {
    try {
      if (!json.containsKey('data')) throw 'No data';

      if (!(json['data'] as Map<String, dynamic>)
          .containsKey('slider_banners')) {
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
}
