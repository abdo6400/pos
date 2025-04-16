import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/return_invoice.dart';

class ReturnInvoiceModel extends ReturnInvoice {
  ReturnInvoiceModel(
      {required super.returnId,
      required super.returnDate,
      required super.invoiceNo,
      required super.returnedBy,
      required super.fromCash,
      required super.voidReason,
      required super.returnsSubTotal,
      required super.returnsDiscountTotal,
      required super.returnsTaxTotal,
      required super.returnsGrandTotal,
      required super.warehouse});

  factory ReturnInvoiceModel.fromJson(Map<String, dynamic> json) =>
      ReturnInvoiceModel(
        returnId: json[ApiKeys.returnId],
        returnDate: DateTime.parse(json[ApiKeys.returnDate]),
        invoiceNo: json[ApiKeys.invoiceNo]?.toDouble(),
        returnedBy: json[ApiKeys.returnedBy],
        fromCash: json[ApiKeys.fromCash]?.toDouble(),
        voidReason: json[ApiKeys.voidReason],
        returnsSubTotal: json[ApiKeys.returnsSubTotal]?.toDouble(),
        returnsDiscountTotal: json[ApiKeys.returnsDiscountTotal]?.toDouble(),
        returnsTaxTotal: json[ApiKeys.returnsTaxTotal]?.toDouble(),
        returnsGrandTotal: json[ApiKeys.returnsGrandTotal]?.toDouble(),
        warehouse: json[ApiKeys.warehouse],
      );
}
