import 'package:equatable/equatable.dart';

abstract class PaymentType extends Equatable {
  final int ptype;
  final String paymentArDesc;
  final String paymentEnDesc;
  final bool isActive;
  final bool cashMoney;
  final double commissions;
  final bool coupon;
  final bool isCredit;
  final int companyId;

  PaymentType({
    required this.ptype,
    required this.paymentArDesc,
    required this.paymentEnDesc,
    required this.isActive,
    required this.cashMoney,
    required this.commissions,
    required this.coupon,
    required this.isCredit,
    required this.companyId,
  });

  @override
  List<Object?> get props => [
        ptype,
        paymentArDesc,
        paymentEnDesc,
        isActive,
        cashMoney,
        commissions,
        coupon,
        isCredit,
        companyId,
      ];
}
