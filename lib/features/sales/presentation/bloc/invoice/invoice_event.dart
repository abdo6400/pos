part of 'invoice_bloc.dart';

sealed class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object> get props => [];
}

class GetInvoicesEvent extends InvoiceEvent {
  final String fromDate;
  final String toDate;

  GetInvoicesEvent(this.fromDate, this.toDate);
}
