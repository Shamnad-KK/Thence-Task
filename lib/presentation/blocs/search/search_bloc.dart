import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/data/model/product_model.dart';
import 'package:thence_task/presentation/blocs/home/home_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final HomeBloc homeBloc;
  SearchBloc({required this.homeBloc})
      : super(const SearchState(foundProducts: [])) {
    on<SearchForProductsEvent>(_searchForProduct);
    on<SearchInit>(_searchInit);
  }

  void _searchInit(SearchInit event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(
        foundProducts: homeBloc.state.products,
      ),
    );
  }

  void _searchForProduct(
    SearchForProductsEvent event,
    Emitter<SearchState> emit,
  ) {
    log('changed');
    final List<ProductsModel> allProducts = homeBloc.state.products!;
    emit(
      state.copyWith(
        foundProducts: allProducts
            .where(
              (element) => element.name!.toLowerCase().trim().contains(
                    event.query.trim().toLowerCase(),
                  ),
            )
            .toList(),
      ),
    );
  }
}
