import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../entities/invoice.dart';
import '../entities/invoice_detail.dart';
import '../entities/return_invoice.dart';
import '../entities/return_invoice_detail.dart';

abstract class SalesRepository {
  Future<Either<Failure, List<Invoice>>> getInvoices(
      {required String branchId,
      required String startDate,
      required String endDate,
      required String userId});

  Future<Either<Failure, InvoiceDetail>> getInvoiceDetail(
      {required String invoiceNo});

  Future<Either<Failure, void>> returnInvoice(Map<String, dynamic> data);

  Future<Either<Failure, List<ReturnInvoice>>> getReturnedInvoices({
    required String branchId,
    required int userId,
  });

  Future<Either<Failure, ReturnInvoiceDetail>> getReturnedInvoicesDetail({
    required int returnId,
    required String branchId,
  });
}
