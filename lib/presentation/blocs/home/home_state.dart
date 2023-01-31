part of 'home_bloc.dart';

enum HomeStatus {
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ProductsModel>? products;
  final ProductsModel? product;
  const HomeState({
    required this.status,
    this.products,
    this.product,
  });

  HomeState copywith({
    HomeStatus? status,
    List<ProductsModel>? products,
    final ProductsModel? product,
  }) =>
      HomeState(
        status: status ?? this.status,
        products: products ?? this.products,
        product: product ?? this.product,
      );

  @override
  List<Object?> get props => [status, products, product];
}
