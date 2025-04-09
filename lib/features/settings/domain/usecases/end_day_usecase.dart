import 'package:dartz/dartz.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/settings_repository.dart';

class EndDayUsecase extends UseCase<Either<Failure, void>, EndDayParams> {
  final SettingsRepository repository;

  EndDayUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(EndDayParams data) {
    return repository.endDay(data.toJson());
  }
}

class EndDayParams {
  final String lineDate;
  final String closeTime;
  final String branchId;

  EndDayParams(
      {required this.lineDate,
      required this.closeTime,
      required this.branchId});

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.lineDate: lineDate,
      ApiKeys.closeTime: closeTime,
      ApiKeys.wareHouse: branchId,
    };
  }
}
