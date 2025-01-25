import 'package:dartz/dartz.dart';
import 'package:retail/core/usecases/use_case.dart';

import '../../../../config/database/error/failures.dart';
import '../entities/invoice.dart';
import '../repositories/sales_repository.dart';

class GetInvoicesUsecase
    extends UseCase<Either<Failure, List<Invoice>>, InvoicesParams> {
  final SalesRepository _repository;

  GetInvoicesUsecase(this._repository);
  @override
  Future<Either<Failure, List<Invoice>>> call(InvoicesParams params) {
    return _repository.getInvoices(
      branchId: params.branchId,
      startDate: params.startDate,
      endDate: params.endDate,
      userId: params.userId,
    );
  }
}

class InvoicesParams {
  final String branchId;
  final String startDate;
  final String endDate;
  final String userId;

  InvoicesParams(this.branchId, this.startDate, this.endDate, this.userId);
}
