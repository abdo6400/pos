import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/payment_summary.dart';

class PaymentSummaryModel extends PaymentSummary {
  PaymentSummaryModel(
      {required super.cashno,
      required super.type,
      required super.desc,
      required super.isCashMoney,
      required super.sum});

  factory PaymentSummaryModel.fromJson(Map<String, dynamic> json) {
    return PaymentSummaryModel(
      cashno: json[ApiKeys.cashno],
      type: json[ApiKeys.type],
      desc: json[ApiKeys.desc],
      isCashMoney: json[ApiKeys.isCashMoney],
      sum: json[ApiKeys.sum],
    );
  }
}
