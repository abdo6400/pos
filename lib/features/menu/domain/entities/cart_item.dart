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

  const CartItem(
      {required this.id,
      required this.product,
      required this.quantity,
      required this.flavors,
      required this.questions,
      required this.offers,
      this.isOffer = false,
      this.note = '',
      this.extraItemId});

  CartItem copyWith(
      {Product? product,
      bool? isOffer,
      List<Flavor>? flavors,
      List<Product>? questions,
      List<Offer>? offers,
      int? quantity,
      String? note,
      String? id,
      String? extraItemId}) {
    return CartItem(
        id: id ?? this.id,
        product: product ?? this.product,
        isOffer: isOffer ?? this.isOffer,
        flavors: flavors ?? this.flavors,
        questions: questions ?? this.questions,
        offers: offers ?? this.offers,
        quantity: quantity ?? this.quantity,
        note: note ?? this.note,
        extraItemId: extraItemId ?? this.extraItemId);
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
        extraItemId
      ];
}
