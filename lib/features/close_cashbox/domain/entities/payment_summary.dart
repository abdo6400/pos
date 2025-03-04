import 'package:equatable/equatable.dart';

abstract class PaymentSummary extends Equatable {
  final double cashno;
  final int type;
  final String desc;
  final bool isCashMoney;
  final double sum;

  PaymentSummary(
      {required this.cashno,
      required this.type,
      required this.desc,
      required this.isCashMoney,
      required this.sum});

  @override
  List<Object?> get props => [cashno, type, desc, isCashMoney, sum];
}
