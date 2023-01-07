import 'package:flutter/material.dart';
import 'package:thence_task/view/home/home_screen.dart';

class BottomNavController extends ChangeNotifier {
  int currentIndex = 0;
  List<Widget> pages = const [
    HomeScreen(),
    Center(
      child: Text('Cart'),
    ),
    Center(
      child: Text('Favorites'),
    ),
    Center(
      child: Text('Profile'),
    ),
  ];

  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
