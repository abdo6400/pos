

import 'package:equatable/equatable.dart';

abstract class ReturnInvoice extends Equatable {

  final int returnId;
    final DateTime returnDate;
    final double invoiceNo;
    final int returnedBy;
    final double fromCash;
    final int voidReason;
    final double returnsSubTotal;
    final double returnsDiscountTotal;
    final double returnsTaxTotal;
    final double returnsGrandTotal;
    final String warehouse;

    ReturnInvoice({
        required this.returnId,
        required this.returnDate,
        required this.invoiceNo,
        required this.returnedBy,
        required this.fromCash,
        required this.voidReason,
        required this.returnsSubTotal,
        required this.returnsDiscountTotal,
        required this.returnsTaxTotal,
        required this.returnsGrandTotal,
        required this.warehouse,
    });

    @override
    List<Object?> get props => [
        returnId,
        returnDate,
        invoiceNo,
        returnedBy,
        fromCash,
        voidReason,
        returnsSubTotal,
        returnsDiscountTotal,
        returnsTaxTotal,
        returnsGrandTotal,
        warehouse,
    ];


}