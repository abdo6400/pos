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
        offerId: json[ApiKeys.offerId] ?? 0,
        productId: json[ApiKeys.productId] ?? ' 0',
        productNameAr: json[ApiKeys.productNameAr],
        productNameEn: json[ApiKeys.productNameEn],
        fromDate:
            DateTime.parse(json[ApiKeys.fromDate] ?? '1970-01-01T00:00:00.000'),
        toDate:
            DateTime.parse(json[ApiKeys.toDate] ?? '1970-01-01T00:00:00.000'),
        priceOffer: json[ApiKeys.priceOffer] is bool
            ? json[ApiKeys.priceOffer] as bool
            : (json[ApiKeys.priceOffer] as String?)?.toLowerCase() == 'true',
        qtyOffer: json[ApiKeys.qtyOffer] is bool
            ? json[ApiKeys.qtyOffer] as bool
            : (json[ApiKeys.qtyOffer] as String?)?.toLowerCase() == 'true',
        extraOffer: json[ApiKeys.extraOffer] is bool
            ? json[ApiKeys.extraOffer] as bool
            : (json[ApiKeys.extraOffer] as String?)?.toLowerCase() == 'true',
        price: (json[ApiKeys.price] as num?)?.toDouble() ?? 0.0,
        qty: json[ApiKeys.qty] ?? 1.0,
        extraProduct: json[ApiKeys.extraProduct] ?? '-1',
        isActive: json[ApiKeys.isActive] is bool
            ? json[ApiKeys.isActive] as bool
            : (json[ApiKeys.isActive] as String?)?.toLowerCase() == 'true',
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
