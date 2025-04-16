import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/invoice_detail.dart';
import '../../../domain/entities/return_invoice_detail.dart';
import '../../../domain/usecases/get_invoice_detail_usecase.dart';
import '../../../domain/usecases/get_returned_invoice_detail_usecase.dart';

part 'invoice_detail_event.dart';
part 'invoice_detail_state.dart';

class InvoiceDetailBloc extends Bloc<InvoiceDetailEvent, InvoiceDetailState> {
  final GetInvoiceDetailUsecase _invoiceDetailUsecase;
  final GetReturnedInvoiceDetailUsecase _returnedInvoiceDetailUsecase;
  InvoiceDetailBloc(
      this._invoiceDetailUsecase, this._returnedInvoiceDetailUsecase)
      : super(InvoiceDetailInitial()) {
    on<GetInvoiceDetailEvent>((event, emit) async {
      final user = (await storage.getUser())!;
      emit(InvoiceDetailLoading());
      final result = await _invoiceDetailUsecase(event.invoiceId);
      await result.fold((failure) {
        emit(InvoiceDetailError(message: failure.message));
      }, (invoiceDetail) async {
        if (event.returnId != null) {
          final returnResult = await _returnedInvoiceDetailUsecase(
              ReturnedInvoiceParams(
                  branchId: user.defaultBranch, returnId: event.returnId!));
          await returnResult.fold(
            (failure) async =>
                emit(InvoiceDetailError(message: failure.message)),
            (returnedInvoiceDetail) async => emit(InvoiceDetailSuccess(
                invoiceDetail: invoiceDetail,
                returnedInvoiceDetail: returnedInvoiceDetail)),
          );
          return;
        }
        emit(InvoiceDetailSuccess(
            invoiceDetail: invoiceDetail, returnedInvoiceDetail: null));
      });
    });
  }
}
