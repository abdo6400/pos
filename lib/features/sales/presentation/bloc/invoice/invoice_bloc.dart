import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/invoice.dart';
import '../../../domain/usecases/get_invoices_usecase.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final GetInvoicesUsecase _getInvoicesUsecase;
  InvoiceBloc(this._getInvoicesUsecase) : super(InvoiceInitial()) {
    on<GetInvoicesEvent>((event, emit) async {
      emit(InvoicesLoading());
      final user = (await storage.getUser())!;
      final result = await _getInvoicesUsecase(InvoicesParams(
          int.parse(user.defaultBranch),
          event.fromDate,
          event.toDate,
          user.userNo));
      result.fold((failure) => emit(InvoicesError(failure.message)),
          (invoices) => emit(InvoicesSuccess(invoices)));
    });
  }
}
