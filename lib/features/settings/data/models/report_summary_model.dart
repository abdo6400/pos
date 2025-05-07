import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/report_summary.dart';

class ReportSummaryModel extends ReportSummary {
  ReportSummaryModel(
      {required super.subTotal,
      required super.service,
      required super.discount,
      required super.tax,
      required super.grandTotal,
      required super.lineDate,
      required super.id,
      required super.warehouse});

  factory ReportSummaryModel.fromJson(Map<String, dynamic> json) {
    return ReportSummaryModel(
        subTotal: json[ApiKeys.subTotal]?.toDouble() ?? 0.0,
        service: json[ApiKeys.service]?.toDouble() ?? 0.0,
        discount: json[ApiKeys.discount]?.toDouble() ?? 0.0,
        tax: json[ApiKeys.tax]?.toDouble() ?? 0.0,
        grandTotal: json[ApiKeys.grandTotal]?.toDouble() ?? 0.0,
        lineDate: DateTime.parse(json[ApiKeys.lineDate]),
        id: json[ApiKeys.iD]?.toInt() ?? 0,
        warehouse: json[ApiKeys.warehouse]);
  }
}
