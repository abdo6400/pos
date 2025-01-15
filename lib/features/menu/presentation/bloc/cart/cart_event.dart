part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddCartsEvent extends CartEvent {
  final List<CartItem> cartItems;

  const AddCartsEvent({required this.cartItems});

  @override
  List<Object> get props => [cartItems];
}

class AddCartEvent extends CartEvent {
  final CartItem cartItem;

  const AddCartEvent({required this.cartItem});

  @override
  List<Object> get props => [cartItem];
}

class UpdateCartEvent extends CartEvent {
  final CartItem cartItem;

  const UpdateCartEvent({required this.cartItem});

  @override
  List<Object> get props => [cartItem];
}

class DeleteCartEvent extends CartEvent {
  final String productId;

  const DeleteCartEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class ClearCartEvent extends CartEvent {}
