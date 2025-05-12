import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/invoice_detail.dart';

class InvoiceDetailModel extends InvoiceDetail {
  InvoiceDetailModel(
      {required super.invoices,
      required super.invoiceDtl,
      required super.invoicePayment});

  factory InvoiceDetailModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailModel(
        invoices: InvoicesModel.fromJson(json[ApiKeys.invoices]),
        invoiceDtl: List<InvoiceDtlModel>.from(
            json[ApiKeys.invoiceDtl].map((x) => InvoiceDtlModel.fromJson(x))),
        invoicePayment: List<InvoicePaymentModel>.from(
            json[ApiKeys.invoicePayment]
                .map((x) => InvoicePaymentModel.fromJson(x))),
      );
}

class InvoicesModel extends Invoices {
  InvoicesModel(
      {required super.invoiceNo,
      required super.invoiceCashNo,
      required super.invoiceSubTotal,
      required super.invoiceDiscountTotal,
      required super.invoiceServiceTotal,
      required super.invoiceTaxTotal,
      required super.invoiceGrandTotal,
      required super.customer,
      required super.realTime,
      required super.tableNo,
      required super.empTaker,
      required super.takerName,
      required super.queue,
      required super.cashPayment,
      required super.warehouse,
      required super.salesDate,
      required super.deliveryCompany,
      required super.encryptionSeal,
      required super.guid,
      required super.qrcode,
  });

  factory InvoicesModel.fromJson(Map<String, dynamic> json) => InvoicesModel(
        invoiceNo: json[ApiKeys.invoiceNo]?.toDouble(),
        invoiceCashNo: json[ApiKeys.invoiceCashNo]?.toDouble(),
        invoiceSubTotal: json[ApiKeys.invoiceSubTotal],
        invoiceDiscountTotal: json[ApiKeys.invoiceDiscountTotal],
        invoiceServiceTotal: json[ApiKeys.invoiceServiceTotal],
        invoiceTaxTotal: json[ApiKeys.invoiceTaxTotal],
        invoiceGrandTotal: json[ApiKeys.invoiceGrandTotal],
        customer: json[ApiKeys.customer],
        realTime: DateTime.parse(json[ApiKeys.realTime]),
        tableNo: json[ApiKeys.tableNo],
        empTaker: json[ApiKeys.empTaker],
        takerName: json[ApiKeys.takerName],
        queue: json[ApiKeys.queue],
        cashPayment: json[ApiKeys.cashPayment],
        warehouse: json[ApiKeys.warehouse],
        salesDate: DateTime.parse(json[ApiKeys.salesDate]),
        deliveryCompany: json[ApiKeys.deliveryCompany],
        encryptionSeal: json[ApiKeys.encryptionSeal],
        guid: json[ApiKeys.guid],
        qrcode: json[ApiKeys.qrcode],
      );
}

class InvoiceDtlModel extends InvoiceDtl {
  InvoiceDtlModel(
      {required super.invoiceNo,
      required super.item,
      required super.qty,
        required super.unitId,
      required super.price,
      required super.subtotal,
      required super.discountV,
      required super.discountP,
      required super.taxP,
      required super.taxV,
      required super.grandTotal,
      required super.taker,
      required super.flavors,
      required super.warehouse,
      required super.salesDate,
      required super.offerNo,
      required super.lineId,
        required super.arName,
        required super.enName,

      });

  factory InvoiceDtlModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDtlModel(
        invoiceNo: json[ApiKeys.invoiceNo]?.toDouble(),
        item: json[ApiKeys.item],
        qty: json[ApiKeys.qty],
        unitId: json[ApiKeys.unitId],
        price: json[ApiKeys.price]?.toDouble(),
        subtotal: json[ApiKeys.subtotal]?.toDouble(),
        discountV: json[ApiKeys.discountV],
        discountP: json[ApiKeys.discountP],
        taxP: json[ApiKeys.taxP],
        taxV: json[ApiKeys.taxV],
        grandTotal: json[ApiKeys.grandTotal]?.toDouble(),
        taker: json[ApiKeys.taker]??0,
        flavors: json[ApiKeys.flavors],
        warehouse: json[ApiKeys.warehouse],
        salesDate: DateTime.parse(json[ApiKeys.salesDate]),
        offerNo: json[ApiKeys.offerNo],
        lineId: json[ApiKeys.lineID],
          arName:json[ApiKeys.arName],
        enName:json[ApiKeys.enName],

      );
}

class InvoicePaymentModel extends InvoicePayment {
  InvoicePaymentModel(
      {required super.invoiceId,
      required super.payType,
      required super.payment,
      required super.creditExpireDate,
      required super.warehouse,
      required super.arName,
        required super.enName,
      });

  factory InvoicePaymentModel.fromJson(Map<String, dynamic> json) =>
      InvoicePaymentModel(
        invoiceId: json[ApiKeys.invoiceId]?.toDouble(),
        payType: json[ApiKeys.payType],
        payment: json[ApiKeys.payment],
        creditExpireDate: DateTime.parse(json[ApiKeys.creditExpireDate]),
        warehouse: json[ApiKeys.warehouse],
        arName:json[ApiKeys.arName],
        enName:json[ApiKeys.enName],
      );
}
