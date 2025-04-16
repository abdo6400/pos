import 'package:dartz/dartz.dart';

import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/sales_repository.dart';

class ReturnInvoiceUsecase
    extends UseCase<Either<Failure, void>, ReturnParams> {
  final SalesRepository _repository;

  ReturnInvoiceUsecase(this._repository);
  @override
  Future<Either<Failure, void>> call(ReturnParams params) {
    return _repository.returnInvoice(params.toJson());
  }
}

class ReturnParams {
  final Hdr hdr;
  final List<Dtl> dtl;

  ReturnParams({
    required this.hdr,
    required this.dtl,
  });
  Map<String, dynamic> toJson() => {
        ApiKeys.hdr: hdr.toJson(),
        ApiKeys.dtl: List<dynamic>.from(dtl.map((x) => x.toJson())),
      };
}

class Dtl {
  final int returnId;
  final int indexId;
  final String itemId;
  final int qty;
  final double unitPrice;
  final double subTotal;
  final double discount;
  final double taxValue;
  final double discountPercentage;
  final double taxPercentage;
  final double grandTotal;
  final bool posted;
  final String warehouse;

  Dtl({
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

  Map<String, dynamic> toJson() => {
        ApiKeys.returnId: returnId,
        ApiKeys.indexId: indexId,
        ApiKeys.itemId: itemId,
        ApiKeys.qty: qty,
        ApiKeys.unitPrice: unitPrice,
        ApiKeys.subTotal: subTotal,
        ApiKeys.discount: discount,
        ApiKeys.taxValue: taxValue,
        ApiKeys.discountPercentage: discountPercentage,
        ApiKeys.taxPercentage: taxPercentage,
        ApiKeys.grandTotal: grandTotal,
        ApiKeys.posted: posted,
        ApiKeys.warehouse: warehouse,
      };
}

class Hdr {
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

  Hdr({
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
  Map<String, dynamic> toJson() => {
        ApiKeys.returnId: returnId,
        ApiKeys.returnDate: returnDate.toIso8601String(),
        ApiKeys.invoiceNo: invoiceNo,
        ApiKeys.returnedBy: returnedBy,
        ApiKeys.fromCash: fromCash,
        ApiKeys.voidReason: voidReason,
        ApiKeys.extraNote: extraNote,
        ApiKeys.returnsSubTotal: returnsSubTotal,
        ApiKeys.returnsDiscountTotal: returnsDiscountTotal,
        ApiKeys.returnsServiceTotal: returnsServiceTotal,
        ApiKeys.returnsTaxTotal: returnsTaxTotal,
        ApiKeys.returnsGrandTotal: returnsGrandTotal,
        ApiKeys.warehouse: warehouse,
        ApiKeys.encryptionSeal: encryptionSeal,
        ApiKeys.guid: guid,
        ApiKeys.qrcode: qrcode,
        ApiKeys.companyId: companyId,
        ApiKeys.payType: payType,
        ApiKeys.stationId: stationId,
      };
}
