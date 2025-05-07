import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/return_invoice_usecase.dart';


class ReturnInvoiceCard extends StatelessWidget {
  final ReturnParams  returnInvoice;

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
        // child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     spacing: 10,
        //     children: [
        //       // Header
        //       Column(
        //         spacing: 10,
        //         children: [
        //           Center(
        //             child: Text(
        //               'RESTAURANT NAME',
        //               style:
        //                   TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        //             ),
        //           ),
        //           Divider(thickness: 2),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Text("Invoice #:",
        //                   style: TextStyle(fontSize: 22, color: Colors.black)),
        //               SizedBox(width: 10),
        //               Text(
        //                 "$invoiceNumber",
        //                 style: TextStyle(color: Colors.black, fontSize: 20),
        //               ),
        //             ],
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Text("Cashier:",
        //                   style: TextStyle(color: Colors.black, fontSize: 25)),
        //               SizedBox(width: 10),
        //               Text(
        //                 '',
        //                 style: TextStyle(color: Colors.black, fontSize: 25),
        //               ),
        //             ],
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Text("Customer:",
        //                   style: TextStyle(color: Colors.black, fontSize: 25)),
        //               SizedBox(width: 10),
        //               Text(
        //                 "Cash Customer",
        //                 style: TextStyle(color: Colors.black, fontSize: 25),
        //               ),
        //             ],
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Text("Date:",
        //                   style: TextStyle(fontSize: 22, color: Colors.black)),
        //               SizedBox(width: 10),
        //               Text(
        //                 '${DateTime.now().toString().substring(0, 16)}',
        //                 style: TextStyle(color: Colors.black, fontSize: 20),
        //               ),
        //             ],
        //           ),
        //           Divider(thickness: 2),
        //         ],
        //       ),

        //       // Items List
        //       Container(
        //         padding: EdgeInsets.all(3),
        //         decoration: BoxDecoration(
        //           border: Border.all(),
        //           borderRadius: BorderRadius.all(Radius.circular(5)),
        //         ),
        //         child: Row(
        //           children: [
        //             Expanded(
        //                 flex: 2,
        //                 child: Text("Item",
        //                     style:
        //                         TextStyle(color: Colors.black, fontSize: 13))),
        //             Expanded(
        //                 flex: 1,
        //                 child: Text("Qty",
        //                     textAlign: TextAlign.center,
        //                     style:
        //                         TextStyle(color: Colors.black, fontSize: 13))),
        //             Expanded(
        //                 flex: 1,
        //                 child: Text("Price",
        //                     textAlign: TextAlign.center,
        //                     style:
        //                         TextStyle(color: Colors.black, fontSize: 13))),
        //             Expanded(
        //                 flex: 1,
        //                 child: Text("Total",
        //                     textAlign: TextAlign.center,
        //                     style:
        //                         TextStyle(color: Colors.black, fontSize: 13))),
        //           ],
        //         ),
        //       ),
        //       ...items.map((item) {
        //         return Column(
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.symmetric(vertical: 4),
        //               child: Row(
        //                 mainAxisSize: MainAxisSize.min,
        //                 spacing: 20,
        //                 children: [
        //                   Expanded(
        //                     flex: 3,
        //                     child: Text(
        //                       item['name'],
        //                       style: TextStyle(
        //                         color: Colors.black,
        //                         fontWeight: item['isReturned'] == true
        //                             ? FontWeight.bold
        //                             : null,
        //                         fontSize: 20,
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     child: Text(
        //                       item['qty'].toString(),
        //                       style: TextStyle(
        //                         color: Colors.black,
        //                         fontSize: 20,
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     child: Text(
        //                       "${item['price'].toStringAsFixed(2)}",
        //                       style: TextStyle(
        //                         color: Colors.black,
        //                         fontSize: 20,
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     child: Text(
        //                       "${item['total'].toStringAsFixed(2)}",
        //                       style: TextStyle(
        //                       color: Colors.black,
        //                         fontSize: 20,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             DottedLine(
        //               dashLength: 4.0,
        //               lineThickness: 2.0,
        //               dashColor: Colors.black,
        //             )
        //           ],
        //         );
        //       }).toList(),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 1),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text("Subtotal",
        //                 style: TextStyle(
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black)),
        //             Text(subtotal.toString(),
        //                 style: TextStyle(
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black)),
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 1),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text("Tax",
        //                 style: TextStyle(
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black)),
        //             Text(tax.toString(),
        //                 style: TextStyle(
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black)),
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 1),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text("Discount",
        //                 style: TextStyle(
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black)),
        //             Text(discount.toString(),
        //                 style: TextStyle(
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black)),
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 1),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text("TOTAL",
        //                 style: TextStyle(
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black)),
        //             Text(total.toString(),
        //                 style: TextStyle(
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black)),
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 1),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text("Cash Change",
        //                 style: TextStyle(
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black)),
        //             Text(cashChange.toString(),
        //                 style: TextStyle(
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.black)),
        //           ],
        //         ),
        //       ),
        //       Divider(thickness: 2),
        //       Center(
        //         child: Column(
        //           spacing: 10,
        //           children: [
        //             Text("Thank you for your visit!"),
        //             if (isReprint)
        //               Text("** REPRINT **",
        //                   style: TextStyle(color: Colors.red)),
        //             // Show returned items note if any items are marked as returned
        //             if (items.any((item) => item['isReturned'] == true))
        //               Padding(
        //                 padding: const EdgeInsets.only(top: 8.0),
        //                 child: Text(
        //                   "* Some items have been returned *",
        //                   style: TextStyle(
        //                       color: Colors.red, fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        );
  }
}
