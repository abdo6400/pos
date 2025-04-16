import 'package:dartz/dartz.dart';
import 'package:retail/core/usecases/use_case.dart';

import '../../../../config/database/error/failures.dart';
import '../entities/return_invoice.dart';
import '../repositories/sales_repository.dart';

class GetReturnedInvoicesUsecase extends UseCase<
    Either<Failure, List<ReturnInvoice>>, ReturnedInvoicesParams> {
  final SalesRepository _repository;

  GetReturnedInvoicesUsecase(this._repository);
  @override
  Future<Either<Failure, List<ReturnInvoice>>> call(
      ReturnedInvoicesParams params) {
    return _repository.getReturnedInvoices(
      branchId: params.branchId.toString(),
      userId: params.userId,
    );
  }
}

class ReturnedInvoicesParams {
  final String branchId;
  final int userId;

  ReturnedInvoicesParams(this.branchId, this.userId);
}
