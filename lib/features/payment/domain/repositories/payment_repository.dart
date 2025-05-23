import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/cash.dart';
import '../entities/invoice_id.dart';
import '../entities/payment_type.dart';
import '../../../../core/entities/sale_date.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentType>>> getPaymentType();
  Future<Either<Failure, InvoiceId>> getLastInvoiceId(int branchId);
  Future<Either<Failure, String>> pay(Map<String, dynamic> data);
  Future<Either<Failure, Cash>> getCash(int userNo);
  Future<Either<Failure, SaleDate>> getSaleDate(int branchId);
  Future<Either<Failure, bool>> uploadPendingInvoices(int branchId, int userNo);
}
