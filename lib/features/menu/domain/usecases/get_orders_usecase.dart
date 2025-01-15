import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/order.dart' as order;
import '../repositories/menu_repository.dart';

class GetOrdersUseCase
    extends UseCase<Either<Failure, List<order.Order>>, NoParams> {
  final MenuRepository _repository;
  GetOrdersUseCase(this._repository);
  Future<Either<Failure, List<order.Order>>> call(NoParams params) {
    return _repository.getOrders();
  }
}
