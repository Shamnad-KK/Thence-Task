import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/data/model/product_model.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(const ProductDetailState(selectedChipIndex: 0)) {
    on<ChangeProductDetailChoiceChipEvent>(_changeChoiceChip);
  }

  void _changeChoiceChip(
    ChangeProductDetailChoiceChipEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(state.copyWith(selectedChipIndex: event.index));
  }
}
