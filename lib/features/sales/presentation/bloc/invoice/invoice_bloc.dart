import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/invoice.dart';
import '../../../domain/entities/return_invoice.dart';
import '../../../domain/usecases/get_invoices_usecase.dart';
import '../../../domain/usecases/get_returned_invoices_usecase.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final GetInvoicesUsecase _getInvoicesUsecase;
  final GetReturnedInvoicesUsecase _getReturnedInvoicesUsecase;
  InvoiceBloc(this._getInvoicesUsecase, this._getReturnedInvoicesUsecase)
      : super(InvoiceInitial()) {
    on<GetInvoicesEvent>((event, emit) async {
      emit(InvoicesLoading());
      final user = (await storage.getUser())!;
      final result = await _getInvoicesUsecase(InvoicesParams(
          int.parse(user.defaultBranch),
          event.fromDate,
          event.toDate,
          user.userNo));

      await result.fold(
        (failure) async => emit(InvoicesError(failure.message)),
        (invoices) async {
          final returnResult = await _getReturnedInvoicesUsecase(
              ReturnedInvoicesParams(user.defaultBranch, user.userNo));
          await returnResult.fold(
            (failure) async => emit(InvoicesError(failure.message)),
            (returnInvoices) async =>
                emit(InvoicesSuccess(invoices, returnInvoices)),
          );
        },
      );
    });
  }
}
