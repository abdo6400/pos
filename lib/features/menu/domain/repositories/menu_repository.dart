import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../entities/category.dart';
import '../entities/flavor.dart';
import '../entities/product.dart';
import '../entities/question.dart';

abstract class MenuRepository {
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<Product>>> getProducts(String branchId);
  Future<Either<Failure, List<Flavor>>> getFlavors();
  Future<Either<Failure, List<Question>>> getQuestions();
}
