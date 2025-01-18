import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/payment_repository.dart';

class PayUsecase extends UseCase<Either<Failure, void>, InvoiceParams> {
  final PaymentRepository _paymentRepository;

  PayUsecase(this._paymentRepository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return _paymentRepository.pay(params.toJson(
        invoiceNo: (await _paymentRepository.getLastInvoiceId(params.branchId))
            .fold((l) => "0", (r) => r)
            .toString()));
  }
}

class InvoiceParams {
  final Invoices invoices;
  final int branchId;
  final List<InvoiceDtl> invoiceDtl;
  final List<InvoicePayment> invoicePayment;

  InvoiceParams({
    required this.invoices,
    required this.branchId,
    required this.invoiceDtl,
    required this.invoicePayment,
  });

  Map<String, dynamic> toJson({String invoiceNo = "0"}) {
    return {
      ApiKeys.invoices: invoices.toJson(invoiceNo),
      ApiKeys.invoiceDtl: List<dynamic>.from(
        invoiceDtl.map((x) => x.toJson(invoiceNo)),
      ),
      ApiKeys.invoicePayment: List<dynamic>.from(
        invoicePayment.map((x) => x.toJson(invoiceNo)),
      ),
    };
  }
}

class InvoiceDtl {
  final String item;
  final int qty;
  final int price;
  final int subtotal;
  final int discountV;
  final int discountP;
  final int taxP;
  final int taxV;
  final int grandTotal;
  final int taker;
  final String flavors;
  final int warehouse;
  final DateTime salesDate;
  final int offerNo;
  final int lineId;

  InvoiceDtl({
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

  Map<String, dynamic> toJson(String invoiceNo) {
    return {
      ApiKeys.invoiceNo: invoiceNo,
      ApiKeys.item: item,
      ApiKeys.qty: qty,
      ApiKeys.price: price,
      ApiKeys.subtotal: subtotal,
      ApiKeys.discountV: discountV,
      ApiKeys.discountP: discountP,
      ApiKeys.taxP: taxP,
      ApiKeys.taxV: taxV,
      ApiKeys.grandTotal: grandTotal,
      ApiKeys.taker: taker,
      ApiKeys.flavors: flavors,
      ApiKeys.warehouse: warehouse,
      ApiKeys.salesDate: salesDate.toIso8601String(),
      ApiKeys.offerNo: offerNo,
      ApiKeys.lineId: lineId,
    };
  }
}

class InvoicePayment {
  final int payType;
  final double payment;
  final DateTime creditExpireDate;
  final String warehouse;

  InvoicePayment({
    required this.payType,
    required this.payment,
    required this.creditExpireDate,
    required this.warehouse,
  });

  Map<String, dynamic> toJson(String invoiceNo) {
    return {
      ApiKeys.invoiceId: invoiceNo,
      ApiKeys.payType: payType,
      ApiKeys.payment: payment,
      ApiKeys.creditExpireDate: creditExpireDate.toIso8601String(),
      ApiKeys.warehouse: warehouse,
    };
  }
}

class Invoices {
  final int invoiceCashNo;
  final int invoiceSubTotal;
  final int invoiceDiscountTotal;
  final int invoiceServiceTotal;
  final int invoiceTaxTotal;
  final int invoiceGrandTotal;
  final bool isPrinted;
  final int customer;
  final DateTime realTime;
  final int tableNo;
  final int empTaker;
  final String takerName;
  final int queue;
  final int cashPayment;
  final int warehouse;
  final DateTime salesDate;
  final int deliveryCompany;
  final String encryptionSeal;
  final String guid;
  final String qrcode;
  final String stationId;

  Invoices({
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

  Map<String, dynamic> toJson(String invoiceNo) {
    return {
      ApiKeys.invoiceNo: invoiceNo,
      ApiKeys.invoiceCashNo: invoiceCashNo,
      ApiKeys.invoiceSubTotal: invoiceSubTotal,
      ApiKeys.invoiceDiscountTotal: invoiceDiscountTotal,
      ApiKeys.invoiceServiceTotal: invoiceServiceTotal,
      ApiKeys.invoiceTaxTotal: invoiceTaxTotal,
      ApiKeys.invoiceGrandTotal: invoiceGrandTotal,
      ApiKeys.isPrinted: jsonEncode(isPrinted),
      ApiKeys.customer: customer,
      ApiKeys.realTime: realTime.toIso8601String(),
      ApiKeys.tableNo: tableNo,
      ApiKeys.empTaker: empTaker,
      ApiKeys.takerName: takerName,
      ApiKeys.queue: queue,
      ApiKeys.cashPayment: cashPayment,
      ApiKeys.warehouse: warehouse,
      ApiKeys.salesDate: salesDate.toIso8601String(),
      ApiKeys.deliveryCompany: deliveryCompany,
      ApiKeys.encryptionSeal: encryptionSeal,
      ApiKeys.guid: guid,
      ApiKeys.qrcode: qrcode,
      ApiKeys.stationId: stationId,
    };
  }
}
