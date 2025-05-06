part of 'close_cashbox_bloc.dart';

abstract class CloseCashboxEvent extends Equatable {
  const CloseCashboxEvent();

  @override
  List<Object> get props => [];
}

class ClosePointEvent extends CloseCashboxEvent {
  final ClosePointParams closePointParams;
  final List<PaymentSummary> payments;
  final CashSale cashSale;
  final SaleDate saleDate;
  const ClosePointEvent({required this.closePointParams, required this.payments,required this.cashSale,required this.saleDate});
}
