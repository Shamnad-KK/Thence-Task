import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/data/model/cart_product_model.dart';
import 'package:thence_task/data/repositories/local_repository_impl.dart';
import 'package:thence_task/domain/repositories/local_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final LocalRepository localRepository;
  CartBloc({
    required this.localRepository,
  }) : super(CartState.initial()) {
    on<OnCartInit>(_initCart);

    on<AddProductToCartEvent>(_addProductToCart);

    on<RemoveProductFromCartEvent>(_removeProductFromCart);

    on<IncreaseProductQuantity>(_increaseProductQuantity);

    on<DecreaseProductQuantity>(_decreaseProductQuantity);

    on<StoreCartDataEvent>(_storeCartLocally);
  }

  void _initCart(
    OnCartInit event,
    Emitter<CartState> emit,
  ) async {
    final List<CartProductModel> cartProducts =
        await localRepository.getCartLocalData();
    if (cartProducts.isNotEmpty) {
      emit(
        state.copyWith(
          cartProducts: cartProducts,
        ),
      );
    }
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
      );
    } else {
      emit(
        state.copyWith(
          cartProducts: [
            event.product,
            ...temp,
          ],
        ),
      );
    }

    add(StoreCartDataEvent());
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
      ),
    );
    add(StoreCartDataEvent());
  }

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

    emit(
      state.copyWith(
        cartProducts: temp,
        totalPrice: price,
      ),
    );
    add(StoreCartDataEvent());
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

      emit(
        state.copyWith(
          cartProducts: temp,
          totalPrice: price,
        ),
      );
    }
    add(StoreCartDataEvent());
  }

//Method for storing cart data in local storage
  void _storeCartLocally(
    StoreCartDataEvent event,
    Emitter<CartState> emit,
  ) async {
    await localRepository.storeCartDataLocally(
      state.cartProducts.map((e) => e.toJson()).toList(),
    );
  }
}
