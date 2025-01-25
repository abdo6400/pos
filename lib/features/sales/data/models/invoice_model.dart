import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/invoice.dart';

class InvoiceModel extends Invoice {
  InvoiceModel(
      {required super.invoiceNo,
      required super.invoiceCashNo,
      required super.customer,
      required super.empTaker,
      required super.salesDate,
      required super.freeTax,
      required super.invoiceSubTotal,
      required super.invoiceDiscountTotal,
      required super.invoiceServiceTotal,
      required super.invoiceTaxTotal,
      required super.invoiceGrandTotal,
      required super.stationId});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        invoiceNo: json[ApiKeys.invoiceNo]?.toDouble(),
        invoiceCashNo: json[ApiKeys.invoiceCashNo]?.toDouble(),
        customer: json[ApiKeys.customer],
        empTaker: json[ApiKeys.empTaker],
        salesDate: DateTime.parse(json[ApiKeys.salesDate]),
        freeTax: json[ApiKeys.freeTax],
        invoiceSubTotal: json[ApiKeys.invoiceSubTotal]?.toDouble(),
        invoiceDiscountTotal: json[ApiKeys.invoiceDiscountTotal]?.toDouble(),
        invoiceServiceTotal: json[ApiKeys.invoiceServiceTotal]?.toDouble(),
        invoiceTaxTotal: json[ApiKeys.invoiceTaxTotal]?.toDouble(),
        invoiceGrandTotal: json[ApiKeys.invoiceGrandTotal]?.toDouble(),
        stationId: json[ApiKeys.stationId],
      );
}
