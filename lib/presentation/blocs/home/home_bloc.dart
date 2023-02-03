import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thence_task/data/repositories/local_repository_impl.dart';

import 'package:thence_task/data/repositories/product_remote_repository_impl.dart';
import 'package:thence_task/data/model/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepositoryImpl homeRepository;
  final LocalRepositoryImpl localRepository;
  HomeBloc({
    required this.homeRepository,
    required this.localRepository,
  }) : super(const HomeState(status: HomeStatus.loading)) {
    on<GetProductsEvent>(_getProducts);

    // on<AddorRemoveFavoriteEvent>(_addOrRemoveFavorite);

    on<SelectAProductEvent>(_selectAProduct);
  }

  void _getProducts(GetProductsEvent event, Emitter<HomeState> emit) async {
    emit(state.copywith(status: HomeStatus.loading));
    try {
      final localProducts = await localRepository.getHomeLocalData();

      if (localProducts.isNotEmpty) {
        emit(
          state.copywith(
            status: HomeStatus.loaded,
            products: localProducts,
          ),
        );
      }

      final products = await homeRepository.getProducts();
      if (products.isNotEmpty) {
        emit(
          state.copywith(
            status: HomeStatus.loaded,
            products: products,
          ),
        );
      }
    } catch (e) {
      emit(state.copywith(status: HomeStatus.error));
    }
  }

  void _selectAProduct(
    SelectAProductEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copywith(product: event.product));
  }
}
