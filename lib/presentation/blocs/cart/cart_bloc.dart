import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thence_task/core/pop_ups.dart';
import 'package:thence_task/data/model/cart_product_model.dart';
import 'package:thence_task/theme/app_colors.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    //on<GetAllCartProductsEvent>(_getAllCartProducts);

    on<AddProductToCartEvent>(_addProductToCart);

    on<RemoveProductFromCartEvent>(_removeProductFromCart);

    on<IncreaseProductQuantity>(_increaseProductQuantity);
    on<DecreaseProductQuantity>(_decreaseProductQuantity);
  }

  void _addProductToCart(
    AddProductToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final int index = state.cartProducts.indexWhere(
      (element) => element.id == event.product.id,
    );

    List<CartProductModel> temp = state.cartProducts.toList();

    if (index != -1) {
      temp[index].count++;
      state.copyWith(
        cartProducts: temp,
        totalCount: temp.length,
      );
    } else {
      emit(
        state.copyWith(
          cartProducts: [
            event.product,
            ...temp,
          ],
          totalCount: state.cartProducts.length,
        ),
      );
    }

    await AppPopUps.showToast(
      'Product added to cart',
      AppColors.successColor,
    );
  }

  void _removeProductFromCart(
    RemoveProductFromCartEvent event,
    Emitter<CartState> emit,
  ) {
    final int index = state.cartProducts.indexWhere(
      (element) => element.id == event.id,
    );

    List<CartProductModel> temp = state.cartProducts.toList();
    temp.removeAt(index);
    emit(
      state.copyWith(
        cartProducts: temp,
        totalCount: state.cartProducts.length,
      ),
    );
  }

  // void _getAllCartProducts(
  //   GetAllCartProductsEvent event,
  //   Emitter<CartState> emit,
  // ) {
  //   List<CartProductModel> temp = state.cartProducts.toList();
  //   double price = 0;
  //   for (var i = 0; i < temp.length; i++) {
  //     for (var j = 0; j < temp[i].count; j++) {
  //       price = price + temp[i].price;
  //     }

  //     log(price.toString());
  //   }
  //   emit(
  //     state.copyWith(
  //       cartProducts: state.cartProducts,
  //       totalPrice: price,
  //     ),
  //   );
  // }

  void _increaseProductQuantity(
    IncreaseProductQuantity event,
    Emitter<CartState> emit,
  ) {
    double price = 0;
    final int index = state.cartProducts.indexWhere(
      (element) => element.id == event.id,
    );
    List<CartProductModel> temp = state.cartProducts.toList();
    temp[index] = temp[index].incrementCount();
    // for (var i = 0; i < temp.length; i++) {
    //   for (var j = 0; j < temp[i].count; j++) {
    //     price = price + temp[i].price;
    //   }
    // }
    emit(
      state.copyWith(
        cartProducts: temp,
        totalPrice: price,
      ),
    );
  }

  void _decreaseProductQuantity(
    DecreaseProductQuantity event,
    Emitter<CartState> emit,
  ) {
    final int index = state.cartProducts.indexWhere(
      (element) => element.id == event.id,
    );
    double price = 0;

    if (state.cartProducts[index].count != 1) {
      List<CartProductModel> temp = state.cartProducts.toList();
      temp[index] = temp[index].decrementCount();

      // for (var i = 0; i < temp.length; i++) {
      //   for (var j = 0; j < temp[i].count; j++) {
      //     price = price - temp[i].price;
      //   }
      // }
      emit(
        state.copyWith(
          cartProducts: temp,
          totalPrice: price,
        ),
      );
    }
  }
}
