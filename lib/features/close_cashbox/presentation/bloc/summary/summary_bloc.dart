import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/entities/sale_date.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../settings/domain/usecases/get_sales_by_warehouse_usecase.dart';
import '../../../domain/entities/cash_sale.dart';
import '../../../domain/entities/payment_summary.dart';
import '../../../domain/entities/sale_summary.dart';
import '../../../domain/usecases/get_cash_sale_summary_usecase.dart';
import '../../../domain/usecases/get_payments_summary_usecase.dart';
import '../../../domain/usecases/get_sales_summary_usecase.dart';

part 'summary_event.dart';
part 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final GetPaymentsSummaryUseCase _getPaymentsSummary;
  final GetCashSaleSummaryUsecase _cashSaleSummaryUsecase;
  final GetSalesSummaryUsecase _getSalesSummaryUsecase;
  final GetSalesByWarehouseUsecase _getSalesByWarehouseUsecase;
  SummaryBloc(this._getPaymentsSummary, this._cashSaleSummaryUsecase,
      this._getSalesSummaryUsecase, this._getSalesByWarehouseUsecase)
      : super(SummaryInitial()) {
    on<GetSummaryEvent>((event, emit) async {
      final user = (await storage.getUser())!;
      emit(SummaryLoading());
      final paymentSummary = await _getPaymentsSummary(GetPaymentsSummaryParams(
        event.userNo ?? user.userNo,
        user.defaultBranch,
      ));
      final cashSaleSummary = await _cashSaleSummaryUsecase(
        event.userNo ?? user.userNo,
      );
      final salesSummary = await _getSalesSummaryUsecase(
        event.userNo ?? user.userNo,
      );
      final saleDateSummery =
          await _getSalesByWarehouseUsecase(user.defaultBranch);

      paymentSummary.fold((l) => emit(SummaryError(l.message)),
          (paymentSummary) {
        cashSaleSummary.fold((l) => emit(SummaryError(l.message)),
            (cashSaleSummary) {
          salesSummary.fold((l) => emit(SummaryError(l.message)),
              (salesSummary) {
            saleDateSummery.fold((l) => emit(SummaryError(l.message)),
                (saleDateSummery) {
              emit(SummarySuccess(
                paymentsSummary: paymentSummary,
                cashSaleSummary: cashSaleSummary,
                salesSummary: salesSummary,
                saleDate: saleDateSummery,
              ));
            });
          });
        });
      });
    });
    ;
  }
}
