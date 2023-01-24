import 'package:thence_task/data/model/product_model.dart';

abstract class LocalRepository {
  Future<bool> storeDataLocally(String data);

  Future<List<ProductsModel>> getLocalData();
}
