import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/settings_repository.dart';
import '../../../../core/entities/sale_date.dart';

class GetSalesByWarehouseUsecase
    extends UseCase<Either<Failure, List<SaleDate>>, String> {
  final SettingsRepository repository;

  GetSalesByWarehouseUsecase(this.repository);

  @override
  Future<Either<Failure, List<SaleDate>>> call(String branchId) {
    return repository.getSalesByWarehouse(branchId);
  }
}
