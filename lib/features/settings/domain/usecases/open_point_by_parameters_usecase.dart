import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/settings_repository.dart';

class OpenPointByParametersUsecase
    extends UseCase<Either<Failure, void>, Map<String, dynamic>> {
  final SettingsRepository repository;

  OpenPointByParametersUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(Map<String, dynamic> data) {
    return repository.openPointByParameters(data);
  }
}
