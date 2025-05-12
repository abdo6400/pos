import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../../../../core/entities/cash.dart';
import '../entities/invoice_id.dart';
import '../../../../core/entities/sale_date.dart';
import '../repositories/payment_repository.dart';

class PayUsecase extends UseCase<Either<Failure, String>, InvoiceParams> {
  final PaymentRepository _paymentRepository;

  PayUsecase(this._paymentRepository);
  @override
  Future<Either<Failure, String>> call(params) async {
    return _paymentRepository.pay(params.toJson(
        saleDate: (await _paymentRepository.getSaleDate(params.branchId))
            .fold((l) => null, (r) => r),
        cash: (await _paymentRepository.getCash(params.invoices.empTaker))
            .fold((l) => null, (r) => r),
        invoiceId: (await _paymentRepository.getLastInvoiceId(params.branchId))
            .fold((l) => null, (r) => r)));
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

  Map<String, dynamic> toJson(
      {InvoiceId? invoiceId, Cash? cash, SaleDate? saleDate}) {
    final saleDateTime =
        "${saleDate?.lineDate.year}-${saleDate?.lineDate.month}-${saleDate?.lineDate.day}";
    final randomId = DateTime.now().millisecondsSinceEpoch.toString();
    return {
      ApiKeys.invoices: invoices.toJson(invoiceId?.invoiceNo ?? randomId,
          invoiceId?.queue ?? 0, cash?.cashNo ?? 0, saleDateTime),
      ApiKeys.invoiceDtl: List<dynamic>.from(
        invoiceDtl.map(
            (x) => x.toJson(invoiceId?.invoiceNo ?? randomId, saleDateTime)),
      ),
      ApiKeys.invoicePayment: List<dynamic>.from(
        invoicePayment.map(
            (x) => x.toJson(invoiceId?.invoiceNo ?? randomId, saleDateTime)),
      ),
    };
  }
}

class InvoiceDtl {
  final String item;
  final int qty;
  final int unitId;
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
  final int offerNo;
  final int lineId;
  final String proArName;
  final String proEnName;

  InvoiceDtl({
    required this.item,
    required this.qty,
    required this.unitId,
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
    required this.offerNo,
    required this.lineId,
    required this.proArName,
    required this.proEnName,
  });

  Map<String, dynamic> toJson(String invoiceNo, String saleDate) {
    return {
      ApiKeys.invoiceNo: invoiceNo,
      ApiKeys.item: item,
      ApiKeys.unitId:unitId,
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
      ApiKeys.salesDate: saleDate,
      ApiKeys.offerNo: offerNo,
      ApiKeys.lineId: lineId,
    };
  }
}

class InvoicePayment {
  final int payType;

  final double payment;
  final int warehouse;

  InvoicePayment({
    required this.payType,
    required this.payment,
    required this.warehouse,

  });

  Map<String, dynamic> toJson(String invoiceNo, String creditExpireDate) {
    return {
      ApiKeys.invoiceId: invoiceNo,
      ApiKeys.payType: payType,
      ApiKeys.payment: payment,
      ApiKeys.creditExpireDate: creditExpireDate,
      ApiKeys.warehouse: warehouse,
    };
  }
}

class Invoices {
  final double invoiceSubTotal;
  final double invoiceDiscountTotal;
  final double invoiceServiceTotal;
  final double invoiceTaxTotal;
  final double invoiceGrandTotal;
  final int customer;
  final DateTime realTime;
  final int tableNo;
  final int empTaker;
  final String takerName;
  final double cashPayment;
  final int warehouse;
  final int deliveryCompany;
  final String qrcode;

  Invoices({
    required this.invoiceSubTotal,
    required this.invoiceDiscountTotal,
    required this.invoiceServiceTotal,
    required this.invoiceTaxTotal,
    required this.invoiceGrandTotal,
    required this.customer,
    required this.realTime,
    required this.tableNo,
    required this.empTaker,
    required this.takerName,
    required this.cashPayment,
    required this.warehouse,
    required this.deliveryCompany,
    required this.qrcode,
  });

  Map<String, dynamic> toJson(
      String invoiceNo, int queue, double cashNo, String saleDate) {
    return {
      ApiKeys.invoiceNo: invoiceNo,
      ApiKeys.invoiceCashNo: cashNo,
      ApiKeys.invoiceSubTotal: invoiceSubTotal,
      ApiKeys.invoiceDiscountTotal: invoiceDiscountTotal,
      ApiKeys.invoiceServiceTotal: invoiceServiceTotal,
      ApiKeys.invoiceTaxTotal: invoiceTaxTotal,
      ApiKeys.invoiceGrandTotal: invoiceGrandTotal,
      ApiKeys.customer: customer,
      ApiKeys.realTime: realTime.toIso8601String(),
      ApiKeys.tableNo: tableNo,
      ApiKeys.empTaker: empTaker,
      ApiKeys.takerName: takerName,
      ApiKeys.queue: queue,
      ApiKeys.cashPayment: cashPayment,
      ApiKeys.warehouse: warehouse,
      ApiKeys.salesDate: saleDate,
      ApiKeys.deliveryCompany: deliveryCompany,
      ApiKeys.qrcode: qrcode,
    };
  }
}
