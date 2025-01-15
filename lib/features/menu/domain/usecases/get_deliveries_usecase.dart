import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/delivery.dart';
import '../repositories/menu_repository.dart';

class GetDeliveriesUsecase
    extends UseCase<Either<Failure, List<Delivery>>, NoParams> {
  final MenuRepository _menuRepository;
  GetDeliveriesUsecase(this._menuRepository);
  @override
  Future<Either<Failure, List<Delivery>>> call(NoParams params) {
    return _menuRepository.getDeliveries();
  }
}
