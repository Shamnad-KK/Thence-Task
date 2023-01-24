import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavState(currentIndex: 0)) {
    on<ChangeBottomNav>((event, emit) {
      emit(state.copyWith(currentIndex: event.newIndex));
    });
  }
}
