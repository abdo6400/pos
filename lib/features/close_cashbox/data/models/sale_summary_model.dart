import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/sale_summary.dart';

class SaleSummaryModel extends SaleSummary {
  SaleSummaryModel(
      {required super.cashNo,
      required super.subTotal,
      required super.discount,
      required super.service,
      required super.grandTotal,
      required super.tax});

  factory SaleSummaryModel.fromJson(Map<String, dynamic> json) =>
      SaleSummaryModel(
          cashNo: json[ApiKeys.cashNo],
          subTotal: json[ApiKeys.subtotal],
          discount: json[ApiKeys.discount],
          service: json[ApiKeys.service],
          grandTotal: json[ApiKeys.grandTotal],
          tax: json[ApiKeys.tax]);
}
