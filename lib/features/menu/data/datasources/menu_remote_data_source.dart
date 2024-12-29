import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/api/end_points.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class MenuRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getProducts(String branchId);
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  final ApiConsumer _apiConsumer;

  MenuRemoteDataSourceImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;
  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _apiConsumer.get(EndPoints.getAllCategories,
        queryParameters: {ApiKeys.pageNumber: '32', ApiKeys.pageSize: '32'});
    return List<CategoryModel>.from(
        response.map((x) => CategoryModel.fromJson(x)));
  }

  @override
  Future<List<ProductModel>> getProducts(String branchId) async {
    final response = await _apiConsumer.get(EndPoints.getAllItems,
        queryParameters: {
          ApiKeys.warehouse: branchId,
          ApiKeys.pageNumber: '32',
          ApiKeys.pageSize: '32'
        });
    return List<ProductModel>.from(
        response.map((x) => ProductModel.fromJson(x)));
  }
}
