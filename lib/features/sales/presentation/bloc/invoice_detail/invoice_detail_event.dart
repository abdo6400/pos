part of 'invoice_detail_bloc.dart';

sealed class InvoiceDetailEvent extends Equatable {
  const InvoiceDetailEvent();

  @override
  List<Object> get props => [];
}

class GetInvoiceDetailEvent extends InvoiceDetailEvent {
  final String invoiceId;
  const GetInvoiceDetailEvent({required this.invoiceId});
}
