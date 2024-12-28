import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/product.dart';
import '../repositories/menu_repository.dart';

class GetProductsUseCase
    extends UseCase<Either<Failure, List<Product>>, String> {
  final MenuRepository _repository;
  GetProductsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Product>>> call(String params) {
    return _repository.getProducts(params);
  }
}
