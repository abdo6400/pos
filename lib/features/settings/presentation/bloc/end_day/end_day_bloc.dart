import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/end_day_report.dart';
import '../../../domain/usecases/end_day_usecase.dart';
import '../../../domain/usecases/get_z_report_usecase.dart';

part 'end_day_event.dart';
part 'end_day_state.dart';

class EndDayBloc extends Bloc<EndDayEvent, EndDayState> {
  final EndDayUsecase _endDayUsecase;
  final GetZReportUsecase _getZReportUsecase;

  EndDayBloc(this._endDayUsecase, this._getZReportUsecase)
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
      final resutlZReport = await _getZReportUsecase(EndDayReportParams(
          branchId: int.parse(branchId), lineDate: event.lineDate));
      result.fold((l) => emit(EndDayFailure(error: l.message)), (r) {
        return resutlZReport.fold(
            (l) => emit(EndDaySuccess(
                  endDayReports: [],
                )),
            (r) => emit(EndDaySuccess(endDayReports: r)));
      });
    });
  }
}
