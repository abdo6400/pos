import 'package:equatable/equatable.dart';

import 'flavor.dart';
import 'offer.dart';
import 'product.dart';

abstract class Cart extends Equatable {
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

  const Cart({
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

  Map<String, dynamic> toJson();
}
