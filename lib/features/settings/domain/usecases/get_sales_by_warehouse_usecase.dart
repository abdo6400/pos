import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/settings_repository.dart';
import '../../../../core/entities/sale_date.dart';

class GetSalesByWarehouseUsecase
    extends UseCase<Either<Failure, SaleDate>, String> {
  final SettingsRepository repository;

  GetSalesByWarehouseUsecase(this.repository);

  @override
  Future<Either<Failure, SaleDate>> call(String branchId) {
    return repository.getSalesByWarehouse(branchId);
  }
}
