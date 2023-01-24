part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartProductModel> cartProducts;
  final int totalCount;

  double get totalPrice {
    double price = 0;
    for (var i = 0; i < cartProducts.length; i++) {
      for (var j = 0; j < cartProducts[i].count; j++) {
        price = price + cartProducts[i].price;
        log('price.toString()');
      }
    }
    return price;
  }

  const CartState({
    required this.cartProducts,
    required this.totalCount,
  });

  CartState copyWith({
    List<CartProductModel>? cartProducts,
    int? totalCount,
    double? totalPrice,
  }) {
    return CartState(
      cartProducts: cartProducts ?? this.cartProducts,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  static CartState initial() {
    return const CartState(
      cartProducts: [],
      totalCount: 0,
    );
  }

  @override
  List<Object> get props => [
        cartProducts,
        totalCount,
      ];
}
