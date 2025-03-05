import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/cash.dart';
import '../entities/cash_sale.dart';
import '../entities/payment_summary.dart';
import '../entities/sale_summary.dart';

abstract class ClosePointRepository {
  Future<Either<Failure, void>> closePoint(Map<String, dynamic> data);
  Future<Either<Failure, List<PaymentSummary>>> getPaymentsSummary(
      String cashNo, String wareHouse);
  Future<Either<Failure, CashSale>> getCashSaleSummary(String cashNo);
  Future<Either<Failure, List<SaleSummary>>> getSalesSummary(String cashNo);
  Future<Either<Failure, Cash>> getCash(int userNo);
}
