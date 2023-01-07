import 'package:flutter/material.dart';
import 'package:thence_task/model/product_model.dart';
import 'package:thence_task/view/product_detail/product_detail_screen.dart';

class HomeController extends ChangeNotifier {
  int selectedChip = 0;
  List<String> choiceChips = [
    'All',
    'Succulents',
    'In pots',
    'Dried flowers',
  ];

  List<ProductModel> products = [
    ProductModel(
      name: 'Adromiscus',
      price: '16,5',
      rating: '4,5',
      image: 'assets/imgSucculent_1.png',
      sizes: ['16', '20', '24', '30'],
      bgColor: const Color.fromARGB(255, 225, 241, 250),
    ),
    ProductModel(
      name: 'Echeveria',
      price: '19,5',
      rating: '4,8',
      image: 'assets/scott-webb-WwWkgOMU8H8-unsplash-removebg 1.png',
      sizes: ['18', '20', '24', '30'],
      bgColor: const Color.fromARGB(255, 254, 239, 226),
    ),
  ];

  void changeChip(int index) {
    selectedChip = index;
    notifyListeners();
  }

  void gotoProductDetail(BuildContext context, ProductModel product) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetailScreen(product: product),
    ));
  }
}
