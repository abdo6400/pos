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
        offerId: json["OfferId"],
        productId: json["ProductId"],
        productNameAr: json["ProductNameAr"],
        productNameEn: json["ProductNameEn"],
        fromDate: DateTime.parse(json["FromDate"]),
        toDate: DateTime.parse(json["ToDate"]),
        priceOffer: json["PriceOffer"],
        qtyOffer: json["QtyOffer"],
        extraOffer: json["ExtraOffer"],
        price: json["Price"]?.toDouble(),
        qty: json["Qty"],
        extraProduct: json["ExtraProduct"],
        isActive: json["IsActive"],
        extraProductAr: json["ExtraProductAr"],
        extraProductEn: json["ExtraProductEn"],
        offerTypeAr: json["OfferTypeAr"],
        offerTypeEn: json["OfferTypeEn"],
        offerValueAr: json["offerValueAr"],
        offerValueEn: json["offerValueEn"],
      );
}
