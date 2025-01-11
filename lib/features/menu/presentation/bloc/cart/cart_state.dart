part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> cart;
  final double totalPrice;
  final double totalTax;
  final double serviceCharge;
  final double serviceChargeTax;

  const CartState(
      {required this.cart,
      required this.totalPrice,
      required this.totalTax,
      required this.serviceCharge,
      required this.serviceChargeTax});

  CartState copyWith(
      {List<CartItem>? cart,
      double? totalPrice,
      double? totalTax,
      double? serviceCharge,
      double? serviceChargeTax}) {
    return CartState(
      cart: cart ?? this.cart,
      totalPrice: totalPrice ?? this.totalPrice,
      totalTax: totalTax ?? this.totalTax,
      serviceCharge: serviceCharge ?? this.serviceCharge,
      serviceChargeTax: serviceChargeTax ?? this.serviceChargeTax,
    );
  }

  @override
  List<Object> get props =>
      [cart, totalPrice, totalTax, serviceCharge, serviceChargeTax];
}
