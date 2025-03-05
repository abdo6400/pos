import 'package:equatable/equatable.dart';

abstract class Cash extends Equatable {
  final double cashNo;
  final int cashUser;
  final DateTime cashStartDate;
  final double cashCustody;
  final double cashWithDrawals;
  final double cashSubTotal;
  final double cashDiscountTotal;
  final double cashTaxTotal;
  final double cashGrandTotal;
  final dynamic cashStation;
  final String cashStatus;
  final DateTime cashRealTime;
  final double requiredCash;
  final double availableCash;
  final dynamic cashRealEndTime;
  final double cashCustomerPayment;
  final double voidAfter;
  final double voidBefore;
  final int illegalOpenCashDrawer;

  Cash({
    required this.cashNo,
    required this.cashUser,
    required this.cashStartDate,
    required this.cashCustody,
    required this.cashWithDrawals,
    required this.cashSubTotal,
    required this.cashDiscountTotal,
    required this.cashTaxTotal,
    required this.cashGrandTotal,
    required this.cashStation,
    required this.cashStatus,
    required this.cashRealTime,
    required this.requiredCash,
    required this.availableCash,
    required this.cashRealEndTime,
    required this.cashCustomerPayment,
    required this.voidAfter,
    required this.voidBefore,
    required this.illegalOpenCashDrawer,
  });

  @override
  List<Object?> get props => [
        cashNo,
        cashUser,
        cashStartDate,
        cashCustody,
        cashWithDrawals,
        cashSubTotal,
        cashDiscountTotal,
        cashTaxTotal,
        cashGrandTotal,
        cashStation,
        cashStatus,
        cashRealTime,
        requiredCash,
        availableCash,
        cashRealEndTime,
        cashCustomerPayment,
        voidAfter,
        voidBefore,
        illegalOpenCashDrawer
      ];
}
