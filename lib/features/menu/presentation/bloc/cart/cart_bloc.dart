import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/cart_item.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../../domain/entities/offer.dart';
import '../../../domain/entities/product.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc()
      : super(CartState(
            cart: [],
            totalPrice: 0.0,
            totalTax: 0.0,
            discount: 0.0,
            grandTotal: 0.0)) {
    on<AddCartEvent>(
      _onAddCartItem,
      transformer: sequential(),
    );
    on<UpdateCartEvent>(
      _onUpdateCartItem,
      transformer: sequential(),
    );
    on<DeleteCartEvent>(
      _onDeleteCartItem,
      transformer: sequential(),
    );
    on<CalculateTotalPriceEvent>(
      _onCalculateTotalPrice,
      transformer: sequential(),
    );
    on<ClearCartEvent>(
      _onClearCart,
      transformer: sequential(),
    );
  }

  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    emit(CartState(
        cart: [],
        totalPrice: 0.0,
        totalTax: 0.0,
        discount: 0.0,
        grandTotal: 0.0));
  }

  void _onAddCartItem(AddCartEvent event, Emitter<CartState> emit) {
    final existingCartItem = state.cart.firstWhereOrNull((c) =>
        c.product.proId == event.cartItem.product.proId &&
        listEquals(c.flavors, event.cartItem.flavors) &&
        listEquals(c.questions, event.cartItem.questions) &&
        !c.isOffer);
    List<CartItem> newCart = [];
    if (existingCartItem != null) {
      newCart = state.cart.map((cartItem) {
        if (existingCartItem.id == cartItem.id) {
          return CartItem(
            id: cartItem.id,
            product: event.cartItem.product,
            quantity: cartItem.quantity + event.cartItem.quantity,
            flavors: event.cartItem.flavors,
            questions: event.cartItem.questions,
            note: event.cartItem.note,
            offers: cartItem.offers,
            orignialPrice: event.cartItem.orignialPrice,
          );
        }
        return cartItem;
      }).toList();
    } else {
      newCart = List<CartItem>.from(state.cart)..add(event.cartItem);
    }
    emit(state.copyWith(cart: _applyOffers(newCart)));
  }

  void _onUpdateCartItem(UpdateCartEvent event, Emitter<CartState> emit) {
    final itemToUpdate =
        state.cart.firstWhereOrNull((c) => c.id == event.cartItem.id);
    if (itemToUpdate != null) {
      final matchingItem = state.cart.firstWhereOrNull((c) =>
          c.product.proId == event.cartItem.product.proId &&
          listEquals(c.flavors, event.cartItem.flavors) &&
          listEquals(c.questions, event.cartItem.questions) &&
          !c.isOffer &&
          c.id != event.cartItem.id);
      List<CartItem> updatedCart = [];
      if (matchingItem != null) {
        // Merge quantities if a matching item is found
        updatedCart =
            state.cart.where((c) => c.id != event.cartItem.id).map((cartItem) {
          if (cartItem.id == matchingItem.id) {
            return CartItem(
              id: cartItem.id,
              product: event.cartItem.product.copyWith(
                  price: cartItem.orignialPrice,
                  price2: cartItem.orignialPrice,
                  price3: cartItem.orignialPrice,
                  price4: cartItem.orignialPrice),
              quantity: cartItem.quantity + event.cartItem.quantity,
              flavors: cartItem.flavors,
              questions: cartItem.questions,
              note: event.cartItem.note + "," + cartItem.note,
              offers: cartItem.offers,
              orignialPrice: cartItem.orignialPrice,
            );
          }
          return cartItem;
        }).toList();
      } else {
        // Update the item if no matching item is found
        updatedCart = state.cart.map((cartItem) {
          if (cartItem.id == itemToUpdate.id) {
            return CartItem(
              id: cartItem.id,
              product: event.cartItem.product.copyWith(
                  price: cartItem.orignialPrice,
                  price2: cartItem.orignialPrice,
                  price3: cartItem.orignialPrice,
                  price4: cartItem.orignialPrice),
              quantity: event.cartItem.quantity,
              flavors: event.cartItem.flavors,
              questions: event.cartItem.questions,
              note: event.cartItem.note,
              offers: event.cartItem.offers,
              orignialPrice: cartItem.orignialPrice,
            );
          }
          return cartItem;
        }).toList();
      }
      updatedCart = updatedCart.where((cartItem) {
        return !(cartItem.isOffer);
      }).toList();
      emit(state.copyWith(cart: _applyOffers(updatedCart)));
    }
  }

  void _onDeleteCartItem(DeleteCartEvent event, Emitter<CartState> emit) {
    final cartItemToDelete = state.cart.firstWhereOrNull(
      (cartItem) => cartItem.id == event.productId,
    );
    if (cartItemToDelete == null) return;
    final updatedCart =
        state.cart.where((cartItem) => cartItem.id != event.productId).toList();
    updatedCart.removeWhere((cartItem) =>
        cartItem.isOffer &&
        cartItem.extraItemId != null &&
        cartItem.extraItemId == cartItemToDelete.id);
    emit(state.copyWith(cart: updatedCart));
  }

  void _onCalculateTotalPrice(
      CalculateTotalPriceEvent event, Emitter<CartState> emit) {
    double finalTotalPrice = 0.0;
    double totalTax = 0.0;
    double totalDiscount = 0.0;
    double grandTotal = 0.0;

    for (final cartItem in state.cart) {
      final totalPriceAndTax = cartItem.calculateTotalPriceAndTax(
          taxPercentage: event.taxPercentage,
          priceIncludesTax: event.priceIncludesTax,
          discount: event.discount,
          taxIncludesDiscount: event.taxIncludesDiscount);
      finalTotalPrice += totalPriceAndTax.price;
      totalDiscount += totalPriceAndTax.discount;
      totalTax += totalPriceAndTax.tax;
      grandTotal += totalPriceAndTax.grandTotal;
    }
    emit(state.copyWith(
        totalPrice: finalTotalPrice,
        totalTax: totalTax,
        discount: totalDiscount,
        grandTotal: grandTotal));
  }

  List<CartItem> _applyOffers(List<CartItem> cart) {
    final List<CartItem> updatedCart = cart.map((cartItem) {
      if (cartItem.isOffer) return cartItem;

      final int quantity = cartItem.quantity;
      final List<Product> products = [cartItem.product, ...cartItem.questions];
      final List<Product> updatedProducts = [];

      for (final product in products) {
        Product updatedProduct = product;
        for (final offer in cartItem.offers) {
          if (offer.isActive &&
              offer.productId == product.proId &&
              DateTime.now().isBefore(offer.toDate)) {
            if (offer.priceOffer) {
              updatedProduct = _applyPriceOffer(offer, updatedProduct);
            }
            if (offer.qtyOffer && quantity >= offer.qty) {
              updatedProduct = _applyQtyOffer(offer, updatedProduct);
            }
          }
        }
        updatedProducts.add(updatedProduct);
      }

      return cartItem.copyWith(
        product: updatedProducts.first,
        questions: updatedProducts.skip(1).toList(),
      );
    }).toList();

    // Handle extra items
    final List<CartItem> updateCartWithExtraItems = List.from(updatedCart);

    for (final cartItem in updatedCart) {
      if (cartItem.isOffer) continue;

      for (final offer in cartItem.offers) {
        if (offer.isActive &&
            offer.productId == cartItem.product.proId &&
            DateTime.now().isBefore(offer.toDate) &&
            offer.extraOffer &&
            cartItem.quantity >= offer.qty) {
          final int q = (cartItem.quantity / offer.qty).floor();
          final CartItem? extraProduct = cart
              .firstWhereOrNull((c) => c.product.proId == offer.extraProduct);

          // Check if an extra item already exists for this parent item
          final existingExtraItem = updateCartWithExtraItems.firstWhereOrNull(
              (item) => item.isOffer && item.extraItemId == cartItem.id);

          if (existingExtraItem != null) {
            // If it exists, update its quantity
            final updatedExtraItem = existingExtraItem.copyWith(
              quantity:
                  q, // Recalculate quantity based on parent item's quantity
            );
            updateCartWithExtraItems.remove(existingExtraItem);
            updateCartWithExtraItems.add(updatedExtraItem);
          } else {
            // If it doesn't exist, add it to the list
            final extraItem = CartItem(
              id: Uuid().v4(),
              product: _applyExtraOffer(
                  offer, extraProduct?.product ?? cartItem.product),
              quantity: q,
              isOffer: true,
              flavors: [],
              questions: [],
              note: "",
              offers: [],
              orignialPrice: 0.0,
              extraItemId: cartItem.id, // Link to the parent item
            );
            updateCartWithExtraItems.add(extraItem);
          }
        }
      }
    }

    return updateCartWithExtraItems;
  }

  Product _applyPriceOffer(Offer offer, Product product) {
    Product offerProduct = product.copyWith(
      price: offer.price,
      price2: offer.price,
      price3: offer.price,
      price4: offer.price,
    );
    return offerProduct;
  }

  Product _applyQtyOffer(Offer offer, Product product) {
    double offerPricePerUnit = offer.price / offer.qty;
    Product offerProduct = product.copyWith(
        price: offerPricePerUnit,
        price2: offerPricePerUnit,
        price3: offerPricePerUnit,
        price4: offerPricePerUnit);
    return offerProduct;
  }

  Product _applyExtraOffer(Offer offer, Product product) {
    Product offerProduct = product.copyWith(
      proId: offer.productId,
      proArName: offer.extraProductAr,
      proEnName: offer.extraProductEn,
      icon: null,
      price: offer.price,
      price2: offer.price,
      price3: offer.price,
      price4: offer.price,
    );
    return offerProduct;
  }
}
