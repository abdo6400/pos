import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/cash.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/sale_summary.dart';
import '../repositories/close_point_repository.dart';

class GetSalesSummaryUsecase
    extends UseCase<Either<Failure, List<SaleSummary>>, int> {
  final ClosePointRepository _repository;

  GetSalesSummaryUsecase(this._repository);
  @override
  Future<Either<Failure, List<SaleSummary>>> call(int params) async {
    final Cash? cash =
        (await _repository.getCash(params)).fold((l) => null, (r) => r);
    return _repository.getSalesSummary(cash?.cashNo.toString() ?? "1");
  }
}
