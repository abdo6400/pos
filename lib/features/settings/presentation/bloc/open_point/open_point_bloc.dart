import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants.dart';
import '../../../domain/usecases/open_point_by_parameters_usecase.dart';

part 'open_point_event.dart';
part 'open_point_state.dart';

class OpenPointBloc extends Bloc<OpenPointEvent, OpenPointState> {
  final OpenPointByParametersUsecase _openPointByParametersUsecase;

  OpenPointBloc(this._openPointByParametersUsecase)
      : super(OpenPointInitial()) {
    on<OpenPointRequested>((event, emit) async {
      emit(OpenPointLoading());
      final user = (await storage.getUser());
      final result = await _openPointByParametersUsecase(OpenPointParams(
        userNo: user?.userNo ?? 1,
        branchId: user?.defaultBranch ?? "10010",
      ));
      result.fold(
        (failure) {
          emit(OpenPointFailure(error: failure.message));
        },
        (success) {
          emit(OpenPointSuccess());
        },
      );
    });
  }
}
