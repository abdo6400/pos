import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/end_day_usecase.dart';

part 'end_day_event.dart';
part 'end_day_state.dart';

class EndDayBloc extends Bloc<EndDayEvent, EndDayState> {
  final EndDayUsecase _endDayUsecase;

  EndDayBloc(this._endDayUsecase) : super(EndDayInitial()) {
    on<EndDayRequested>((event, emit) async {
      emit(EndDayLoading());
      try {
        await _endDayUsecase(event.data);
        emit(EndDaySuccess());
      } catch (e) {
        emit(EndDayFailure(error: e.toString()));
      }
    });
  }
}
