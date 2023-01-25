part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {}

class AddToFavoriteEvent extends FavoritesEvent {
  final ProductsModel product;

  AddToFavoriteEvent({required this.product});

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
