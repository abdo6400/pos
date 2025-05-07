import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/report_summary.dart';
import '../repositories/settings_repository.dart';

class GetSummaryByLineIdUsecase
    extends UseCase<Either<Failure, List<ReportSummary>>, SummaryReportParams> {
  final SettingsRepository settingsRepository;

  GetSummaryByLineIdUsecase(this.settingsRepository);

  @override
  Future<Either<Failure, List<ReportSummary>>> call(
      SummaryReportParams params) async {
    return await settingsRepository.getSummaryByLineId(
      params.branchId,
      params.lineDate,
    );
  }
}

class SummaryReportParams {
  final String lineDate;
  final int branchId;

  SummaryReportParams({required this.lineDate, required this.branchId});
}
