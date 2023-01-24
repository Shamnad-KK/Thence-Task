part of 'home_choice_chips_bloc.dart';

abstract class HomeChoiceChipsEvent extends Equatable {}

class ChangeHomeChoiceChip extends HomeChoiceChipsEvent {
  final int index;
  ChangeHomeChoiceChip({required this.index});

  @override
  List<Object> get props => [index];
}
