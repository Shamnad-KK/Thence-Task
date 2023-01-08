import 'package:flutter/material.dart';

class AppColors {
  static const black = Colors.black;
  static const red = Colors.red;
  static const bodyGreyText = Color(0xFF999999);
  static const white = Colors.white;
  static const bgColor = Color(0xFFFFFFFF);
  static const selectedChip = Color(0xFFB08888);
  static const unselectedChip = Color(0xFFF4F4F4);
  static const shimmer = Color.fromARGB(205, 244, 244, 244);
  static const shimmerHighlight = Color.fromARGB(205, 240, 236, 236);
  static const productDetailBg = LinearGradient(
    colors: [
      Colors.white,
      Color(0xFFF4F4F4),
      Color(0xFFF4F4F4),
      Color(0xFFF4F4F4),
      Color.fromARGB(186, 244, 244, 244),
    ],
    begin: Alignment.center,
    end: Alignment.bottomCenter,
  );
  static const appbarTitle = Colors.black;
  static const rating = Color(0xFFFFBB56);
  static const homeBanner = LinearGradient(
    colors: [
      Color(0xFFE5ECF2),
      Color(0xFFFDE6D0),
    ],
  );
}
