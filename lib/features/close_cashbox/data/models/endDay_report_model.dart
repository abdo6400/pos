import '../../../../config/database/api/api_keys.dart';
import 'Zreport.dart';

class ZRepModel extends Zreport {
  ZRepModel(
      {
        required super.zCashNo,
        required super.casher,
        required super.zStartDate,
        required super.zRealTime,
        required super.zEndDate,
        required super.zSales,
        required super.zReturn,
        required super.zPayments
      });

  factory ZRepModel.fromJson(Map<String, dynamic> json) {
    return ZRepModel(
        zCashNo: json[ApiKeys.zCashNo],
        casher: json[ApiKeys.casher],
        zStartDate: json[ApiKeys.zStartDate],
        zRealTime: json[ApiKeys.zRealTime],
        zEndDate: json[ApiKeys.zEndDate],
        zSales: json[ApiKeys.zSales],
        zReturn: json[ApiKeys.zReturn],
        zPayments: json[ApiKeys.zPayments],
    );
  }
}