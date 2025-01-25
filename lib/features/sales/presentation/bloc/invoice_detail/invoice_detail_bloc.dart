import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/invoice_detail.dart';
import '../../../domain/usecases/get_invoice_detail_usecase.dart';

part 'invoice_detail_event.dart';
part 'invoice_detail_state.dart';

class InvoiceDetailBloc extends Bloc<InvoiceDetailEvent, InvoiceDetailState> {
  final GetInvoiceDetailUsecase _invoiceDetailUsecase;
  InvoiceDetailBloc(this._invoiceDetailUsecase)
      : super(InvoiceDetailInitial()) {
    on<GetInvoiceDetailEvent>((event, emit) async {
      emit(InvoiceDetailLoading());
      final result = await _invoiceDetailUsecase(event.invoiceId);
      result.fold((failure) {
        emit(InvoiceDetailError(message: failure.message));
      }, (invoiceDetail) {
        emit(InvoiceDetailSuccess(invoiceDetail: invoiceDetail));
      });
    });
  }
}
