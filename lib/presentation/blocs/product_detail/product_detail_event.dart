part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {}

class ChangeProductDetailChoiceChipEvent extends ProductDetailEvent {
  final int index;
  ChangeProductDetailChoiceChipEvent({
    required this.index,
  });
  @override
  List<Object?> get props => [index];
}
