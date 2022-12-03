import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intertoons_test/features/menu/models/category.dart';

import '../../repositories/menu_repository.dart';

part 'menu_view_state.dart';

class MenuViewCubit extends Cubit<MenuViewState> {
  MenuViewCubit({required MenuRepository menuRepository})
      : _repository = menuRepository,
        super(const MenuViewState()) {
    _getMenuData();
  }

  final MenuRepository _repository;

  Future<void> _getMenuData() async {
    emit(state.copyWith(status: MenuViewStatus.loading));
    try {
      final map = await _repository.fetchMenuData();
      if (!map.containsKey('data')) throw 'No data';
      emit(
        state.copyWith(
          status: MenuViewStatus.success,
          categories:
              (map['data'] as List).map((e) => Category.fromMap(e)).toList(),
        ),
      );
    } catch (err) {
      log(err.toString());
      emit(state.copyWith(status: MenuViewStatus.failure));
    }
  }
}
