import 'package:equatable/equatable.dart';

import 'flavor.dart';
import 'offer.dart';
import 'product.dart';

class CartItem extends Equatable {
  final String id;
  final Product product;
  final bool isOffer;
  final List<Flavor> flavors;
  final List<Product> questions;
  final List<Offer> offers;
  final int quantity;
  final String note;
  final String? extraItemId;
  final double orignialPrice;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.flavors,
    required this.questions,
    required this.offers,
    this.isOffer = false,
    this.note = '',
    this.extraItemId,
    required this.orignialPrice,
  });

  CartItem copyWith({
    Product? product,
    bool? isOffer,
    List<Flavor>? flavors,
    List<Product>? questions,
    List<Offer>? offers,
    int? quantity,
    String? note,
    String? id,
    String? extraItemId,
    double? orignialPrice,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      isOffer: isOffer ?? this.isOffer,
      flavors: flavors ?? this.flavors,
      questions: questions ?? this.questions,
      offers: offers ?? this.offers,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
      extraItemId: extraItemId ?? this.extraItemId,
      orignialPrice: orignialPrice ?? this.orignialPrice,
    );
  }

  @override
  List<Object?> get props => [
        id,
        product,
        isOffer,
        flavors,
        questions,
        offers,
        quantity,
        note,
        extraItemId,
      ];

  PriceAndTax calculateTotalPriceAndTax({
    double taxPercentage = 16.0,
    bool priceIncludesTax = true,
    bool taxIncludesDiscount = true,
    double discount = 0.0,
  }) {
    // Calculate price and tax for the product
    final productPriceAndTax = _calculatePriceAndTax(
      price: product.price,
      taxPercentage: taxPercentage,
      priceIncludesTax: priceIncludesTax,
      discount: discount,
      taxIncludesDiscount: taxIncludesDiscount,
    );

    // Calculate price and tax for flavors
    final flavorsPriceAndTax = flavors.fold<PriceAndTax>(
      PriceAndTax.zero(),
      (sum, flavor) =>
          sum +
          _calculatePriceAndTax(
            price: flavor.price,
            taxPercentage: taxPercentage,
            priceIncludesTax: priceIncludesTax,
            taxIncludesDiscount: taxIncludesDiscount,
          ),
    );

    // Calculate price and tax for questions
    final questionsPriceAndTax = questions.fold<PriceAndTax>(
      PriceAndTax.zero(),
      (sum, question) =>
          sum +
          _calculatePriceAndTax(
            price: question.price,
            taxPercentage: taxPercentage,
            priceIncludesTax: priceIncludesTax,
            taxIncludesDiscount: taxIncludesDiscount,
          ),
    );

    // Calculate total price, tax, discount, and grand total
    final totalPrice = (productPriceAndTax.price +
            flavorsPriceAndTax.price +
            questionsPriceAndTax.price) *
        quantity;

    final totalTax = (productPriceAndTax.tax +
            flavorsPriceAndTax.tax +
            questionsPriceAndTax.tax) *
        quantity;

    final totalDiscount = (productPriceAndTax.discount) * quantity;
    final grandTotal = (productPriceAndTax.grandTotal +
            flavorsPriceAndTax.grandTotal +
            questionsPriceAndTax.grandTotal) *
        quantity;

    return PriceAndTax(
      price: totalPrice,
      tax: totalTax,
      discount: totalDiscount,
      grandTotal: grandTotal,
    );
  }

  PriceAndTax _calculatePriceAndTax({
    required double price,
    required double taxPercentage,
    bool priceIncludesTax = false,
    double discount = 0.0,
    bool taxIncludesDiscount = false,
  }) {
    double newPrice;
    double tax;
    double discountPrice = 0.0;

    // Calculate base price and tax
    if (priceIncludesTax) {
      newPrice = price / (1 + (taxPercentage / 100)); // Price without tax
      tax = price - newPrice; // Tax amount
    } else {
      newPrice = price; // Price without tax
      tax = newPrice * (taxPercentage / 100); // Tax amount
    }

    // Apply discount
    if (discount != 0) {
      if (taxIncludesDiscount) {
        discountPrice = (newPrice + tax) *
            discount; // Discount on total price (including tax)
      } else {
        discountPrice =
            newPrice * discount; // Discount on base price (excluding tax)
      }
    }

    // Calculate grand total
    final grandTotal = (newPrice + tax) - discountPrice;

    return PriceAndTax(
      price: newPrice,
      tax: tax,
      discount: discountPrice,
      grandTotal: grandTotal,
    );
  }
}

class PriceAndTax {
  final double price;
  final double tax;
  final double discount;
  final double grandTotal;

  const PriceAndTax({
    required this.price,
    required this.tax,
    required this.discount,
    required this.grandTotal,
  });

  // Helper method to initialize a zero PriceAndTax object
  const PriceAndTax.zero()
      : price = 0.0,
        tax = 0.0,
        discount = 0.0,
        grandTotal = 0.0;

  // Override the + operator to simplify aggregation
  PriceAndTax operator +(PriceAndTax other) {
    return PriceAndTax(
      price: price + other.price,
      tax: tax + other.tax,
      discount: discount + other.discount,
      grandTotal: grandTotal + other.grandTotal,
    );
  }
}
