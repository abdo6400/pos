part of 'invoice_bloc.dart';

sealed class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object> get props => [];
}

final class InvoiceInitial extends InvoiceState {}

class InvoicesLoading extends InvoiceState {}

class InvoicesSuccess extends InvoiceState {
  final List<Invoice> invoices;
  const InvoicesSuccess(this.invoices);
}

class InvoicesError extends InvoiceState {
  final String message;
  const InvoicesError(this.message);
}
