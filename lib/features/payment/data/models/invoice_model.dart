import '../../../../config/database/local/tables_keys.dart';
import '../../domain/entities/invoice.dart';

class InvoiceModel extends Invoice {
  InvoiceModel({
    required super.invoiceNo,
    required super.invoiceCashNo,
    required super.invoiceSubTotal,
    required super.invoiceDiscountTotal,
    required super.invoiceServiceTotal,
    required super.invoiceTaxTotal,
    required super.invoiceGrandTotal,
    required super.isPrinted,
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
    required super.qrcode,
    required super.stationId,
    required super.invoiceDtl,
    required super.invoicePayment,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      invoiceNo: json[TablesKeys.invoiceNo].toString(),
      invoiceCashNo: json[TablesKeys.invoiceCashNo]?.toDouble() ?? 0.0,
      invoiceSubTotal: json[TablesKeys.invoiceSubTotal]?.toDouble() ?? 0.0,
      invoiceDiscountTotal:
          json[TablesKeys.invoiceDiscountTotal]?.toDouble() ?? 0.0,
      invoiceServiceTotal:
          json[TablesKeys.invoiceServiceTotal]?.toDouble() ?? 0.0,
      invoiceTaxTotal: json[TablesKeys.invoiceTaxTotal]?.toDouble() ?? 0.0,
      invoiceGrandTotal: json[TablesKeys.invoiceGrandTotal]?.toDouble() ?? 0.0,
      isPrinted: json[TablesKeys.isPrinted] == 'true',
      customer: json[TablesKeys.customer] ?? 0,
      realTime: json[TablesKeys.realTime] ??
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      tableNo: json[TablesKeys.tableNo] ?? -1,
      empTaker: json[TablesKeys.empTaker] ?? 0,
      takerName: json[TablesKeys.takerName] ?? '',
      queue: json[TablesKeys.queue] ?? 0,
      cashPayment: json[TablesKeys.cashPayment]?.toDouble() ?? 0.0,
      warehouse: json[TablesKeys.warehouse] ?? 0,
      salesDate: json[TablesKeys.salesDate] ??
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      deliveryCompany: json[TablesKeys.deliveryCompany] ?? 0,
      qrcode: json[TablesKeys.qrcode] ?? '',
      stationId: json[TablesKeys.stationId] ?? '',
      invoiceDtl: (json[TablesKeys.invoiceDtl] as List<dynamic>?)
              ?.map((x) => InvoiceDetailModel.fromJson(x))
              .toList() ??
          [],
      invoicePayment: (json[TablesKeys.invoicePayment] as List<dynamic>?)
              ?.map((x) => InvoicePaymentModel.fromJson(x))
              .toList() ??
          [],
    );
  }

  @override
  Invoice copyWith(
      {String? invoiceNo, double? invoiceCashNo, String? salesDate}) {
    return InvoiceModel(
      invoiceNo: invoiceNo ?? this.invoiceNo,
      invoiceCashNo: invoiceCashNo ?? this.invoiceCashNo,
      invoiceSubTotal: invoiceSubTotal,
      invoiceDiscountTotal: invoiceDiscountTotal,
      invoiceServiceTotal: invoiceServiceTotal,
      invoiceTaxTotal: invoiceTaxTotal,
      invoiceGrandTotal: invoiceGrandTotal,
      isPrinted: isPrinted,
      customer: customer,
      realTime: realTime,
      tableNo: tableNo,
      empTaker: empTaker,
      takerName: takerName,
      queue: queue,
      cashPayment: cashPayment,
      warehouse: warehouse,
      salesDate: salesDate ?? this.salesDate,
      deliveryCompany: deliveryCompany,
      qrcode: qrcode,
      stationId: stationId,
      invoiceDtl: invoiceDtl
          .map((e) => e.copyWith(
              invoiceNo: invoiceNo ?? this.invoiceNo,
              salesDate: salesDate ?? this.salesDate))
          .toList(),
      invoicePayment: invoicePayment
          .map((e) => e.copyWith(invoiceId: invoiceNo ?? this.invoiceNo))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TablesKeys.invoiceNo: invoiceNo,
      TablesKeys.invoiceCashNo: invoiceCashNo,
      TablesKeys.invoiceSubTotal: invoiceSubTotal,
      TablesKeys.invoiceDiscountTotal: invoiceDiscountTotal,
      TablesKeys.invoiceServiceTotal: invoiceServiceTotal,
      TablesKeys.invoiceTaxTotal: invoiceTaxTotal,
      TablesKeys.invoiceGrandTotal: invoiceGrandTotal,
      TablesKeys.isPrinted: isPrinted,
      TablesKeys.customer: customer,
      TablesKeys.realTime: realTime,
      TablesKeys.tableNo: tableNo,
      TablesKeys.empTaker: empTaker,
      TablesKeys.takerName: takerName,
      TablesKeys.queue: queue,
      TablesKeys.cashPayment: cashPayment,
      TablesKeys.warehouse: warehouse,
      TablesKeys.salesDate: salesDate,
      TablesKeys.deliveryCompany: deliveryCompany,
      TablesKeys.qrcode: qrcode,
      TablesKeys.stationId: stationId,
      TablesKeys.invoiceDtl: invoiceDtl.map((e) => e.toJson()).toList(),
      TablesKeys.invoicePayment: invoicePayment.map((e) => e.toJson()).toList(),
    };
  }
}

class InvoiceDetailModel extends InvoiceDetail {
  InvoiceDetailModel({
    required super.invoiceNo,
    required super.item,
    required super.qty,
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
  });

  factory InvoiceDetailModel.fromJson(Map<String, dynamic> json) {
    return InvoiceDetailModel(
      invoiceNo: json[TablesKeys.invoiceNo].toString(),
      item: json[TablesKeys.item] ?? 0,
      qty: json[TablesKeys.qty] ?? 0,
      price: json[TablesKeys.price]?.toDouble() ?? 0.0,
      subtotal: json[TablesKeys.subtotal]?.toDouble() ?? 0.0,
      discountV: json[TablesKeys.discountV]?.toDouble() ?? 0.0,
      discountP: json[TablesKeys.discountP]?.toDouble() ?? 0.0,
      taxP: json[TablesKeys.taxP]?.toDouble() ?? 0.0,
      taxV: json[TablesKeys.taxV]?.toDouble() ?? 0.0,
      grandTotal: json[TablesKeys.grandTotal]?.toDouble() ?? 0.0,
      taker: json[TablesKeys.taker] ?? 0,
      flavors: json[TablesKeys.flavors] ?? '',
      warehouse: json[TablesKeys.warehouse] ?? 0,
      salesDate: json[TablesKeys.salesDate] ??
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      offerNo: json[TablesKeys.offerNo] ?? 0,
      lineId: json[TablesKeys.lineId] ?? 0,
    );
  }

  @override
  InvoiceDetail copyWith({String? invoiceNo, String? salesDate}) {
    return InvoiceDetailModel(
      invoiceNo: invoiceNo ?? this.invoiceNo,
      item: this.item,
      qty: this.qty,
      price: this.price,
      subtotal: this.subtotal,
      discountV: this.discountV,
      discountP: this.discountP,
      taxP: this.taxP,
      taxV: this.taxV,
      grandTotal: this.grandTotal,
      taker: this.taker,
      flavors: this.flavors,
      warehouse: this.warehouse,
      salesDate: salesDate ?? this.salesDate,
      offerNo: this.offerNo,
      lineId: this.lineId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TablesKeys.invoiceNo: invoiceNo,
      TablesKeys.item: item,
      TablesKeys.qty: qty,
      TablesKeys.price: price,
      TablesKeys.subtotal: subtotal,
      TablesKeys.discountV: discountV,
      TablesKeys.discountP: discountP,
      TablesKeys.taxP: taxP,
      TablesKeys.taxV: taxV,
      TablesKeys.grandTotal: grandTotal,
      TablesKeys.taker: taker,
      TablesKeys.flavors: flavors,
      TablesKeys.warehouse: warehouse,
      TablesKeys.salesDate: salesDate,
      TablesKeys.offerNo: offerNo,  
      TablesKeys.lineId: lineId,  
    };
  }
}

class InvoicePaymentModel extends InvoicePayment {
  InvoicePaymentModel({
    required super.invoiceId,
    required super.payType,
    required super.payment,
    required super.creditExpireDate,
    required super.warehouse,
  });

  factory InvoicePaymentModel.fromJson(Map<String, dynamic> json) {
    return InvoicePaymentModel(
      invoiceId: json[TablesKeys.invoiceId].toString(),
      payType: json[TablesKeys.payType] ?? 0,
      payment: json[TablesKeys.payment]?.toDouble() ?? 0.0,
      creditExpireDate: json[TablesKeys.creditExpireDate] ??
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      warehouse: json[TablesKeys.warehouse] ?? 0,
    );
  }

  @override
  InvoicePayment copyWith({String? invoiceId}) {
    return InvoicePaymentModel(
      invoiceId: invoiceId ?? this.invoiceId,
      payType: payType,
      payment: payment,
      creditExpireDate: creditExpireDate,
      warehouse: warehouse,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TablesKeys.invoiceId: invoiceId,
      TablesKeys.payType: payType,
      TablesKeys.payment: payment,
      TablesKeys.creditExpireDate: creditExpireDate,
      TablesKeys.warehouse: warehouse,
    };
  }
}
