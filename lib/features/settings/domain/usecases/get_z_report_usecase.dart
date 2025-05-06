import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/end_day_report.dart';
import '../repositories/settings_repository.dart';

class GetZReportUsecase
    extends UseCase<Either<Failure, List<EndDayReport>>, EndDayReportParams> {
  final SettingsRepository settingsRepository;

  GetZReportUsecase(this.settingsRepository);

  @override
  Future<Either<Failure, List<EndDayReport>>> call(
      EndDayReportParams params) async {
    return await settingsRepository.getEndDayReport(
      params.branchId,
      params.lineDate,
    );
  }
}

class EndDayReportParams {
  final String lineDate;
  final int branchId;

  EndDayReportParams({required this.lineDate, required this.branchId});
}
