import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/api/end_points.dart';
import '../models/category_model.dart';
import '../models/discount_model.dart';
import '../models/flavor_model.dart';
import '../models/product_model.dart';
import '../models/question_model.dart';

abstract class MenuRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getProducts(String branchId);
  Future<List<FlavorModel>> getFlavors();
  Future<List<QuestionModel>> getQuestions();
  Future<List<DiscountModel>> getDiscounts(String branchId);
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

  @override
  Future<List<FlavorModel>> getFlavors() async {
    final response = await _apiConsumer.get(EndPoints.getAllFlavors);
    return List<FlavorModel>.from(response.map((x) => FlavorModel.fromJson(x)));
  }

  @override
  Future<List<QuestionModel>> getQuestions() async {
    final response = await _apiConsumer.get(EndPoints.getItemQuestions);
    return List<QuestionModel>.from(
        response.map((x) => QuestionModel.fromJson(x)));
  }

  @override
  Future<List<DiscountModel>> getDiscounts(String branchId) async {
    final response = await _apiConsumer.get(EndPoints.getAllDiscounts,
        queryParameters: {
          ApiKeys.warehouse: branchId,
          ApiKeys.pageNumber: '32',
          ApiKeys.pageSize: '32'
        });
    return List<DiscountModel>.from(
        response.map((x) => DiscountModel.fromJson(x)));
  }
}
