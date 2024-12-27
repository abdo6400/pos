import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../entities/category.dart';

abstract class MenuRepository {
  Future<Either<Failure, List<Category>>> getCategories();
}
