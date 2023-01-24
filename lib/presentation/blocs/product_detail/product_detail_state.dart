part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  final int? selectedChipIndex;
  const ProductDetailState({
    this.selectedChipIndex,
  });

  ProductDetailState copyWith({
    List<ProductsModel>? products,
    int? selectedChipIndex,
  }) {
    return ProductDetailState(
      selectedChipIndex: selectedChipIndex ?? this.selectedChipIndex,
    );
  }

  @override
  List<Object?> get props => [
        selectedChipIndex,
      ];
}
