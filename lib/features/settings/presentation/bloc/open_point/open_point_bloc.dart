import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/open_point_by_parameters_usecase.dart';

part 'open_point_event.dart';
part 'open_point_state.dart';

class OpenPointBloc extends Bloc<OpenPointEvent, OpenPointState> {
  final OpenPointByParametersUsecase _openPointByParametersUsecase;

  OpenPointBloc(this._openPointByParametersUsecase)
      : super(OpenPointInitial()) {
    on<OpenPointRequested>((event, emit) async {
      emit(OpenPointLoading());
      try {
        await _openPointByParametersUsecase(event.data);
        emit(OpenPointSuccess());
      } catch (e) {
        emit(OpenPointFailure(error: e.toString()));
      }
    });
  }
}
