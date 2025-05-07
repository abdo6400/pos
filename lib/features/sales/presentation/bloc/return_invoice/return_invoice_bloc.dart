import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/return_invoice_usecase.dart';
part 'return_invoice_event.dart';
part 'return_invoice_state.dart';

class ReturnInvoiceBloc extends Bloc<ReturnInvoiceEvent, ReturnInvoiceState> {
  final ReturnInvoiceUsecase _invoiceUsecase;
  ReturnInvoiceBloc(this._invoiceUsecase) : super(ReturnInvoiceInitial()) {
    on<ReturnedInvoice>((event, emit) async {
      emit(ReturnInvoiceLoading());
      final result = await _invoiceUsecase(event.params);
      emit(result.fold((failure) => ReturnInvoiceError(failure.message),
          (_) => ReturnInvoiceLoaded(event.params)));
    });
  }
}
