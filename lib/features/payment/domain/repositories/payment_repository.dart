import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../entities/cash.dart';
import '../entities/invoice.dart';
import '../entities/invoice_id.dart';
import '../entities/payment_type.dart';
import '../entities/sale_date.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentType>>> getPaymentType();
  Future<Either<Failure, InvoiceId>> getLastInvoiceId(int branchId);
  Future<Either<Failure, void>> pay(Map<String, dynamic> data);
  Future<Either<Failure, Cash>> getCash(int userNo);
  Future<Either<Failure, SaleDate>> getSaleDate(int branchId);
  Future<Either<Failure, List<Invoice>>> getPendingInvoices();
}
