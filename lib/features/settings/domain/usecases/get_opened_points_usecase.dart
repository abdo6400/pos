import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/settings_repository.dart';
import '../../../../core/entities/cash.dart';

class GetOpenedPointsUsecase
    extends UseCase<Either<Failure, List<Cash>>, GetOpenedPointsParams> {
  final SettingsRepository repository;

  GetOpenedPointsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Cash>>> call(GetOpenedPointsParams params) {
    return repository.getOpenedPointsByUser(params.startDate, params.branchId);
  }
}

class GetOpenedPointsParams {
  final String branchId;
  final String startDate;

  GetOpenedPointsParams(this.branchId, this.startDate);
}
