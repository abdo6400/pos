part of 'delivery_bloc.dart';

sealed class DeliveryState extends Equatable {
  const DeliveryState();

  @override
  List<Object> get props => [];
}

final class DeliveryInitial extends DeliveryState {}

class DeliveryLoading extends DeliveryState {}

class DeliverySuccess extends DeliveryState {
  final List<Delivery> deliveries;

  const DeliverySuccess(this.deliveries);
}

class DeliveryError extends DeliveryState {
  final String message;

  const DeliveryError(this.message);
}
