import 'cart.dart';

abstract class Order {
  final String orderId;
  final String orderDate;
  final String orderStatus;
  final List<Cart> cartItems;
  Order(
      {required this.orderId,
      required this.orderDate,
      required this.orderStatus,
      required this.cartItems});

  Map<String, dynamic> toJson();
}
