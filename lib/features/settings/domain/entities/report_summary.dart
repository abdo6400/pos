
import 'package:equatable/equatable.dart';

abstract class ReportSummary extends Equatable{
  final double subTotal;
    final double service;
    final double discount;
    final double tax;
    final double grandTotal;
    final DateTime lineDate;
    final int id;
    final String warehouse;
    ReportSummary({
        required this.subTotal,
        required this.service,
        required this.discount,
        required this.tax,
        required this.grandTotal,
        required this.lineDate,
        required this.id,
        required this.warehouse,
    });

    @override
    List<Object?> get props => [
        subTotal,
        service,
        discount,
        tax,
        grandTotal,
        lineDate,
        id,
        warehouse,
    ];
}