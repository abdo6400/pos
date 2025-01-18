import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../entities/payment_type.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentType>>> getPaymentType();
  Future<Either<Failure, String>> getLastInvoiceId(int branchId);
  Future<Either<Failure, void>> pay(Map<String, dynamic> data);
}
