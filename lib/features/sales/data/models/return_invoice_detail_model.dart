import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/return_invoice_detail.dart';

class ReturnInvoiceDetailModel extends ReturnInvoiceDetail {
  ReturnInvoiceDetailModel({required super.hdr, required super.dtl});
  factory ReturnInvoiceDetailModel.fromJson(Map<String, dynamic> json) {
    return ReturnInvoiceDetailModel(
        hdr: HdrModel.fromJson(json[ApiKeys.hdr]),
        dtl: List<DtlModel>.from(
            json[ApiKeys.dtl].map((x) => DtlModel.fromJson(x))));
  }
}

class HdrModel extends ReturnInvoiceHdr {
  HdrModel(
      {required super.returnId,
      required super.returnDate,
      required super.invoiceNo,
      required super.returnedBy,
      required super.fromCash,
      required super.voidReason,
      required super.extraNote,
      required super.returnsSubTotal,
      required super.returnsDiscountTotal,
      required super.returnsServiceTotal,
      required super.returnsTaxTotal,
      required super.returnsGrandTotal,
      required super.warehouse,
      required super.encryptionSeal,
      required super.guid,
      required super.qrcode,
      required super.companyId,
      required super.payType,
      required super.stationId});

  factory HdrModel.fromJson(Map<String, dynamic> json) => HdrModel(
        returnId: json[ApiKeys.returnId],
        returnDate: DateTime.parse(json[ApiKeys.returnDate]),
        invoiceNo: json[ApiKeys.invoiceNo]?.toDouble(),
        returnedBy: json[ApiKeys.returnedBy],
        fromCash: json[ApiKeys.fromCash]?.toDouble(),
        voidReason: json[ApiKeys.voidReason],
        extraNote: json[ApiKeys.extraNote]??"",
        returnsSubTotal: json[ApiKeys.returnsSubTotal]?.toDouble(),
        returnsDiscountTotal: json[ApiKeys.returnsDiscountTotal]?.toDouble(),
        returnsServiceTotal: json[ApiKeys.returnsServiceTotal]?.toDouble(),
        returnsTaxTotal: json[ApiKeys.returnsTaxTotal]?.toDouble(),
        returnsGrandTotal: json[ApiKeys.returnsGrandTotal]?.toDouble(),
        warehouse: json[ApiKeys.warehouse],
        encryptionSeal: json[ApiKeys.encryptionSeal]??"",
        guid: json[ApiKeys.guid],
        qrcode: json[ApiKeys.qrcode]??"",
        companyId: json[ApiKeys.companyID],
        payType: json[ApiKeys.payType],
        stationId: json[ApiKeys.stationID]??"",
      );
}

class DtlModel extends returnInvoiceDtl {
  DtlModel(
      {required super.returnId,
      required super.indexId,
      required super.itemId,
      required super.qty,
      required super.unitPrice,
      required super.subTotal,
      required super.discount,
      required super.taxValue,
      required super.discountPercentage,
      required super.taxPercentage,
      required super.grandTotal,
      required super.posted,
      required super.warehouse});

  factory DtlModel.fromJson(Map<String, dynamic> json) => DtlModel(
        returnId: json[ApiKeys.returnId],
        indexId: json[ApiKeys.indexId],
        itemId: json[ApiKeys.itemId],
        qty: json[ApiKeys.qty]?.toDouble(),
        unitPrice: json[ApiKeys.unitPrice]?.toDouble(),
        subTotal: json[ApiKeys.subTotal]?.toDouble(),
        discount: json[ApiKeys.discount]?.toDouble(),
        taxValue: json[ApiKeys.taxValue]?.toDouble(),
        discountPercentage: json[ApiKeys.discountPercentage]?.toDouble(),
        taxPercentage: json[ApiKeys.taxPercentage]?.toDouble(),
        grandTotal: json[ApiKeys.grandTotal]?.toDouble(),
        posted: json[ApiKeys.posted],
        warehouse: json[ApiKeys.warehouse],
      );
}
