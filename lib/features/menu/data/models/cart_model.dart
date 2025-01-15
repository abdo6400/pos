import 'dart:convert';

import '../../../../config/database/local/tables_keys.dart';
import '../../domain/entities/cart.dart';
import 'flavor_model.dart';
import 'offer_model.dart';
import 'product_model.dart';

class CartModel extends Cart {
  CartModel(
      {required super.id,
      required super.product,
      required super.quantity,
      required super.flavors,
      required super.questions,
      required super.note,
      required super.offers,
      required super.isOffer,
      required super.extraItemId,
      required super.orignialPrice});
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json[TablesKeys.cartItemId],
      product: ProductModel.fromJson(json[TablesKeys.cartItemProductId]),
      isOffer: jsonDecode(jsonEncode(json[TablesKeys.cartItemIsOffer])),
      flavors: (json[TablesKeys.cartItemFlavorTable] as List)
          .map((flavor) => FlavorModel.fromJson(flavor))
          .toList(),
      questions: (json[TablesKeys.cartItemQuestionTable] as List)
          .map((question) => ProductModel.fromJson(question))
          .toList(),
      offers: (json[TablesKeys.cartItemFlavorTable] as List)
          .map((offer) => OfferModel.fromJson(offer))
          .toList(),
      quantity: json[TablesKeys.cartItemQuantity],
      note: json[TablesKeys.cartItemNote],
      extraItemId: json[TablesKeys.cartItemExtraItemId],
      orignialPrice: json[TablesKeys.cartItemOriginalPrice],
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
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
  }
}
