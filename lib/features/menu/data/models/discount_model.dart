import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/discount.dart';

class DiscountModel extends Discount {
  DiscountModel(
      {required super.serial,
      required super.discountPercentage,
      required super.discountTypeAr,
      required super.discountTypeEn,
      required super.active});

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
        serial: json[ApiKeys.serial],
        discountPercentage: json[ApiKeys.discountPercentage]?.toDouble(),
        discountTypeAr: json[ApiKeys.discountTypeAr],
        discountTypeEn: json[ApiKeys.discountTypeEn],
        active: json[ApiKeys.active],
      );

  Map<String, dynamic> toJson() => {
        ApiKeys.serial: serial,
        ApiKeys.discountPercentage: discountPercentage,
        ApiKeys.discountTypeAr: discountTypeAr,
        ApiKeys.discountTypeEn: discountTypeEn,
        ApiKeys.active: active,
      };
}
