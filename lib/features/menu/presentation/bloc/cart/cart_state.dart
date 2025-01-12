part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> cart;
  final double totalPrice;
  final double totalTax;
  final double discount;
  final double grandTotal;

  const CartState({
    required this.cart,
    required this.totalPrice,
    required this.totalTax,
    required this.discount,
    required this.grandTotal,
  });

  CartState copyWith({
    List<CartItem>? cart,
    double? totalPrice,
    double? totalTax,
    double? discount,
    double? grandTotal,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      totalPrice: totalPrice ?? this.totalPrice,
      totalTax: totalTax ?? this.totalTax,
      discount: discount ?? this.discount,
      grandTotal: grandTotal ?? this.grandTotal,
    );
  }

  @override
  List<Object> get props => [cart, totalPrice, totalTax, discount, grandTotal];
}
