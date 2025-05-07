part of 'return_invoice_bloc.dart';

sealed class ReturnInvoiceState extends Equatable {
  const ReturnInvoiceState();

  @override
  List<Object> get props => [];
}

final class ReturnInvoiceInitial extends ReturnInvoiceState {}

class ReturnInvoiceLoading extends ReturnInvoiceState {}

class ReturnInvoiceLoaded extends ReturnInvoiceState {
  final ReturnParams  returnedInvoice;
  const ReturnInvoiceLoaded(this.returnedInvoice);
}

class ReturnInvoiceError extends ReturnInvoiceState {
  final String message;
  const ReturnInvoiceError(this.message);
}
