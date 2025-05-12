import 'package:equatable/equatable.dart';

abstract class Invoice extends Equatable {
  final double invoiceNo;
  final double invoiceCashNo;
  final int customer;
  final int empTaker;
  final DateTime salesDate;
  final bool freeTax;
  final double invoiceSubTotal;
  final double invoiceDiscountTotal;
  final double invoiceServiceTotal;
  final double invoiceTaxTotal;
  final double invoiceGrandTotal;

  Invoice({
    required this.invoiceNo,
    required this.invoiceCashNo,
    required this.customer,
    required this.empTaker,
    required this.salesDate,
    required this.freeTax,
    required this.invoiceSubTotal,
    required this.invoiceDiscountTotal,
    required this.invoiceServiceTotal,
    required this.invoiceTaxTotal,
    required this.invoiceGrandTotal,
  });

  @override
  List<Object?> get props => [
        invoiceNo,
        invoiceCashNo,
        customer,
        empTaker,
        salesDate,
        freeTax,
        invoiceSubTotal,
        invoiceDiscountTotal,
        invoiceServiceTotal,
        invoiceTaxTotal,
        invoiceGrandTotal,
      ];
}
