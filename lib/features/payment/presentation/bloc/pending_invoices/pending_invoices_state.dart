part of 'pending_invoices_bloc.dart';

sealed class PendingInvoicesState extends Equatable {
  const PendingInvoicesState();
  
  @override
  List<Object> get props => [];
}

final class PendingInvoicesInitial extends PendingInvoicesState {}
