part of 'bottom_nav_bloc.dart';

class BottomNavState {
  final int currentIndex;
  const BottomNavState({required this.currentIndex});

  BottomNavState copyWith({
    int? currentIndex,
  }) {
    return BottomNavState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
