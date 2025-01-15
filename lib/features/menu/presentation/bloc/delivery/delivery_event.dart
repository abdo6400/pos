part of 'delivery_bloc.dart';

sealed class DeliveryEvent extends Equatable {
  const DeliveryEvent();

  @override
  List<Object> get props => [];
}

class GetDeliveriesEvent extends DeliveryEvent {}
