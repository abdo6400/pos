import '../../../../config/database/local/local_consumer.dart';
import '../../../../config/database/local/tables.dart';
import '../models/category_model.dart';
import '../models/flavor_model.dart';
import '../models/product_model.dart';
import '../models/question_model.dart';

abstract class MenuLocalDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getProducts();
  Future<List<FlavorModel>> getFlavors();
  Future<List<QuestionModel>> getQuestions();
  Future<void> insertCategories(List<Map<String, dynamic>> dataList);
  Future<void> insertProducts(List<Map<String, dynamic>> dataList);
  Future<void> insertFlavors(List<Map<String, dynamic>> dataList);
  Future<void> insertQuestions(List<Map<String, dynamic>> dataList);
  //Future<void> deleteAll(String table);
  //Future<void> insert(String table, Map<String, dynamic> data);
}

class MenuLocalDataSourceImpl extends MenuLocalDataSource {
  final LocalConsumer _localConsumer;

  MenuLocalDataSourceImpl({required LocalConsumer localConsumer})
      : _localConsumer = localConsumer;

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _localConsumer.queryAll(Tables.categoryTable);
    return List<CategoryModel>.from(
        response.map((x) => CategoryModel.fromJson(x)));
  }

  @override
  Future<List<FlavorModel>> getFlavors() async {
    final response = await _localConsumer.queryAll(Tables.flavorTable);
    return List<FlavorModel>.from(response.map((x) => FlavorModel.fromJson(x)));
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _localConsumer.queryAll(Tables.productsTable);
    return List<ProductModel>.from(
        response.map((x) => ProductModel.fromJson(x)));
  }

  @override
  Future<List<QuestionModel>> getQuestions() async {
    final response =
        await _localConsumer.queryAll(Tables.productQuestionsTable);
    return List<QuestionModel>.from(
        response.map((x) => QuestionModel.fromJson(x)));
  }

  @override
  Future<void> insertCategories(List<Map<String, dynamic>> dataList) async {
    await _localConsumer.refreshDataIfNeeded(Tables.categoryTable, dataList);
  }

  @override
  Future<void> insertFlavors(List<Map<String, dynamic>> dataList) async {
    await _localConsumer.refreshDataIfNeeded(Tables.flavorTable, dataList);
  }

  @override
  Future<void> insertProducts(List<Map<String, dynamic>> dataList) async {
    await _localConsumer.refreshDataIfNeeded(Tables.productsTable, dataList);
  }

  @override
  Future<void> insertQuestions(List<Map<String, dynamic>> dataList) async {
    await _localConsumer.refreshDataIfNeeded(
        Tables.productQuestionsTable, dataList);
  }
}
