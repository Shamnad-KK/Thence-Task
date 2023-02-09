import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thence_task/data/model/cart_product_model.dart';
import 'package:thence_task/data/repositories/local_repository_impl.dart';
import 'package:thence_task/domain/repositories/local_repository.dart';
import 'package:thence_task/presentation/blocs/cart/cart_bloc.dart';

class MockLocalRepositoryImpl extends Mock implements LocalRepository {}

void main() {
  final MockLocalRepositoryImpl mockLocalRepositoryImpl =
      MockLocalRepositoryImpl();
  late final CartBloc cartBloc;

  setUp(
    () {
      cartBloc = CartBloc(localRepository: mockLocalRepositoryImpl);
    },
  );

  // final MockLocalRepositoryImpl mockLocalRepositoryImpl =
  //     MockLocalRepositoryImpl();
  // final CartBloc cartBloc = CartBloc(localRepository: mockLocalRepositoryImpl);

  group(
    'Cart products',
    () {
      test(
        'initial test',
        () {
          expect(cartBloc.state, CartState.initial());
        },
      );

      final List<CartProductModel> cartProducts = [
        CartProductModel(
          id: 1,
          name: 'name1',
          image: 'img1',
          price: 1,
          priceUnit: 'priceUnit1',
        ),
        CartProductModel(
          id: 2,
          name: 'name2',
          image: 'img2',
          price: 1,
          priceUnit: 'priceUnit2',
        ),
      ];

      final CartProductModel cartProduct = CartProductModel(
        id: 2,
        name: 'name2',
        image: 'img2',
        price: 1,
        priceUnit: 'priceUnit2',
      );
      blocTest<CartBloc, CartState>(
        'getting cart products when [OnCartInit] event is added',
        build: () {
          when(
            () => mockLocalRepositoryImpl.getCartLocalData(),
          ).thenAnswer((_) async => cartProducts);
          return cartBloc;
        },
        act: (bloc) => bloc.add(OnCartInit()),
        expect: () => [
          CartState(
            cartProducts: cartProducts,
          ),
        ],
      );

      blocTest<CartBloc, CartState>(
        'product added to cart',
        seed: () => CartState(cartProducts: cartProducts),
        build: () {
          return cartBloc;
        },
        act: (bloc) => bloc.add(AddProductToCartEvent(product: cartProduct)),
        expect: () => [
          CartState(
            cartProducts: [
              cartProduct,
              ...cartProducts,
            ],
          )
        ],
      );
    },
  );
}
