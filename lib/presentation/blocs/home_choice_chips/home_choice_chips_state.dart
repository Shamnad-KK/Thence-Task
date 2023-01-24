part of 'home_choice_chips_bloc.dart';

class HomeChoiceChipsState {
  final int selectedChipIndex;
  final List<String> choiceChips;
  const HomeChoiceChipsState(
      {this.choiceChips = const [
        'All',
        'Succulents',
        'In pots',
        'Dried flowers',
      ],
      required this.selectedChipIndex});

  HomeChoiceChipsState copyWith({
    int? selectedChipIndex,
    List<String>? choiceChips,
  }) {
    return HomeChoiceChipsState(
      selectedChipIndex: selectedChipIndex ?? this.selectedChipIndex,
      choiceChips: choiceChips ?? this.choiceChips,
    );
  }
}
