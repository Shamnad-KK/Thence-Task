import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:thence_task/data/model/product_model.dart';
import 'package:thence_task/domain/repositories/local_repository.dart';

class LocalRepositoryImpl extends LocalRepository {
  @override
  Future<bool> storeDataLocally(String data) async {
    try {
      final sharedPreference = await SharedPreferences.getInstance();
      final prefs = await sharedPreference.setString('key', data);
      return prefs;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Future<List<ProductsModel>> getLocalData() async {
    try {
      final sharedPreference = await SharedPreferences.getInstance();
      final data = sharedPreference.getString('key');

      if (data == null) {
        return <ProductsModel>[];
      }

      final json = jsonDecode(data);

      final List<ProductsModel> products =
          (json as List).map((e) => ProductsModel.fromJson(e)).toList();

      return products;
    } catch (e) {
      log(e.toString());
    }
    return <ProductsModel>[];
  }
}
