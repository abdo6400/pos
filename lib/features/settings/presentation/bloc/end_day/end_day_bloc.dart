import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/end_day_report.dart';
import '../../../domain/entities/report_summary.dart';
import '../../../domain/usecases/end_day_usecase.dart';
import '../../../domain/usecases/get_summary_by_line_id_usecase.dart';
import '../../../domain/usecases/get_z_report_usecase.dart';

part 'end_day_event.dart';
part 'end_day_state.dart';

class EndDayBloc extends Bloc<EndDayEvent, EndDayState> {
  final EndDayUsecase _endDayUsecase;
  final GetZReportUsecase _getZReportUsecase;
  final GetSummaryByLineIdUsecase _getSummaryByLineIdUsecase;

  EndDayBloc(this._endDayUsecase, this._getZReportUsecase,
      this._getSummaryByLineIdUsecase)
      : super(EndDayInitial()) {
    on<EndDayRequested>((event, emit) async {
      emit(EndDayLoading());
      final branchId = (await storage.getUser())?.defaultBranch ?? "1001";
      final params = EndDayParams(
        lineDate: event.lineDate,
        closeTime: DateTime.now().toIso8601String(),
        branchId: branchId,
      );
      final result = await _endDayUsecase(params);
      final resultSummary =
          await _getSummaryByLineIdUsecase(SummaryReportParams(
        branchId: int.parse(branchId),
        lineDate: event.lineDate,
      ));
      final resultZReport = await _getZReportUsecase(EndDayReportParams(
        branchId: int.parse(branchId),
        lineDate: event.lineDate,
      ));
      result.fold((l) => emit(EndDayFailure(error: l.message)), (r) {
        return resultZReport.fold(
          (l) => emit(EndDaySuccess(endDayReports: [], reportSummaries: [])),
          (endDayReports) {
            return resultSummary.fold(
              (l) =>
                  emit(EndDaySuccess(endDayReports: [], reportSummaries: [])),
              (reportSummaries) => emit(EndDaySuccess(
                endDayReports: endDayReports,
                reportSummaries: reportSummaries,
              )),
            );
          },
        );
      });
    });
  }
}
