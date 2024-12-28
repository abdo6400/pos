import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../entities/category.dart';
import '../entities/product.dart';

abstract class MenuRepository {
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<Product>>> getProducts(String branchId);
}
