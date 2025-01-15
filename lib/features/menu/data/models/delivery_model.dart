import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/delivery.dart';

class DeliveryModel extends Delivery {
  DeliveryModel(
      {required super.companyId,
      required super.companyName,
      required super.phone,
      required super.email,
      required super.percent,
      required super.priceCategory,
      required super.active});

  factory DeliveryModel.fromJson(Map<String, dynamic> json) => DeliveryModel(
        companyId: json[ApiKeys.companyId],
        companyName: json[ApiKeys.companyName],
        phone: json[ApiKeys.phone],
        email: json[ApiKeys.email],
        percent: json[ApiKeys.percent]?.toDouble(),
        priceCategory: json[ApiKeys.priceCategory],
        active: json[ApiKeys.active],
      );

  Map<String, dynamic> toJson() => {
        ApiKeys.companyId: companyId,
        ApiKeys.companyName: companyName,
        ApiKeys.phone: phone,
        ApiKeys.email: email,
        ApiKeys.percent: percent,
        ApiKeys.priceCategory: priceCategory,
        ApiKeys.active: active,
      };
}
