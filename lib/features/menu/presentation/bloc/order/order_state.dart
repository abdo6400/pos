part of 'order_bloc.dart';

class OrderState extends Equatable {
  final List<OrderItem> orders;
  final bool isLoading;
  final String? errorMessage;
  OrderState(
      {this.orders = const [], this.errorMessage, this.isLoading = false});

  OrderState copyWith({List<OrderItem>? orders, String? errorMessage}) =>
      OrderState(
          orders: orders ?? this.orders,
          errorMessage: errorMessage,
          isLoading: isLoading);

  @override
  List<Object> get props => [orders, errorMessage ?? '', isLoading];
}
