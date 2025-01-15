import '../../../../../config/database/local/tables_keys.dart';
import '../../../domain/entities/order.dart';
import '../cart/cart_item.dart';

class OrderItem {
  final String orderId;
  final String orderDate;
  final String orderStatus;
  final List<CartItem> cartItems;

  OrderItem(
      {required this.orderId,
      required this.orderDate,
      required this.orderStatus,
      required this.cartItems});

  factory OrderItem.convert(Order order) => OrderItem(
        orderId: order.orderId,
        orderDate: order.orderDate,
        orderStatus: order.orderStatus,
        cartItems: List<CartItem>.from(
            order.cartItems.map((x) => CartItem.convert(x))),
      );

  Map<String, dynamic> toJson() => {
        TablesKeys.orderId: orderId,
        TablesKeys.orderDate: orderDate,
        TablesKeys.orderStatus: orderStatus,
        TablesKeys.cartItemTable:
            cartItems.map((item) => item.toJson()).toList(),
      };
}
