import 'dart:convert';

import '../../../../../config/database/local/tables_keys.dart';
import '../../../domain/entities/cart.dart';
import '../../../domain/entities/flavor.dart';
import '../../../domain/entities/offer.dart';
import '../../../domain/entities/product.dart';

class CartItem {
  final String id;
  final Product product;
  final bool isOffer;
  final List<Flavor> flavors;
  final List<Product> questions;
  final List<Offer> offers;
  final int quantity;
  final String note;
  final String? extraItemId;
  final double? orignialPrice;

  CartItem({
    required this.id,
    required this.product,
    this.isOffer = false,
    required this.flavors,
    required this.questions,
    required this.offers,
    required this.quantity,
    this.note = "",
    this.extraItemId,
    this.orignialPrice,
  });

  factory CartItem.convert(Cart cart) => CartItem(
        id: cart.id,
        product: cart.product,
        isOffer: cart.isOffer,
        flavors: cart.flavors,
        questions: cart.questions,
        offers: cart.offers,
        quantity: cart.quantity,
        note: cart.note,
        extraItemId: cart.extraItemId,
        orignialPrice: cart.orignialPrice,
      );

  Map<String, dynamic> toJson() => {
        TablesKeys.cartItemId: id,
        TablesKeys.cartItemProductId: product.proId,
        TablesKeys.cartItemIsOffer: jsonEncode(isOffer),
        TablesKeys.cartItemFlavorTable:
            flavors.map((flavor) => flavor.flavorNo).toList(),
        TablesKeys.cartItemQuestionTable:
            questions.map((question) => question.proId).toList(),
        TablesKeys.cartItemOfferTable:
            offers.map((offer) => offer.offerId).toList(),
        TablesKeys.cartItemQuantity: quantity,
        TablesKeys.cartItemNote: note,
        TablesKeys.cartItemExtraItemId: extraItemId,
        TablesKeys.cartItemOriginalPrice: orignialPrice,
      };

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

  double getPrice(double price, double price2, double price3, double price4,
      int priceCategory, double discount) {
    double priceFinal = 0;
    switch (priceCategory) {
      case 1:
        priceFinal = price;
        break;
      case 2:
        priceFinal = price2;
        break;
      case 3:
        priceFinal = price3;
        break;
      case 4:
        priceFinal = price4;
        break;
      default:
        priceFinal = price;
        break;
    }
    return priceFinal - ((discount / 100) * priceFinal);
  }

  PriceAndTax calculateTotalPriceAndTax(
      {double taxPercentage = 16.0,
      bool priceIncludesTax = true,
      bool taxIncludesDiscount = true,
      double discount = 0.0,
      int deliveryCategory = 1,
      double deliveryDiscount = 0.0}) {
    // Calculate price and tax for the product
    final productPriceAndTax = _calculatePriceAndTax(
      price: getPrice(product.price, product.price2, product.price3,
          product.price4, deliveryCategory, deliveryDiscount),
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
            price: getPrice(question.price, question.price2, question.price3,
                question.price4, deliveryCategory, deliveryDiscount),
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
