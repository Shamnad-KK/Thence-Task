import 'package:thence_task/data/model/product_model.dart';

abstract class HomeRepository {
  Future<List<ProductsModel>> getProducts();
}
