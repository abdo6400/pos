import '../../../../config/database/local/tables_keys.dart';
import '../../domain/entities/order.dart';
import 'cart_model.dart';

class OrderModel extends Order {
  OrderModel({
    required super.orderId,
    required super.orderDate,
    required super.orderStatus,
    required super.cartItems,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      TablesKeys.orderId: orderId,
      TablesKeys.orderDate: orderDate,
      TablesKeys.orderStatus: orderStatus,
      TablesKeys.cartItemTable: cartItems.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json[TablesKeys.orderId],
      orderDate: json[TablesKeys.orderDate],
      orderStatus: json[TablesKeys.orderStatus],
      cartItems: (json[TablesKeys.cartItemTable] as List)
          .map((item) => CartModel.fromJson(item))
          .toList(),
    );
  }
}
