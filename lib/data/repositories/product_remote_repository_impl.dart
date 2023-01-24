import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:thence_task/data/app_exceptions.dart';
import 'package:thence_task/data/repositories/local_repository_impl.dart';
import 'package:thence_task/domain/core/api_endpoints.dart';
import 'package:thence_task/data/model/product_model.dart';
import 'package:thence_task/domain/repositories/home_repositoy.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<List<ProductsModel>> getProducts() async {
    try {
      Response response = await Dio().get(ApiEndPoints.products);
      if (response.statusCode == 200) {
        List<ProductsModel> products = (response.data["data"] as List)
            .map((e) => ProductsModel.fromJson(e))
            .toList();
        await LocalRepositoryImpl()
            .storeHomeApiDataLocally(jsonEncode(response.data["data"]));
        return products;
      }
      return <ProductsModel>[];
    } catch (e) {
      AppExceptions.handleError(e);
      return <ProductsModel>[];
    }
  }
}
