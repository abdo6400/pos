part of 'pay_bloc.dart';

sealed class PayEvent extends Equatable {
  const PayEvent();

  @override
  List<Object> get props => [];
}

class Pay extends PayEvent {
  final InvoiceParams invoiceParams;

  Pay({required this.invoiceParams});
}
