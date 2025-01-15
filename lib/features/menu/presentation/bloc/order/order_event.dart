part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class GetOrdersEvent extends OrderEvent {}

class AddOrderEvent extends OrderEvent {
  final OrderItem orderItem;

  AddOrderEvent(this.orderItem);
}

class ClearOrdersEvent extends OrderEvent {}

class DeleteOrderEvent extends OrderEvent {
  final String orderId;

  DeleteOrderEvent(this.orderId);
}
