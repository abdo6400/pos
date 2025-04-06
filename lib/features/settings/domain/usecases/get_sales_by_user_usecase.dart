import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/settings_repository.dart';
import '../../../../core/entities/cash.dart';

class GetSalesByUserUsecase extends UseCase<Either<Failure, Cash>, int> {
  final SettingsRepository repository;

  GetSalesByUserUsecase(this.repository);

  @override
  Future<Either<Failure, Cash>> call(int userId) {
    return repository.getSalesByUser(userId);
  }
}
