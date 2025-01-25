import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/invoice_detail.dart';
import '../repositories/sales_repository.dart';

class GetInvoiceDetailUsecase
    extends UseCase<Either<Failure, InvoiceDetail>, String> {
  final SalesRepository _repository;

  GetInvoiceDetailUsecase(this._repository);
  @override
  Future<Either<Failure, InvoiceDetail>> call(String params) {
    return _repository.getInvoiceDetail(invoiceNo: params);
  }
}
