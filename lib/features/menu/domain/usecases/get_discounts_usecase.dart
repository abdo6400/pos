import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/discount.dart';
import '../repositories/menu_repository.dart';

class GetDiscountsUsecase
    extends UseCase<Either<Failure, List<Discount>>, String> {
  final MenuRepository _repository;

  GetDiscountsUsecase(this._repository);

  @override
  Future<Either<Failure, List<Discount>>> call(String params) {
    return _repository.getDiscounts(params);
  }
}
