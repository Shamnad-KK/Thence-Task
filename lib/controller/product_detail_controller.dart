import 'package:flutter/material.dart';

class ProductDetailController extends ChangeNotifier {
  int selectedChip = 0;

  void changeChip(int index) {
    selectedChip = index;
    notifyListeners();
  }
}
