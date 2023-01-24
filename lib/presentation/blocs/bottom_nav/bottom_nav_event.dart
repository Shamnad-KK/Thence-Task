part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {}

class ChangeBottomNav extends BottomNavEvent {
  final int newIndex;
  ChangeBottomNav({required this.newIndex});
  @override
  List<Object> get props => [newIndex];
}
