import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/cash.dart';
import '../../../../core/entities/sale_date.dart';
import '../entities/setting.dart';

abstract class SettingsRepository {
  Future<Either<Failure, List<Setting>>> getSettings(String branchId);
  Future<Either<Failure, List<SaleDate>>> getSalesByWarehouse(String branchId);
  Future<Either<Failure, Cash>> getSalesByUser(int userId);
  Future<Either<Failure, void>> openPointByParameters(
      Map<String, dynamic> data);
  Future<Either<Failure, void>> endDay(Map<String, dynamic> data);
}
