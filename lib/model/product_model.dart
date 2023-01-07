import 'package:flutter/animation.dart';

class ProductModel {
  final String name;
  final String price;
  final String rating;
  final String image;
  final List<String> sizes;
  final Color bgColor;
  ProductModel({
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
    required this.sizes,
    required this.bgColor,
  });
}
