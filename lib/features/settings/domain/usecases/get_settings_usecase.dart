import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/setting.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUsecase
    extends UseCase<Either<Failure, List<Setting>>, String> {
  final SettingsRepository _settingsRepository;

  GetSettingsUsecase(this._settingsRepository);
  @override
  Future<Either<Failure, List<Setting>>> call(String params) {
    return _settingsRepository.getSettings(params);
  }
}
