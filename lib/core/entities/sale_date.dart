import 'package:equatable/equatable.dart';

abstract class SaleDate extends Equatable {
  final DateTime lineDate;
  final DateTime openTime;
  final DateTime closeTime;
  final bool closed;
  final int id;
  final int weatherCond;
  final bool processed;
  final int rowId;
  final String rowguid;
  final String wareHouse;
  final bool transfer;

  SaleDate({
    required this.lineDate,
    required this.openTime,
    required this.closeTime,
    required this.closed,
    required this.id,
    required this.weatherCond,
    required this.processed,
    required this.rowId,
    required this.rowguid,
    required this.wareHouse,
    required this.transfer,
  });

  @override
  List<Object?> get props => [
        lineDate,
        openTime,
        closeTime,
        closed,
        id,
        weatherCond,
        processed,
        rowId,
        rowguid,
        wareHouse,
        transfer
      ];
}
