import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thence_task/data/model/product_model.dart';
import 'package:thence_task/data/repositories/local_repository_impl.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final LocalRepositoryImpl localRepositoryImpl;
  FavoritesBloc({
    required this.localRepositoryImpl,
  }) : super(FavoritesState.initial()) {
    on<OnFavotitesInit>(_onFavoritesInit);

    on<AddorRemoveFavoriteEvent>(_addorRemoveItemToFavorite);

    on<StoreFavotitesDataEvent>(_storeFavoritesLocally);
  }

  //Getting all stored favorite products to list down at the starting of app
  void _onFavoritesInit(
    OnFavotitesInit event,
    Emitter<FavoritesState> emit,
  ) async {
    final favoritesList = await localRepositoryImpl.getFavoritesLocalData();
    if (favoritesList.isNotEmpty) {
      emit(
        state.copyWith(favoriteList: favoritesList),
      );
    }
  }

  void _addorRemoveItemToFavorite(
    AddorRemoveFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) {
    final ProductsModel product = event.product;

    //Getting the products index in favoriteList
    final int index = state.favoriteList!.indexWhere(
      (element) => element.id == product.id,
    );

    List<ProductsModel> favoriteList = state.favoriteList!.toList();

    //if product doesn't exist then adding to favoriteList
    if (index == -1) {
      favoriteList.add(product);
    } else {
      //otherwise removing from favorites
      favoriteList.removeAt(index);
    }

    emit(
      state.copyWith(favoriteList: favoriteList),
    );

    add(StoreFavotitesDataEvent());
  }

  //Method for storing all products inside the favoriteList to sharedPreferences
  void _storeFavoritesLocally(
    StoreFavotitesDataEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    await localRepositoryImpl.storeFavoritesDataLocally(state.favoriteList!
        .map(
          (e) => e.toJson(),
        )
        .toList());
  }
}
