part of 'return_invoice_bloc.dart';

sealed class ReturnInvoiceEvent extends Equatable {
  const ReturnInvoiceEvent();

  @override
  List<Object> get props => [];
}

class ReturnedInvoice extends ReturnInvoiceEvent {
  final ReturnParams params;
  const ReturnedInvoice(this.params);
}
