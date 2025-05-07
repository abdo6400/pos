import 'package:equatable/equatable.dart';

abstract class Zreport extends Equatable {
  final double zCashNo;
  final String casher;
  final DateTime zStartDate;
  final DateTime zRealTime;
  final DateTime zEndDate;
  final double zSales;
  final double zReturn;
  final List zPayments;


  Zreport({
    required this.zCashNo,
    required this.casher,
    required this.zStartDate,
    required this.zRealTime,
    required this.zEndDate,
    required this.zSales,
    required this.zReturn,
    required this.zPayments,

  });

  @override
  List<Object?> get props => [
    zCashNo,
    casher,
    zStartDate,
    zRealTime,
    zEndDate,
    zSales,
    zReturn,
    zPayments,
  ];
}
