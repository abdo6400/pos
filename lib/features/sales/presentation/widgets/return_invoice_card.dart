import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/return_invoice_usecase.dart';

class ReturnInvoiceCard extends StatelessWidget {
  final ReturnParams returnInvoice;

  const ReturnInvoiceCard({
    required this.returnInvoice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        color: Colors.white,
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Text(
              "مرتجع",
              style: TextStyle(
                  fontFamily: 'ARIAL',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text(
              'Restaurant Name',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Expanded(
                  flex: 12,
                  child: Text(
                    '${returnInvoice.hdr.invoiceNo}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    ":",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Text(
                  "رقم الفاتورة",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Expanded(
                  flex: 12,
                  child: Text(
                    'Cashier Name',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    ":",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    "الكاشير",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Expanded(
                  flex: 12,
                  child: Text(
                    "Cash Customer",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    ":",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    "العميل",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Expanded(
                  flex: 12,
                  child: Text(
                    (DateTime.now()).toString(),
                    // intl.DateFormat('yyyy-MM-dd – kk:mm').format(
                    //     invoice.RealTime),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    ":",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    "الوقت",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      "المجموع",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      "السعر",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      "الكمية",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      "الوصــــــــف",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
              ],
            ),
          ),
          Column(children: [
            for(var e in returnInvoice.dtl)
            Padding(
                padding: const EdgeInsets.all(3),
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Text(
    e.itemId,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          e.qty.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                         e.subTotal.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                         e.grandTotal.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ))
                  ],
                ),)]


          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  returnInvoice.hdr.returnsDiscountTotal.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  "الخصم ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (returnInvoice.hdr.returnsSubTotal).toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  "المجموع ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  returnInvoice.hdr.returnsTaxTotal.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  "مجموع الضريبة",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  returnInvoice.hdr.returnsGrandTotal.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  "المجموع النهائي",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${returnInvoice.dtl.length.toString()}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  "عدد المواد",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            height: 1,
          ),
          // Container(
          //   height: 150,
          //   width: 150,
          //   child: FittedBox(
          //     fit: BoxFit.contain,
          //     child: BarcodeWidget(
          //       height: 100,
          //       width: 150,
          //       color: Colors.grey,
          //       textPadding: 1,
          //       barcode: Barcode.qrCode(),
          //       data: widget.Result.toString(),
          //     ),
          //   ),
          // ),
        ]));
  }
}
