import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/flavor.dart';
import '../repositories/menu_repository.dart';

class GetFlavorsUsecase
    extends UseCase<Either<Failure, List<Flavor>>, NoParams> {
  final MenuRepository _repository;

  GetFlavorsUsecase(this._repository);
  @override
  Future<Either<Failure, List<Flavor>>> call(NoParams params) {
    return _repository.getFlavors();
  }
}
