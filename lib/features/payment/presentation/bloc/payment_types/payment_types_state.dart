part of 'payment_types_bloc.dart';

sealed class PaymentTypesState extends Equatable {
  const PaymentTypesState();

  @override
  List<Object> get props => [];
}

final class PaymentTypesInitial extends PaymentTypesState {}

class PaymentTypesLoading extends PaymentTypesState {}

class PaymentTypesSuccess extends PaymentTypesState {
  final List<PaymentType> paymentTypes;
  const PaymentTypesSuccess({required this.paymentTypes});
}

class PaymentTypesError extends PaymentTypesState {
  final String message;
  const PaymentTypesError({required this.message});
}
