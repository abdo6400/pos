import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/cash.dart';
import '../../../../core/entities/sale_date.dart';
import '../entities/end_day_report.dart';
import '../entities/setting.dart';

abstract class SettingsRepository {
  Future<Either<Failure, List<Setting>>> getSettings(String branchId);
  Future<Either<Failure, SaleDate>> getSalesByWarehouse(String branchId);
  Future<Either<Failure, Cash>> getSalesByUser(int userId);
  Future<Either<Failure, List<Cash>>> getOpenedPointsByUser(
      String startDate, String branchId);
  Future<Either<Failure, void>> openPointByParameters(
      Map<String, dynamic> data);
  Future<Either<Failure, void>> insertByParameters(Map<String, dynamic> data);
  Future<Either<Failure, void>> endDay(Map<String, dynamic> data);
  Future<Either<Failure,List<EndDayReport>>> getEndDayReport(int branchId, String lineDate);
}
