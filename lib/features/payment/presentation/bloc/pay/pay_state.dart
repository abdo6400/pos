part of 'pay_bloc.dart';

sealed class PayState extends Equatable {
  const PayState();

  @override
  List<Object> get props => [];
}

class PayInitial extends PayState {}

class PayLoading extends PayState {}

class PaySuccess extends PayState {
  final bool isPrint;
  final String invoiceNo;
  final double exChangeAmount;
  final InvoiceParams invoice;
  const PaySuccess(
      {required this.exChangeAmount,
      required this.isPrint,
      required this.invoice,
      required this.invoiceNo});
}

class PayError extends PayState {
  final String message;
  const PayError({required this.message});
}
