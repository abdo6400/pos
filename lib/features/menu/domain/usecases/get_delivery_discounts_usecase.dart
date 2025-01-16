import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/delivery_discount.dart';
import '../repositories/menu_repository.dart';

class GetDeliveryDiscountsUsecase
    extends UseCase<Either<Failure, List<DeliveryDiscount>>, NoParams> {
  final MenuRepository _repository;

  GetDeliveryDiscountsUsecase(this._repository);
  @override
  Future<Either<Failure, List<DeliveryDiscount>>> call(NoParams params) {
    return _repository.getDeliveryDiscounts();
  }
}
