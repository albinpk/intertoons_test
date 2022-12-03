import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'menu_view_state.dart';

class MenuViewCubit extends Cubit<MenuViewState> {
  MenuViewCubit() : super(MenuViewInitial());
}
