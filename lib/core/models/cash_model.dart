import '../../config/database/api/api_keys.dart';
import '../entities/cash.dart';

class CashModel extends Cash {
  CashModel(
      {required super.cashNo,
      required super.cashUser,
      required super.cashStartDate,
      required super.cashCustody,
      required super.cashWithDrawals,
      required super.cashSubTotal,
      required super.cashDiscountTotal,
      required super.cashTaxTotal,
      required super.cashGrandTotal,
      required super.cashStation,
      required super.cashStatus,
      required super.cashRealTime,
      required super.requiredCash,
      required super.availableCash,
      required super.cashRealEndTime,
      required super.cashCustomerPayment,
      required super.voidAfter,
      required super.voidBefore,
      required super.illegalOpenCashDrawer});

  factory CashModel.fromJson(Map<String, dynamic> json) => CashModel(
        cashNo: json[ApiKeys.cashNo]?.toDouble(),
        cashUser: json[ApiKeys.cashUser],
        cashStartDate: DateTime.parse(json[ApiKeys.cashStartDate]),
        cashCustody: json[ApiKeys.cashCustody],
        cashWithDrawals: json[ApiKeys.cashWithDrawals],
        cashSubTotal: json[ApiKeys.cashSubTotal],
        cashDiscountTotal: json[ApiKeys.cashDiscountTotal],
        cashTaxTotal: json[ApiKeys.cashTaxTotal],
        cashGrandTotal: json[ApiKeys.cashGrandTotal],
        cashStation: json[ApiKeys.cashStation] ?? 0.0,
        cashStatus: json[ApiKeys.cashStatus],
        cashRealTime: DateTime.parse(
            json[ApiKeys.cashRealTime] ?? DateTime.now().toIso8601String()),
        requiredCash: json[ApiKeys.requiredCash],
        availableCash: json[ApiKeys.availableCash],
        cashRealEndTime: json[ApiKeys.cashRealEndTime],
        cashCustomerPayment: json[ApiKeys.cashCustomerPayment],
        voidAfter: json[ApiKeys.voidAfter],
        voidBefore: json[ApiKeys.voidBefore],
        illegalOpenCashDrawer: json[ApiKeys.illegalOpenCashDrawer],
      );

  Map<String, dynamic> toJson() => {
        ApiKeys.cashNo: cashNo,
        ApiKeys.cashUser: cashUser,
        ApiKeys.cashStartDate: cashStartDate.toIso8601String(),
        ApiKeys.cashCustody: cashCustody,
        ApiKeys.cashWithDrawals: cashWithDrawals,
        ApiKeys.cashSubTotal: cashSubTotal,
        ApiKeys.cashDiscountTotal: cashDiscountTotal,
        ApiKeys.cashTaxTotal: cashTaxTotal,
        ApiKeys.cashGrandTotal: cashGrandTotal,
        ApiKeys.cashStation: cashStation,
        ApiKeys.cashStatus: cashStatus,
        ApiKeys.cashRealTime: cashRealTime.toIso8601String(),
        ApiKeys.requiredCash: requiredCash,
        ApiKeys.availableCash: availableCash,
        ApiKeys.cashRealEndTime: cashRealEndTime,
        ApiKeys.cashCustomerPayment: cashCustomerPayment,
        ApiKeys.voidAfter: voidAfter,
        ApiKeys.voidBefore: voidBefore,
        ApiKeys.illegalOpenCashDrawer: illegalOpenCashDrawer,
      };
}
