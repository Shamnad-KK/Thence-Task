part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartProductModel> cartProducts;

  const CartState({
    required this.cartProducts,
  });

  CartState copyWith({
    List<CartProductModel>? cartProducts,
    double? totalPrice,
  }) {
    return CartState(
      cartProducts: cartProducts ?? this.cartProducts,
    );
  }

  factory CartState.initial() {
    return const CartState(
      cartProducts: [],
    );
  }

  double get totalPrice {
    double price = 0;
    for (var i = 0; i < cartProducts.length; i++) {
      for (var j = 0; j < cartProducts[i].count; j++) {
        price = price + cartProducts[i].price;
      }
    }
    return price;
  }

  @override
  List<Object> get props => [
        cartProducts,
      ];
}
