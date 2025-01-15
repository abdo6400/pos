import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/menu_repository.dart';

class InsertOrderUseCase extends UseCase<Either, Map<String, dynamic>> {
  final MenuRepository _repository;
  InsertOrderUseCase(this._repository);
  @override
  Future<Either<Failure, void>> call(Map<String, dynamic> params) {
    return _repository.addOrder(params);
  }
}
