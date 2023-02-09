import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thence_task/data/model/product_model.dart';
import 'package:thence_task/data/repositories/local_repository_impl.dart';
import 'package:thence_task/data/repositories/product_remote_repository_impl.dart';
import 'package:thence_task/presentation/blocs/home/home_bloc.dart';

class MockHomeRepository extends Mock implements HomeRepositoryImpl {}

class MockLocalRepositoryImpl extends Mock implements LocalRepositoryImpl {}

void main() {
  late MockLocalRepositoryImpl mockHomeLocalRepository;
  late MockHomeRepository mockHomeRemoteRepository;
  late HomeBloc homeBloc;
  setUp(
    () {
      mockHomeLocalRepository = MockLocalRepositoryImpl();
      mockHomeRemoteRepository = MockHomeRepository();
      homeBloc = HomeBloc(
        homeRepository: mockHomeRemoteRepository,
        localRepository: mockHomeLocalRepository,
      );
    },
  );

  group(
    'Home products',
    () {
      test(
        'initial test',
        () {
          expect(homeBloc.state, HomeState.initial());
        },
      );
      final ProductsModel selectedProduct = ProductsModel(
        id: 1,
        imageUrl: 'img1',
        name: 'name1',
        rating: 'rating1',
        displaySize: 1,
        availableSize: [1, 2],
        unit: 'unit1',
        price: 'price1',
        priceUnit: 'priceUnit1',
        description: 'description1',
      );
      final List<ProductsModel> products = [
        ProductsModel(
          id: 1,
          imageUrl: 'img1',
          name: 'name1',
          rating: 'rating1',
          displaySize: 1,
          availableSize: [1, 2],
          unit: 'unit1',
          price: 'price1',
          priceUnit: 'priceUnit1',
          description: 'description1',
        ),
      ];

      blocTest<HomeBloc, HomeState>(
        'throwing [HomeStatus.error] if data fetching fails',
        build: () {
          when(() => mockHomeLocalRepository.getHomeLocalData()).thenThrow(
            Exception(),
          );

          when(() => mockHomeRemoteRepository.getProducts()).thenThrow(
            Exception(),
          );

          return homeBloc;
        },
        act: (bloc) => bloc.add(GetProductsEvent()),
        expect: () => [
          const HomeState(
            status: HomeStatus.loading,
            products: null,
            selectedProduct: null,
          ),
          const HomeState(
            status: HomeStatus.error,
            products: null,
            selectedProduct: null,
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'getting products when [GetProductsEvent] is added',
        build: () {
          when(() => mockHomeRemoteRepository.getProducts())
              .thenAnswer((_) async => products);
          when(() => mockHomeLocalRepository.getHomeLocalData())
              .thenAnswer((_) async => products);
          return homeBloc;
        },
        act: (bloc) => bloc.add(GetProductsEvent()),
        expect: () => [
          const HomeState(
            status: HomeStatus.loading,
            products: null,
          ),
          HomeState(
            status: HomeStatus.loaded,
            products: products,
          )
        ],
        verify: (bloc) {
          verify(mockHomeRemoteRepository.getProducts).called(1);
          verify(mockHomeLocalRepository.getHomeLocalData).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'selecting a product',
        build: () {
          return homeBloc;
        },
        act: (bloc) {
          bloc.add(SelectAProductEvent(product: selectedProduct));
        },
        expect: () => <HomeState>[
          HomeState(
            status: HomeStatus.loading,
            products: null,
            selectedProduct: selectedProduct,
          ),
        ],
        verify: (bloc) {
          //  verify(homeBloc.s)
        },
      );
    },
  );
}
