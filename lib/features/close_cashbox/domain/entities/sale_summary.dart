import 'package:equatable/equatable.dart';

abstract class SaleSummary extends Equatable {
  final double cashNo;
  final double subTotal;
  final double discount;
  final double service;
  final double grandTotal;
  final double tax;

  SaleSummary(
      {required this.cashNo,
      required this.subTotal,
      required this.discount,
      required this.service,
      required this.grandTotal,
      required this.tax});

  @override
  List<Object?> get props =>
      [cashNo, subTotal, discount, service, grandTotal, tax];
}
