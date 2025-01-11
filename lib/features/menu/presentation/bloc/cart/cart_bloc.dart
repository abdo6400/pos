import 'dart:convert';

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
            serviceCharge: 0.0,
            serviceChargeTax: 0.0)) {
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
    final existingCartItem = state.cart.firstWhereOrNull((c) =>
        c.product.proId == event.cartItem.product.proId &&
        listEquals(c.flavors, event.cartItem.flavors) &&
        listEquals(c.questions, event.cartItem.questions) &&
        !c.isOffer);
    if (existingCartItem != null) {
      final updatedCart = state.cart.map((cartItem) {
        if (existingCartItem.id == cartItem.id) {
          return CartItem(
            id: cartItem.id,
            product: event.cartItem.product,
            quantity: cartItem.quantity + event.cartItem.quantity,
            flavors: event.cartItem.flavors,
            questions: event.cartItem.questions,
            note: event.cartItem.note,
            offers: cartItem.offers,
          );
        }
        return cartItem;
      }).toList();
      emit(state.copyWith(cart: updatedCart));
    } else {
      final newCart = List<CartItem>.from(state.cart)..add(event.cartItem);
      emit(state.copyWith(cart: newCart));
    }

    _applyOffers(emit);
    // add(CalculateTotalPriceEvent());
  }

  void _onUpdateCartItem(UpdateCartEvent event, Emitter<CartState> emit) {
    final itemToUpdate =
        state.cart.firstWhereOrNull((c) => c.id == event.cartItem.id);
    if (itemToUpdate != null) {
      final matchingItem = state.cart.firstWhereOrNull((c) =>
          c.product.proId == event.cartItem.product.proId &&
          c.flavors == event.cartItem.flavors &&
          c.questions == event.cartItem.questions &&
          c.id != event.cartItem.id);
      if (matchingItem != null) {
        final updatedCart =
            state.cart.where((c) => c.id != event.cartItem.id).map((cartItem) {
          if (cartItem.id == matchingItem.id) {
            return CartItem(
              id: cartItem.id,
              product: cartItem.product,
              quantity: cartItem.quantity + event.cartItem.quantity,
              flavors: cartItem.flavors,
              questions: cartItem.questions,
              note: event.cartItem.note,
              offers: cartItem.offers,
            );
          }
          return cartItem;
        }).toList();
        emit(state.copyWith(cart: updatedCart));
      } else {
        final updatedCart = state.cart.map((cartItem) {
          if (cartItem.id == event.cartItem.id) {
            return CartItem(
              id: cartItem.id,
              product: cartItem.product,
              quantity: event.cartItem.quantity,
              flavors: event.cartItem.flavors,
              questions: event.cartItem.questions,
              note: event.cartItem.note,
              offers: cartItem.offers,
            );
          }
          return cartItem;
        }).toList();
        emit(state.copyWith(cart: updatedCart));
      }
    }
    _applyOffers(emit);
    // add(CalculateTotalPriceEvent());
  }

  void _onDeleteCartItem(DeleteCartEvent event, Emitter<CartState> emit) {
    // Find the cart item to delete
    final cartItemToDelete = state.cart.firstWhereOrNull(
      (cartItem) => cartItem.id == event.productId,
    );
    // If the cart item is not found, return
    if (cartItemToDelete == null) return;
    // Remove the cart item
    final updatedCart =
        state.cart.where((cartItem) => cartItem.id != event.productId).toList();
    // If the deleted item has an extra item, remove it as well
    updatedCart.removeWhere((cartItem) =>
        cartItem.isOffer &&
        cartItem.extraItemId != null &&
        cartItem.extraItemId == cartItemToDelete.id);
    emit(state.copyWith(cart: updatedCart));
    // add(CalculateTotalPriceEvent());
  }

  final test = [
    {
      "SettingId": 3,
      "SettingArdesc": "السعر شامل الضريبة",
      "SettingEndesc": "Price Include Tax",
      "Value1": "",
      "Value2": 0.0,
      "Value3": 0.0,
      "Value4": true,
      "Value5": "1900-01-01T00:00:00",
      "Visible": true,
      "GroupTypeAr": "Apps",
      "GroupTypeEn": "Apps"
    },
    {
      "SettingId": 5,
      "SettingArdesc": "Tax include discount",
      "SettingEndesc": "Tax include discount",
      "Value1": "",
      "Value2": 0.0,
      "Value3": 0.0,
      "Value4": true,
      "Value5": "1900-01-01T00:00:00",
      "Visible": true,
      "GroupTypeAr": "Apps",
      "GroupTypeEn": "Apps"
    },
    {
      "SettingId": 9,
      "SettingArdesc": "نسبة الضريبة",
      "SettingEndesc": "Vat Percentage",
      "Value1": "",
      "Value2": 16.0,
      "Value3": 0.0,
      "Value4": true,
      "Value5": "1900-01-01T00:00:00",
      "Visible": true,
      "GroupTypeAr": "Apps",
      "GroupTypeEn": "Apps"
    },
    {
      "SettingId": 17,
      "SettingArdesc": "نسبة الخدمة",
      "SettingEndesc": "Service Percentage",
      "Value1": "",
      "Value2": 10.0,
      "Value3": 0.0,
      "Value4": false,
      "Value5": "1900-01-01T00:00:00",
      "Visible": true,
      "GroupTypeAr": "Apps",
      "GroupTypeEn": "Apps"
    },
    {
      "SettingId": 18,
      "SettingArdesc": "الضريبة على الخدمة",
      "SettingEndesc": "Service Tax",
      "Value1": "",
      "Value2": 16.0,
      "Value3": 0.0,
      "Value4": false,
      "Value5": "1900-01-01T00:00:00",
      "Visible": true,
      "GroupTypeAr": "Apps",
      "GroupTypeEn": "Apps"
    }
  ];

  void _onCalculateTotalPrice(
      CalculateTotalPriceEvent event, Emitter<CartState> emit) {
    final settings = jsonDecode(jsonEncode(test));
    // Extract relevant settings from the JSON response
    final vatPercentage = settings.firstWhere(
      (setting) => setting['SettingId'] == 9,
      orElse: () => {'Value2': 0.0},
    )['Value2'] as double;

    final servicePercentage = settings.firstWhere(
      (setting) => setting['SettingId'] == 17,
      orElse: () => {'Value2': 0.0},
    )['Value2'] as double;

    final serviceTaxPercentage = settings.firstWhere(
      (setting) => setting['SettingId'] == 18,
      orElse: () => {'Value2': 0.0},
    )['Value2'] as double;

    final priceIncludesTax = settings.firstWhere(
      (setting) => setting['SettingId'] == 3,
      orElse: () => {'Value4': false},
    )['Value4'] as bool;

    final taxIncludesDiscount = settings.firstWhere(
      (setting) => setting['SettingId'] == 5,
      orElse: () => {'Value4': false},
    )['Value4'] as bool;

    // Calculate the total price of all items in the cart
    double totalPriceBeforeDiscount = state.cart.fold(0.0, (sum, cartItem) {
      return sum + (cartItem.product.price * cartItem.quantity);
    });

    double totalPriceAfterDiscount = state.cart.fold(0.0, (sum, cartItem) {
      // Calculate the price of the current cart item
      double itemPrice = cartItem.product.price * cartItem.quantity;

      // Apply any active offers to the item price
      for (final offer in cartItem.offers) {
        if (offer.isActive &&
            offer.productId == cartItem.product.proId &&
            DateTime.now().isBefore(offer.toDate)) {
          if (offer.priceOffer) {
            itemPrice = _applyPriceOffer(offer, cartItem.product).price *
                cartItem.quantity;
          }
          if (offer.qtyOffer && cartItem.quantity >= offer.qty) {
            itemPrice = _applyQtyOffer(offer, cartItem.product).price *
                cartItem.quantity;
          }
        }
      }

      // Add the item price to the total sum
      return sum + itemPrice;
    });

    // Determine the base price for tax calculation
    double basePriceForTax = taxIncludesDiscount
        ? totalPriceAfterDiscount // Tax is applied after discounts
        : totalPriceBeforeDiscount; // Tax is applied before discounts

    // Calculate the total tax
    double totalTax;
    if (priceIncludesTax) {
      // If the price already includes tax, calculate the tax amount included in the price
      totalTax = basePriceForTax * (vatPercentage / (100 + vatPercentage));
    } else {
      // If the price does not include tax, calculate the tax amount
      totalTax = basePriceForTax * (vatPercentage / 100);
    }

    // Calculate the service charge
    final double serviceCharge =
        totalPriceAfterDiscount * (servicePercentage / 100);

    // Calculate the tax on the service charge
    final double serviceChargeTax =
        serviceCharge * (serviceTaxPercentage / 100);

    // Add the service charge and its tax to the total price
    double finalTotalPrice =
        totalPriceAfterDiscount + serviceCharge + serviceChargeTax;

    // Emit the updated state with the total price, total tax, and service charge
    emit(state.copyWith(
      totalPrice: finalTotalPrice,
      totalTax: totalTax,
      serviceCharge: serviceCharge,
      serviceChargeTax: serviceChargeTax,
    ));
  }

  void _applyOffers(Emitter<CartState> emit) {
    final List<CartItem> updatedCart = state.cart.map((cartItem) {
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
          final CartItem? extraProduct = state.cart
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
              extraItemId: cartItem.id, // Link to the parent item
            );
            updateCartWithExtraItems.add(extraItem);
          }
        }
      }
    }

    emit(state.copyWith(
      cart: updateCartWithExtraItems,
    ));
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
