part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class GetProductsEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class SelectAProductEvent extends HomeEvent {
  final ProductsModel product;
  SelectAProductEvent({required this.product});
  @override
  List<Object?> get props => [product];
}
