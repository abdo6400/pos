import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/entities/sale_date.dart';
import '../../domain/entities/cash_sale.dart';
import '../../domain/entities/payment_summary.dart';
import '../../domain/usecases/close_point_usecase.dart';

part 'close_cashbox_event.dart';
part 'close_cashbox_state.dart';

class CloseCashboxBloc extends Bloc<CloseCashboxEvent, CloseCashboxState> {
  final ClosePointUsecase _closePointUsecase;
  CloseCashboxBloc(this._closePointUsecase) : super(CloseCashboxInitial()) {
    on<ClosePointEvent>((event, emit) async {
      emit(CloseCashboxLoading());
      final result = await _closePointUsecase(event.closePointParams);
      result.fold(
          (l) => emit(CloseCashboxError(message: l.message)),
          (r) => emit(CloseCashboxSuccess(
              params: event.closePointParams,
              payments: event.payments,
              cashSaleSummary: event.cashSale,
              saleDate: event.saleDate)));
    });
  }
}
