part of 'payment_types_bloc.dart';

sealed class PaymentTypesEvent extends Equatable {
  const PaymentTypesEvent();

  @override
  List<Object> get props => [];
}

class GetPaymentTypesEvent extends PaymentTypesEvent {}
