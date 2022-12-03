part of 'menu_view_cubit.dart';

enum MenuViewStatus { initial, loading, success, failure }

class MenuViewState extends Equatable {
  const MenuViewState({
    this.status = MenuViewStatus.initial,
    this.categories = const [],
  });

  final MenuViewStatus status;
  final List<Category> categories;

  @override
  List<Object> get props => [status, categories];

  MenuViewState copyWith({
    MenuViewStatus? status,
    List<Category>? categories,
  }) {
    return MenuViewState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }
}
