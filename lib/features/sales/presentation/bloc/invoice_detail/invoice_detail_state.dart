part of 'invoice_detail_bloc.dart';

sealed class InvoiceDetailState extends Equatable {
  const InvoiceDetailState();

  @override
  List<Object> get props => [];
}

final class InvoiceDetailInitial extends InvoiceDetailState {}

class InvoiceDetailLoading extends InvoiceDetailState {}

class InvoiceDetailSuccess extends InvoiceDetailState {
  final InvoiceDetail invoiceDetail;
  final ReturnInvoiceDetail? returnedInvoiceDetail;
  const InvoiceDetailSuccess(
      {required this.invoiceDetail, required this.returnedInvoiceDetail});
}

class InvoiceDetailError extends InvoiceDetailState {
  final String message;
  const InvoiceDetailError({required this.message});
}
