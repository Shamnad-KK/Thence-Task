part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<ProductsModel> foundProducts;
  const SearchState({
    required this.foundProducts,
  });

  SearchState copyWith({
    List<ProductsModel>? allProducts,
    List<ProductsModel>? foundProducts,
  }) {
    return SearchState(
      foundProducts: foundProducts ?? this.foundProducts,
    );
  }

  @override
  List<Object?> get props => [foundProducts];
}
