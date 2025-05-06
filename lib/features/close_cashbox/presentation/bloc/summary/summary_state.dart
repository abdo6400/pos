part of 'summary_bloc.dart';

sealed class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object> get props => [];
}

class SummaryInitial extends SummaryState {}

class SummaryLoading extends SummaryState {}

class SummarySuccess extends SummaryState {
  final CashSale cashSaleSummary;
  final List<SaleSummary> salesSummary;
  final List<PaymentSummary> paymentsSummary;
  final SaleDate saleDate;

  SummarySuccess(
      {required this.cashSaleSummary,
      required this.salesSummary,
      required this.paymentsSummary,
      required this.saleDate,


      });
}

class SummaryError extends SummaryState {
  final String message;
  const SummaryError(this.message);
}
