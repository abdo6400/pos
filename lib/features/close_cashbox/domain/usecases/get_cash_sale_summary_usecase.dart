import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/cash.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/cash_sale.dart';
import '../repositories/close_point_repository.dart';

class GetCashSaleSummaryUsecase
    extends UseCase<Either<Failure, CashSale>, int> {
  final ClosePointRepository _repository;

  GetCashSaleSummaryUsecase(this._repository);
  @override
  Future<Either<Failure, CashSale>> call(int params) async {
    final Cash? cash =
        (await _repository.getCash(params)).fold((l) => null, (r) => r);

    return _repository.getCashSaleSummary(cash?.cashNo.toString() ?? "1");
  }
}
