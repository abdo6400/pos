import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/sale_date.dart';

class SaleDateModel extends SaleDate {
  SaleDateModel(
      {required super.lineDate,
      required super.openTime,
      required super.closeTime,
      required super.closed,
      required super.id,
      required super.weatherCond,
      required super.processed,
      required super.rowId,
      required super.rowguid,
      required super.wareHouse,
      required super.transfer});

  factory SaleDateModel.fromJson(Map<String, dynamic> json) => SaleDateModel(
        lineDate: DateTime.parse(json[ApiKeys.lineDate]),
        openTime: DateTime.parse(json[ApiKeys.openTime]),
        closeTime: json[ApiKeys.closeTime],
        closed: json[ApiKeys.closed],
        id: json[ApiKeys.id],
        weatherCond: json[ApiKeys.weatherCond],
        processed: json[ApiKeys.processed],
        rowId: json[ApiKeys.rowId],
        rowguid: json[ApiKeys.rowguid],
        wareHouse: json[ApiKeys.wareHouse],
        transfer: json[ApiKeys.transfer],
      );

  Map<String, dynamic> toJson() => {
        ApiKeys.lineDate: lineDate.toIso8601String(),
        ApiKeys.openTime: openTime.toIso8601String(),
        ApiKeys.closeTime: closeTime,
        ApiKeys.closed: closed,
        ApiKeys.id: id,
        ApiKeys.weatherCond: weatherCond,
        ApiKeys.processed: processed,
        ApiKeys.rowId: rowId,
        ApiKeys.rowguid: rowguid,
        ApiKeys.wareHouse: wareHouse,
        ApiKeys.transfer: transfer,
      };
}
