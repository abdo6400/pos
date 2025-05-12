part of 'pending_invoices_bloc.dart';

sealed class PendingInvoicesEvent extends Equatable {
  const PendingInvoicesEvent();

  @override
  List<Object> get props => [];
}

class PendingInvoicesEventUploaded extends PendingInvoicesEvent {}
