import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/entities/cash.dart';
import '../../../../../core/utils/constants.dart';
import '../../../domain/usecases/get_opened_points_usecase.dart';

part 'opened_points_event.dart';
part 'opened_points_state.dart';

class OpenedPointsBloc extends Bloc<OpenedPointsEvent, OpenedPointsState> {
  final GetOpenedPointsUsecase _getOpenedPointsUsecase;
  OpenedPointsBloc(this._getOpenedPointsUsecase)
      : super(OpenedPointsInitial()) {
    on<OpenedPointsRequested>((event, emit) async {
      emit(OpenedPointsLoading());
      final user = (await storage.getUser());
      final result = await _getOpenedPointsUsecase(
        GetOpenedPointsParams(user?.defaultBranch ?? "10010", event.startDate),
      );
      result.fold(
        (failure) => emit(OpenedPointsFailure(message: failure.message)),
        (openedPoints) => emit(OpenedPointsSuccess(openedPoints: openedPoints)),
      );
    });
  }
}
