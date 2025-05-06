import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/cash.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/payment_summary.dart';
import '../repositories/close_point_repository.dart';

class GetPaymentsSummaryUseCase extends UseCase<
    Either<Failure, List<PaymentSummary>>, GetPaymentsSummaryParams> {
  final ClosePointRepository _repository;

  GetPaymentsSummaryUseCase(this._repository);
  @override
  Future<Either<Failure, List<PaymentSummary>>> call(
      GetPaymentsSummaryParams params) async {
    final Cash? cash =
        (await _repository.getCash(params.userNo)).fold((l) => null, (r) => r);
    return _repository.getPaymentsSummary(
        cash?.cashNo.toString() ?? "1", params.wareHouse);
  }
}

class GetPaymentsSummaryParams {
  final int userNo;
  final String wareHouse;

  GetPaymentsSummaryParams(this.userNo, this.wareHouse);
}
