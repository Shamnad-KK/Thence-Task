import 'package:thence_task/data/model/cart_product_model.dart';
import 'package:thence_task/data/model/product_model.dart';

abstract class LocalRepository {
  Future<bool> storeHomeApiDataLocally(String data);

  Future<List<ProductsModel>> getHomeLocalData();

  Future<bool> storeCartDataLocally(List<Map<String, dynamic>> data);

  Future<List<CartProductModel>> getCartLocalData();

  Future<bool> storeFavoritesDataLocally(List<Map<String, dynamic>> data);

  Future<List<ProductsModel>> getFavoritesLocalData();
}
