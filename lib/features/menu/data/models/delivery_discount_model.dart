import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/delivery_discount.dart';

class DeliveryDiscountModel extends DeliveryDiscount {
  DeliveryDiscountModel(
      {required super.lineId,
      required super.companyId,
      required super.companyDesc,
      required super.fromDate,
      required super.toDate,
      required super.discountValue,
      required super.branchId,
      required super.branche,
      required super.isActive});

  factory DeliveryDiscountModel.fromJson(Map<String, dynamic> json) {
    return DeliveryDiscountModel(
      lineId: json[ApiKeys.lineId],
      companyId: json[ApiKeys.companyId],
      companyDesc: json[ApiKeys.companyDesc],
      fromDate: DateTime.parse(json[ApiKeys.fromDate]),
      toDate: DateTime.parse(json[ApiKeys.toDate]),
      discountValue: json[ApiKeys.discountValue],
      branchId: json[ApiKeys.branchId],
      branche: json[ApiKeys.branche],
      isActive: json[ApiKeys.isActive],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.lineId: lineId,
      ApiKeys.companyId: companyId,
      ApiKeys.companyDesc: companyDesc,
      ApiKeys.fromDate: fromDate.toIso8601String(),
      ApiKeys.toDate: toDate.toIso8601String(),
      ApiKeys.discountValue: discountValue,
      ApiKeys.branchId: branchId,
      ApiKeys.branche: branche,
      ApiKeys.isActive: isActive,
    };
  }
}
