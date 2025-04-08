import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/cash_sale.dart';
import '../../../domain/entities/payment_summary.dart';
import '../../../domain/entities/sale_summary.dart';
import '../../../domain/usecases/get_cash_sale_summary_usecase.dart';
import '../../../domain/usecases/get_payments_summary.dart';
import '../../../domain/usecases/get_sales_summary_usecase.dart';

part 'summary_event.dart';
part 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final GetPaymentsSummaryUseCase _getPaymentsSummary;
  final GetCashSaleSummaryUsecase _cashSaleSummaryUsecase;
  final GetSalesSummaryUsecase _getSalesSummaryUsecase;
  SummaryBloc(this._getPaymentsSummary, this._cashSaleSummaryUsecase,
      this._getSalesSummaryUsecase)
      : super(SummaryInitial()) {
    on<GetSummaryEvent>((event, emit) async {
      final user = (await storage.getUser())!;
      emit(SummaryLoading());
      final paymentSummary = await _getPaymentsSummary(GetPaymentsSummaryParams(
        user.userNo,
        user.defaultBranch,
      ));
      final cashSaleSummary = await _cashSaleSummaryUsecase(
        user.userNo,
      );
      final salesSummary = await _getSalesSummaryUsecase(
        user.userNo,
      );

      paymentSummary.fold((l) => emit(SummaryError(l.message)),
          (paymentSummary) {
        cashSaleSummary.fold((l) => emit(SummaryError(l.message)),
            (cashSaleSummary) {
          salesSummary.fold((l) => emit(SummaryError(l.message)),
              (salesSummary) {
            emit(SummarySuccess(
              paymentsSummary: paymentSummary,
              cashSaleSummary: cashSaleSummary,
              salesSummary: salesSummary,
            ));
          });
        });
      });
    });
  }
}
