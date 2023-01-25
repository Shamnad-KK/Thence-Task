import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:thence_task/core/strings.dart';
import 'package:thence_task/data/model/cart_product_model.dart';
import 'package:thence_task/data/model/product_model.dart';
import 'package:thence_task/domain/repositories/local_repository.dart';

class LocalRepositoryImpl extends LocalRepository {
  @override
  Future<bool> storeHomeApiDataLocally(String data) async {
    try {
      final sharedPreference = await SharedPreferences.getInstance();
      final prefs = await sharedPreference.setString(
        AppStrings.homeApiResponse,
        data,
      );
      return prefs;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Future<List<ProductsModel>> getHomeLocalData() async {
    try {
      final sharedPreference = await SharedPreferences.getInstance();
      final data = sharedPreference.getString(
        AppStrings.homeApiResponse,
      );

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

  @override
  Future<bool> storeCartDataLocally(List<Map<String, dynamic>> data) async {
    try {
      final sharedPreference = await SharedPreferences.getInstance();
      final prefs = await sharedPreference.setString(
        AppStrings.cartProductResponse,
        jsonEncode(data),
      );
      return prefs;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Future<List<CartProductModel>> getCartLocalData() async {
    try {
      final sharedPreference = await SharedPreferences.getInstance();
      final data = sharedPreference.getString(
        AppStrings.cartProductResponse,
      );

      if (data == null) {
        return <CartProductModel>[];
      }

      final json = jsonDecode(data);

      List<CartProductModel> localCartData =
          (json as List).map((e) => CartProductModel.fromJson(e)).toList();

      return localCartData;
    } catch (e) {
      log(e.toString());
    }
    return <CartProductModel>[];
  }

  @override
  Future<bool> storeFavoritesDataLocally(
      List<Map<String, dynamic>> data) async {
    try {
      final sharedPreference = await SharedPreferences.getInstance();
      final prefs = await sharedPreference.setString(
        AppStrings.favoriteProductResponse,
        jsonEncode(data),
      );
      return prefs;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  @override
  Future<List<ProductsModel>> getFavoritesLocalData() async {
    try {
      final sharedPreference = await SharedPreferences.getInstance();
      final data = sharedPreference.getString(
        AppStrings.favoriteProductResponse,
      );

      if (data == null) {
        return <ProductsModel>[];
      }
      log(data.toString());

      final json = jsonDecode(data);

      List<ProductsModel> localCartData =
          (json as List).map((e) => ProductsModel.fromJson(e)).toList();

      log(localCartData.length.toString());
      return localCartData;
    } catch (e) {
      log(e.toString());
    }
    return <ProductsModel>[];
  }
}
