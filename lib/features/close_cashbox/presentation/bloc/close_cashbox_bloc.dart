import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'close_cashbox_event.dart';
part 'close_cashbox_state.dart';

class CloseCashboxBloc extends Bloc<CloseCashboxEvent, CloseCashboxState> {
  CloseCashboxBloc() : super(CloseCashboxInitial()) {
    on<CloseCashboxEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
