part of 'pay_bloc.dart';

sealed class PayEvent extends Equatable {
  const PayEvent();

  @override
  List<Object> get props => [];
}

class Pay extends PayEvent {
  final bool isPrint;
  final double exchangeAmount;
  final InvoiceParams invoiceParams;

  Pay({required this.isPrint,required this.invoiceParams,required this.exchangeAmount});
}
