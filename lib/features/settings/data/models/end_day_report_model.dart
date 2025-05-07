import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/end_day_report.dart';

class EndDayReportModel extends EndDayReport {
  EndDayReportModel(
      {required super.zCashNo,
      required super.casher,
      required super.zStartDate,
      required super.zRealTime,
      required super.zEndDate,
      required super.zSales,
      required super.zReturn,
      required super.zPayments});

  factory EndDayReportModel.fromJson(Map<String, dynamic> json) {
    return EndDayReportModel(
      zCashNo: json[ApiKeys.zCashNo],
      casher: json[ApiKeys.casher],
      zStartDate: DateTime.parse(json[ApiKeys.zStartDate]),
      zRealTime: DateTime.parse(json[ApiKeys.zRealTime]),
      zEndDate: DateTime.parse(json[ApiKeys.zEndDate]),
      zSales: json[ApiKeys.zSales],
      zReturn: json[ApiKeys.zReturn],
      zPayments: List<ZpaymentModel>.from(
          json[ApiKeys.zPayments].map((x) => ZpaymentModel.fromJson(x)
    )));
  }
}

class ZpaymentModel extends Zpayment {
  ZpaymentModel({
    required super.type,
    required super.typeArDesc,
    required super.typeEnDesc,
    required super.payments,
    required super.invoicesCount,
  });
  factory ZpaymentModel.fromJson(Map<String, dynamic> json) {
    return ZpaymentModel(
      type: json[ApiKeys.zType],
      typeArDesc: json[ApiKeys.typeArDesc],
      typeEnDesc: json[ApiKeys.typeEnDesc],
      payments: json[ApiKeys.payments],
      invoicesCount: json[ApiKeys.invoicesCount],
    );
  }
}
