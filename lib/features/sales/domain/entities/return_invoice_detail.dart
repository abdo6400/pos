import 'package:equatable/equatable.dart';

abstract class ReturnInvoiceDetail extends Equatable {
  final ReturnInvoiceHdr hdr;
  final List<returnInvoiceDtl> dtl;

  ReturnInvoiceDetail({
    required this.hdr,
    required this.dtl,
  });

  @override
  List<Object?> get props => [
        hdr,
        dtl,
      ];
}

abstract class returnInvoiceDtl extends Equatable {
  final int returnId;
  final int indexId;
  final String itemId;
  final double qty;
  final double unitPrice;
  final double subTotal;
  final double discount;
  final double taxValue;
  final double discountPercentage;
  final double taxPercentage;
  final double grandTotal;
  final bool posted;
  final String warehouse;

  returnInvoiceDtl({
    required this.returnId,
    required this.indexId,
    required this.itemId,
    required this.qty,
    required this.unitPrice,
    required this.subTotal,
    required this.discount,
    required this.taxValue,
    required this.discountPercentage,
    required this.taxPercentage,
    required this.grandTotal,
    required this.posted,
    required this.warehouse,
  });

  @override
  List<Object?> get props => [
        returnId,
        indexId,
        itemId,
        qty,
        unitPrice,
        subTotal,
        discount,
        taxValue,
        discountPercentage,
        taxPercentage,
        grandTotal,
        posted,
        warehouse,
      ];
}

abstract class ReturnInvoiceHdr extends Equatable {
  final int returnId;
  final DateTime returnDate;
  final double invoiceNo;
  final int returnedBy;
  final double fromCash;
  final int voidReason;
  final String extraNote;
  final double returnsSubTotal;
  final double returnsDiscountTotal;
  final double returnsServiceTotal;
  final double returnsTaxTotal;
  final double returnsGrandTotal;
  final String warehouse;
  final String encryptionSeal;
  final String guid;
  final String qrcode;
  final int companyId;
  final int payType;
  final String stationId;

  ReturnInvoiceHdr({
    required this.returnId,
    required this.returnDate,
    required this.invoiceNo,
    required this.returnedBy,
    required this.fromCash,
    required this.voidReason,
    required this.extraNote,
    required this.returnsSubTotal,
    required this.returnsDiscountTotal,
    required this.returnsServiceTotal,
    required this.returnsTaxTotal,
    required this.returnsGrandTotal,
    required this.warehouse,
    required this.encryptionSeal,
    required this.guid,
    required this.qrcode,
    required this.companyId,
    required this.payType,
    required this.stationId,
  });

  @override
  List<Object?> get props => [
        returnId,
        returnDate,
        invoiceNo,
        returnedBy,
        fromCash,
        voidReason,
        extraNote,
        returnsSubTotal,
        returnsDiscountTotal,
        returnsServiceTotal,
        returnsTaxTotal,
        returnsGrandTotal,
        warehouse,
        encryptionSeal,
        guid,
        qrcode,
        companyId,
        payType,
      ];
}
