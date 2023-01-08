import 'package:flutter/material.dart';
import 'package:thence_task/model/product_model.dart';
import 'package:thence_task/view/product_detail/product_detail_screen.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    setLoading();
  }
  bool isLoading = false;
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
      isFavorite: false,
    ),
    ProductModel(
      name: 'Echeveria',
      price: '19,5',
      rating: '4,8',
      image: 'assets/scott-webb-WwWkgOMU8H8-unsplash-removebg 1.png',
      sizes: ['18', '20', '24', '30'],
      bgColor: const Color.fromARGB(255, 254, 239, 226),
      isFavorite: false,
    ),
  ];

  List<ProductModel> productBelowBanner = [
    ProductModel(
      name: 'Haworthia',
      price: '22',
      rating: '4,2',
      image: 'assets/plant-3698820_1920-removebg-preview.png',
      sizes: ['19', '20', '24', '30'],
      bgColor: const Color.fromARGB(255, 254, 239, 226),
      isFavorite: false,
    ),
  ];

  void setLoading() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void addOrRemoveFavorite(ProductModel model) {
    model.isFavorite = !model.isFavorite;
    notifyListeners();
  }

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
