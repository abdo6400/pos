import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/pay_usecase.dart';

part 'pay_event.dart';
part 'pay_state.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  final PayUsecase _payUsecase;
  PayBloc(this._payUsecase) : super(PayInitial()) {
    on<Pay>((event, emit) async {
      emit(PayLoading());
      final result = await _payUsecase(event.invoiceParams);
      result.fold(
          (failure) => emit(PayError(message: failure.message)),
          (invoice) =>
              emit(PaySuccess(isPrint: event.isPrint, invoice: event.invoiceParams,invoiceNo: invoice)));
    });
  }
}
