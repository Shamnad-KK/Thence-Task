// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class GetProductsEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class AddorRemoveFavoriteEvent extends HomeEvent {
  final int id;

  AddorRemoveFavoriteEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class SelectAProductEvent extends HomeEvent {
  final ProductsModel product;
  SelectAProductEvent({required this.product});
  @override
  List<Object?> get props => [product];
}
