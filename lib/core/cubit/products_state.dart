part of 'products_cubit.dart';

enum ProductsStatus { initial, loading, succuss, failure }

class ProductsState extends Equatable {
  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
  });

  final ProductsStatus status;

  final List<Product> products;

  @override
  List<Object> get props => [status, products];

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }
}
