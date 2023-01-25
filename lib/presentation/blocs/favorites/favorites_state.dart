// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  final List<ProductsModel>? favoriteList;
  const FavoritesState({
    this.favoriteList,
  });

  factory FavoritesState.initial() {
    return const FavoritesState(
      favoriteList: [],
    );
  }
  FavoritesState copyWith({
    List<ProductsModel>? favoriteList,
  }) {
    return FavoritesState(
      favoriteList: favoriteList ?? this.favoriteList,
    );
  }

  @override
  List<Object?> get props => [favoriteList];
}
