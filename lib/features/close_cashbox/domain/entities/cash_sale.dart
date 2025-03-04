import 'package:equatable/equatable.dart';

abstract class CashSale extends Equatable {
  final double cashSales;
  final int orderReturn;
  final int cashCustody;

  CashSale(
      {required this.cashSales,
      required this.orderReturn,
      required this.cashCustody});

  @override
  List<Object?> get props => [cashSales, orderReturn, cashCustody];
}
