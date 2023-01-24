part of 'home_bloc.dart';

enum Status {
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  final Status status;
  final List<ProductsModel>? products;
  final ProductsModel? product;
  const HomeState({
    required this.status,
    this.products,
    this.product,
  });

  HomeState copywith({
    Status? status,
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
