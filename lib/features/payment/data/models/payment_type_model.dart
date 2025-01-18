import 'dart:convert';

import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/payment_type.dart';

class PaymentTypeModel extends PaymentType {
  PaymentTypeModel({
    required super.ptype,
    required super.paymentArDesc,
    required super.paymentEnDesc,
    required super.isActive,
    required super.cashMoney,
    required super.commissions,
    required super.coupon,
    required super.isCredit,
    required super.companyId,
  });

  factory PaymentTypeModel.fromJson(Map<String, dynamic> json) =>
      PaymentTypeModel(
        ptype: json[ApiKeys.ptype],
        paymentArDesc: json[ApiKeys.paymentArDesc],
        paymentEnDesc: json[ApiKeys.paymentEnDesc],
        isActive: jsonDecode(jsonEncode(json[ApiKeys.isActive])),
        cashMoney: jsonDecode(jsonEncode(json[ApiKeys.cashMoney])),
        commissions: json[ApiKeys.commissions],
        coupon: jsonDecode(jsonEncode(json[ApiKeys.coupon])),
        isCredit: jsonDecode(jsonEncode(json[ApiKeys.isCredit])),
        companyId: json[ApiKeys.companyId],
      );

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.ptype: ptype,
      ApiKeys.paymentArDesc: paymentArDesc,
      ApiKeys.paymentEnDesc: paymentEnDesc,
      ApiKeys.isActive: jsonEncode(isActive),
      ApiKeys.cashMoney: jsonEncode(isActive),
      ApiKeys.commissions: commissions,
      ApiKeys.coupon: jsonEncode(coupon),
      ApiKeys.isCredit: jsonEncode(isCredit),
      ApiKeys.companyId: companyId,
    };
  }
}
