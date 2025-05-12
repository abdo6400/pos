import 'package:equatable/equatable.dart';

abstract class InvoiceDetail extends Equatable {
  final Invoices invoices;
  final List<InvoiceDtl> invoiceDtl;
  final List<InvoicePayment> invoicePayment;

  InvoiceDetail({
    required this.invoices,
    required this.invoiceDtl,
    required this.invoicePayment,
  });

  @override
  List<Object> get props => [invoices, invoiceDtl, invoicePayment];
}

abstract class InvoiceDtl extends Equatable {
  final double invoiceNo;
  final String item;
  final double qty;
  final double price;
  final double subtotal;
  final double discountV;
  final double discountP;
  final double taxP;
  final double taxV;
  final double grandTotal;
  final int taker;
  final String flavors;
  final int warehouse;
  final DateTime salesDate;
  final int offerNo;
  final int lineId;

  InvoiceDtl({
    required this.invoiceNo,
    required this.item,
    required this.qty,
    required this.price,
    required this.subtotal,
    required this.discountV,
    required this.discountP,
    required this.taxP,
    required this.taxV,
    required this.grandTotal,
    required this.taker,
    required this.flavors,
    required this.warehouse,
    required this.salesDate,
    required this.offerNo,
    required this.lineId,
  });

  @override
  List<Object> get props => [
        invoiceNo,
        item,
        qty,
        price,
        subtotal,
        discountV,
        discountP,
        taxP,
        taxV,
        grandTotal,
        taker,
        flavors,
        warehouse,
        salesDate,
        offerNo,
        lineId,
      ];
}

abstract class InvoicePayment extends Equatable {
  final double invoiceId;
  final int payType;
  final double payment;
  final DateTime creditExpireDate;
  final String warehouse;

  InvoicePayment({
    required this.invoiceId,
    required this.payType,
    required this.payment,
    required this.creditExpireDate,
    required this.warehouse,
  });

  @override
  List<Object> get props => [
        invoiceId,
        payType,
        payment,
        creditExpireDate,
        warehouse,
      ];
}

abstract class Invoices extends Equatable {
  final double invoiceNo;
  final double invoiceCashNo;
  final double invoiceSubTotal;
  final double invoiceDiscountTotal;
  final double invoiceServiceTotal;
  final double invoiceTaxTotal;
  final double invoiceGrandTotal;
  final bool isPrinted;
  final int customer;
  final DateTime realTime;
  final int tableNo;
  final int empTaker;
  final String takerName;
  final int queue;
  final double cashPayment;
  final int warehouse;
  final DateTime salesDate;
  final int deliveryCompany;
  final dynamic encryptionSeal;
  final String guid;
  final String qrcode;
  final dynamic stationId;

  Invoices({
    required this.invoiceNo,
    required this.invoiceCashNo,
    required this.invoiceSubTotal,
    required this.invoiceDiscountTotal,
    required this.invoiceServiceTotal,
    required this.invoiceTaxTotal,
    required this.invoiceGrandTotal,
    required this.isPrinted,
    required this.customer,
    required this.realTime,
    required this.tableNo,
    required this.empTaker,
    required this.takerName,
    required this.queue,
    required this.cashPayment,
    required this.warehouse,
    required this.salesDate,
    required this.deliveryCompany,
    required this.encryptionSeal,
    required this.guid,
    required this.qrcode,
    required this.stationId,
  });

  @override
  List<Object> get props => [
        invoiceNo,
        invoiceCashNo,
        invoiceSubTotal,
        invoiceDiscountTotal,
        invoiceServiceTotal,
        invoiceTaxTotal,
        invoiceGrandTotal,
        isPrinted,
        customer,
        realTime,
        tableNo,
        empTaker,
        takerName,
        queue,
        cashPayment,
        warehouse,
        salesDate,
        deliveryCompany,
        encryptionSeal,
        guid,
        qrcode,
        stationId,
      ];
}
