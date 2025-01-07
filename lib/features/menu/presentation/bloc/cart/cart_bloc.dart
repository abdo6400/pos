import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/cart_item.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(cart: [], totalPrice: 0.0)) {
    on<AddCartEvent>(
      _onAddCartItem,
      transformer: concurrent(),
    );
    on<UpdateCartEvent>(
      _onUpdateCartItem,
      transformer: concurrent(),
    );
    on<DeleteCartEvent>(
      _onDeleteCartItem,
      transformer: concurrent(),
    );
    on<CalculateTotalPriceEvent>(
      _onCalculateTotalPrice,
      transformer: concurrent(),
    );
  }

  void _onAddCartItem(AddCartEvent event, Emitter<CartState> emit) {
    final existingCart = state.cart
        .where((c) => c.product.proId == event.cartItem.product.proId)
        .toList();

    if (existingCart.isNotEmpty) {
      final updatedCart = state.cart.map((cartItem) {
        if (cartItem.product.proId == event.cartItem.product.proId) {
          return CartItem(
            product: event.cartItem.product,
            quantity: cartItem.quantity + event.cartItem.quantity,
            flavors: event.cartItem.flavors,
            questions: event.cartItem.questions,
          );
        }
        return cartItem;
      }).toList();
      emit(state.copyWith(cart: updatedCart));
    } else {
      final newCart = List<CartItem>.from(state.cart)..add(event.cartItem);
      emit(state.copyWith(cart: newCart));
    }
    add(CalculateTotalPriceEvent());
  }

  void _onUpdateCartItem(UpdateCartEvent event, Emitter<CartState> emit) {
    final updatedCart = state.cart.map((cartItem) {
      if (cartItem.product.proId == event.cartItem.product.proId) {
        return CartItem(
          product: cartItem.product,
          quantity: event.cartItem.quantity,
          flavors: event.cartItem.flavors,
          questions: event.cartItem.questions,
        );
      }
      return cartItem;
    }).toList();
    emit(state.copyWith(cart: updatedCart));
    add(CalculateTotalPriceEvent());
  }

  void _onDeleteCartItem(DeleteCartEvent event, Emitter<CartState> emit) {
    final updatedCart = state.cart
        .where((cartItem) => cartItem.product.proId != event.productId)
        .toList();
    emit(state.copyWith(cart: updatedCart));
    add(CalculateTotalPriceEvent());
  }

  void _onCalculateTotalPrice(
      CalculateTotalPriceEvent event, Emitter<CartState> emit) {
    final totalPrice = state.cart.fold(0.0, (sum, cartItem) {
      return sum + (cartItem.product.price * cartItem.quantity);
    });
    emit(state.copyWith(totalPrice: totalPrice));
  }
}
