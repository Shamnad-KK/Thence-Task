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
  HomeBloc({required this.homeRepository, required this.localRepository})
      : super(const HomeState(status: Status.loading)) {
    on<GetProductsEvent>(_getProducts);

    on<AddorRemoveFavoriteEvent>(_addOrRemoveFavorite);

    on<SelectAProductEvent>(_selectAProduct);
  }

  void _getProducts(GetProductsEvent event, Emitter<HomeState> emit) async {
    emit(state.copywith(status: Status.loading));
    try {
      final products = await homeRepository.getProducts();
      if (products.isNotEmpty) {
        emit(state.copywith(status: Status.loaded, products: products));
        return;
      }
      final localProducts = await localRepository.getLocalData();

      if (localProducts.isNotEmpty) {
        emit(state.copywith(status: Status.loaded, products: localProducts));
        return;
      }

      emit(state.copywith(status: Status.error));
    } catch (e) {
      emit(state.copywith(status: Status.error));
    }
  }

  void _addOrRemoveFavorite(
      AddorRemoveFavoriteEvent event, Emitter<HomeState> emit) {
    final index = state.products!.indexWhere((e) => e.id == event.id);

    state.products![index] = state.products![index].toggleFavorites();

    emit(
      state.copywith(
          products: state.products!, product: state.products![index]),
    );
  }

  void _selectAProduct(SelectAProductEvent event, Emitter<HomeState> emit) {
    emit(state.copywith(product: event.product));
  }
}
