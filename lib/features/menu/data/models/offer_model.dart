import 'dart:convert';

import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/offer.dart';

class OfferModel extends Offer {
  OfferModel(
      {required super.offerId,
      required super.productId,
      required super.productNameAr,
      required super.productNameEn,
      required super.fromDate,
      required super.toDate,
      required super.priceOffer,
      required super.qtyOffer,
      required super.extraOffer,
      required super.price,
      required super.qty,
      required super.extraProduct,
      required super.isActive,
      required super.extraProductAr,
      required super.extraProductEn,
      required super.offerTypeAr,
      required super.offerTypeEn,
      required super.offerValueAr,
      required super.offerValueEn});

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        offerId: json[ApiKeys.offerId],
        productId: json[ApiKeys.productId],
        productNameAr: json[ApiKeys.productNameAr],
        productNameEn: json[ApiKeys.productNameEn],
        fromDate: DateTime.parse(json[ApiKeys.fromDate]),
        toDate: DateTime.parse(json[ApiKeys.toDate]),
        priceOffer: jsonDecode(jsonEncode(json[ApiKeys.priceOffer])),
        qtyOffer: jsonDecode(jsonEncode(json[ApiKeys.qtyOffer])),
        extraOffer: jsonDecode(jsonEncode(json[ApiKeys.extraOffer])),
        price: double.tryParse(json[ApiKeys.price].toString()) ?? 0.0,
        qty: double.tryParse(json[ApiKeys.qty].toString()) ?? 0.0,
        extraProduct: json[ApiKeys.extraProduct],
        isActive: jsonDecode(jsonEncode(json[ApiKeys.isActive])),
        extraProductAr: json[ApiKeys.extraProductAr],
        extraProductEn: json[ApiKeys.extraProductEn],
        offerTypeAr: json[ApiKeys.offerTypeAr],
        offerTypeEn: json[ApiKeys.offerTypeEn],
        offerValueAr: json[ApiKeys.offerValueAr],
        offerValueEn: json[ApiKeys.offerValueEn],
      );
  @override
  Map<String, dynamic> toJson() => {
        ApiKeys.offerId: offerId,
        ApiKeys.productId: productId,
        ApiKeys.productNameAr: productNameAr,
        ApiKeys.productNameEn: productNameEn,
        ApiKeys.fromDate: fromDate.toIso8601String(),
        ApiKeys.toDate: toDate.toIso8601String(),
        ApiKeys.priceOffer: jsonEncode(priceOffer),
        ApiKeys.qtyOffer: jsonEncode(qtyOffer),
        ApiKeys.extraOffer: jsonEncode(extraOffer),
        ApiKeys.price: price,
        ApiKeys.qty: qty,
        ApiKeys.extraProduct: extraProduct,
        ApiKeys.isActive: jsonEncode(isActive),
        ApiKeys.extraProductAr: extraProductAr,
        ApiKeys.extraProductEn: extraProductEn,
        ApiKeys.offerTypeAr: offerTypeAr,
        ApiKeys.offerTypeEn: offerTypeEn,
        ApiKeys.offerValueAr: offerValueAr,
        ApiKeys.offerValueEn: offerValueEn,
      };
}
