part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {}

class SearchForProductsEvent extends SearchEvent {
  final String query;

  SearchForProductsEvent({
    required this.query,
  });
  @override
  List<Object> get props => [query];
}

class SearchInit extends SearchEvent {
  @override
  List<Object?> get props => [];
}
