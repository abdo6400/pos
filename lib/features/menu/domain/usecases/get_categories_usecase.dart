import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/category.dart';
import '../repositories/menu_repository.dart';

class GetCategoriesUseCase
    extends UseCase<Either<Failure, List<Category>>, NoParams> {
  final MenuRepository _repository;
  GetCategoriesUseCase(this._repository);
  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) {
    return _repository.getCategories();
  }
}
