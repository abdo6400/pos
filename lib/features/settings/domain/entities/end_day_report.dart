import 'package:equatable/equatable.dart';

abstract class EndDayReport extends Equatable {
  final double zCashNo;
  final String casher;
  final DateTime zStartDate;
  final DateTime zRealTime;
  final DateTime zEndDate;
  final double zSales;
  final double zReturn;
  final List<Zpayment> zPayments;

  EndDayReport({
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

abstract class Zpayment extends Equatable {
  final int type;
  final String typeArDesc;
  final String typeEnDesc;
  final double payments;
  final int invoicesCount;

  Zpayment({
    required this.type,
    required this.typeArDesc,
    required this.typeEnDesc,
    required this.payments,
    required this.invoicesCount,
  });

  @override
  List<Object?> get props => [
        type,
        typeArDesc,
        typeEnDesc,
        payments,
        invoicesCount,
      ];
}
