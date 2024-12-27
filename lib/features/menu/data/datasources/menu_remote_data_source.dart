import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/api/end_points.dart';
import '../models/category_model.dart';

abstract class MenuRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  final ApiConsumer _apiConsumer;

  MenuRemoteDataSourceImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;
  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _apiConsumer.get(EndPoints.getAllCategories,
        queryParameters: {'paging.PageNumber': '32', 'paging.PageSize': '32'});
    return List<CategoryModel>.from(
        response.map((x) => CategoryModel.fromJson(x)));
  }
}
