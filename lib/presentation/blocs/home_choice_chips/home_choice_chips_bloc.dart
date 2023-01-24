import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_choice_chips_event.dart';
part 'home_choice_chips_state.dart';

class HomeChoiceChipsBloc
    extends Bloc<HomeChoiceChipsEvent, HomeChoiceChipsState> {
  HomeChoiceChipsBloc()
      : super(
          const HomeChoiceChipsState(
            selectedChipIndex: 0,
          ),
        ) {
    on<ChangeHomeChoiceChip>((event, emit) {
      emit(state.copyWith(selectedChipIndex: event.index));
    });
  }
}
