part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> cart;
  final double totalPrice;

  const CartState({required this.cart, required this.totalPrice});

  CartState copyWith({
    List<CartItem>? cart,
    double? totalPrice,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object> get props => [cart, totalPrice];
}
