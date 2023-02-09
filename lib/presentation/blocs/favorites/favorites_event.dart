part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {}

class AddorRemoveFavoriteEvent extends FavoritesEvent {
  final ProductsModel product;

  AddorRemoveFavoriteEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class StoreFavotitesDataEvent extends FavoritesEvent {
  @override
  List<Object?> get props => [];
}

class OnFavotitesInit extends FavoritesEvent {
  @override
  List<Object?> get props => [];
}
