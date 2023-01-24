// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {}

class GetAllCartProductsEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class AddProductToCartEvent extends CartEvent {
  final CartProductModel product;
  AddProductToCartEvent({
    required this.product,
  });
  @override
  List<Object?> get props => [product];
}

class RemoveProductFromCartEvent extends CartEvent {
  final CartProductModel product;
  final int id;
  RemoveProductFromCartEvent({
    required this.product,
    required this.id,
  });
  @override
  List<Object?> get props => [product];
}

class IncreaseProductQuantity extends CartEvent {
  final int id;
  IncreaseProductQuantity({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}

class DecreaseProductQuantity extends CartEvent {
  final int id;
  DecreaseProductQuantity({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
