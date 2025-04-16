part of 'invoice_detail_bloc.dart';

sealed class InvoiceDetailEvent extends Equatable {
  const InvoiceDetailEvent();

  @override
  List<Object> get props => [];
}

class GetInvoiceDetailEvent extends InvoiceDetailEvent {
  final String invoiceId;
  final int? returnId;
  const GetInvoiceDetailEvent(
      {required this.invoiceId, required this.returnId});
}
