import 'package:equatable/equatable.dart';

abstract class Cash extends Equatable {
  final double cashNo;
  final int cashUser;
  final DateTime cashStartDate;
  final int cashCustody;
  final int cashWithDrawals;
  final int cashSubTotal;
  final int cashDiscountTotal;
  final int cashTaxTotal;
  final int cashGrandTotal;
  final dynamic cashStation;
  final String cashStatus;
  final DateTime cashRealTime;
  final int requiredCash;
  final int availableCash;
  final dynamic cashRealEndTime;
  final int cashCustomerPayment;
  final int voidAfter;
  final int voidBefore;
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
