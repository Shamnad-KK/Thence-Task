part of 'home_bloc.dart';

enum HomeStatus {
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ProductsModel>? products;
  final ProductsModel? selectedProduct;
  const HomeState({
    required this.status,
    this.products,
    this.selectedProduct,
  });

  factory HomeState.initial() {
    return const HomeState(
      status: HomeStatus.loading,
      selectedProduct: null,
      products: null,
    );
  }

  HomeState copywith({
    HomeStatus? status,
    List<ProductsModel>? products,
    final ProductsModel? selectedProduct,
  }) =>
      HomeState(
        status: status ?? this.status,
        products: products ?? this.products,
        selectedProduct: selectedProduct ?? this.selectedProduct,
      );

  @override
  List<Object?> get props => [status, products, selectedProduct];
}
