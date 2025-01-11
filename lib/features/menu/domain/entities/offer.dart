import 'package:equatable/equatable.dart';

abstract class Offer extends Equatable {
  final int offerId;
  final String productId;
  final String productNameAr;
  final String productNameEn;
  final DateTime fromDate;
  final DateTime toDate;
  final bool priceOffer;
  final bool qtyOffer;
  final bool extraOffer;
  final double price;
  final double qty;
  final String extraProduct;
  final bool isActive;
  final String? extraProductAr;
  final String? extraProductEn;
  final String offerTypeAr;
  final String offerTypeEn;
  final String offerValueAr;
  final String offerValueEn;

  Offer({
    required this.offerId,
    required this.productId,
    required this.productNameAr,
    required this.productNameEn,
    required this.fromDate,
    required this.toDate,
    required this.priceOffer,
    required this.qtyOffer,
    required this.extraOffer,
    required this.price,
    required this.qty,
    required this.extraProduct,
    required this.isActive,
    required this.extraProductAr,
    required this.extraProductEn,
    required this.offerTypeAr,
    required this.offerTypeEn,
    required this.offerValueAr,
    required this.offerValueEn,
  });

  @override
  List<Object> get props => [];
}
