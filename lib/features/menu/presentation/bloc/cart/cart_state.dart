part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> cart;

  const CartState({required this.cart});

  CartState copyWith({List<CartItem>? cart}) {
    return CartState(
      cart: cart ?? this.cart,
    );
  }

  PriceAndTax calculateTotalPrice(
      {double taxPercentage = 16.0,
      bool priceIncludesTax = true,
      double discount = 0.0,
      bool taxIncludesDiscount = true,
      int deliveryCategory = 1,
      double deliveryDiscount = 0.0}) {
    double finalTotalPrice = 0.0;
    double totalTax = 0.0;
    double totalDiscount = 0.0;
    double grandTotal = 0.0;

    for (final cartItem in cart) {
      final totalPriceAndTax = cartItem.calculateTotalPriceAndTax(
          taxPercentage: taxPercentage,
          priceIncludesTax: priceIncludesTax,
          deliveryCategory: deliveryCategory,
          deliveryDiscount: deliveryDiscount,
          discount: discount,
          taxIncludesDiscount: taxIncludesDiscount);
      finalTotalPrice += totalPriceAndTax.price;
      totalDiscount += totalPriceAndTax.discount;
      totalTax += totalPriceAndTax.tax;
      grandTotal += totalPriceAndTax.grandTotal;
    }
    return PriceAndTax(
        price: finalTotalPrice,
        tax: totalTax,
        discount: totalDiscount,
        grandTotal: grandTotal);
  }

  @override
  List<Object> get props => [cart];
}
