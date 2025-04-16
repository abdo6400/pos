import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/return_invoice_detail.dart';
import '../repositories/sales_repository.dart';

class GetReturnedInvoiceDetailUsecase
    extends UseCase<Either<Failure, ReturnInvoiceDetail>, ReturnedInvoiceParams> {
  final SalesRepository _repository;

  GetReturnedInvoiceDetailUsecase(this._repository);
  @override
  Future<Either<Failure, ReturnInvoiceDetail>> call(
      ReturnedInvoiceParams params) {
    return _repository.getReturnedInvoicesDetail(
      returnId: params.returnId,
      branchId: params.branchId,
    );
  }
}

class ReturnedInvoiceParams {
  final int returnId;
  final String branchId;

  ReturnedInvoiceParams({required this.returnId, required this.branchId});
}
