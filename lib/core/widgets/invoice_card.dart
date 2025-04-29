import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/responsive.dart';

class InvoiceCard extends StatelessWidget {
  final String invoiceNumber;
  final String cashierName;
  final List<Map<String, dynamic>> items;
  final double subtotal;
  final double tax;
  final double discount;
  final double total;
  final double cashChange;
  final bool isReprint;

  const InvoiceCard({
    required this.invoiceNumber,
    required this.cashierName,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.discount,
    required this.total,
    required this.cashChange,
    this.isReprint = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(
            horizontal: context.AppResponsiveValue(
              20,
              mobile: 20,
              tablet: 20,
              desktop: 20,
            ),
            vertical: 20),
        color: Colors.white,
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              // Header
              Center(
                child: Column(
                  spacing: 10,
                  children: [
                    Text("RESTAURANT NAME",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Invoice #$invoiceNumber",
                        style: TextStyle(fontSize: 16)),
                    Text("Cashier: $cashierName"),
                    Text("Date: ${DateTime.now().toLocal()}"),
                    Divider(thickness: 2),
                  ],
                ),
              ),
          
              // Items List
              Column(
                spacing: 10,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 20,
                    children: [
                      Expanded(flex: 3, child: Text("Item")),
                      Expanded(child: Text("Qty")),
                      Expanded(child: Text("Price")),
                      Expanded(child: Text("Total")),
                    ],
                  ),
                  Divider(),
                  ...items.map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 20,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Text(
                                  item['name'],
                                  style: TextStyle(
                                    color: item['isReturned'] == true
                                        ? Colors.red
                                        : null,
                                    fontWeight: item['isReturned'] == true
                                        ? FontWeight.bold
                                        : null,
                                  ),
                                )),
                            Expanded(
                                child: Text(
                              item['qty'].toString(),
                              style: TextStyle(
                                color: item['isReturned'] == true
                                    ? Colors.red
                                    : null,
                              ),
                            )),
                            Expanded(
                                child: Text(
                              "\$${item['price'].toStringAsFixed(2)}",
                              style: TextStyle(
                                color: item['isReturned'] == true
                                    ? Colors.red
                                    : null,
                              ),
                            )),
                            Expanded(
                                child: Text(
                              "\$${item['total'].toStringAsFixed(2)}",
                              style: TextStyle(
                                color: item['isReturned'] == true
                                    ? Colors.red
                                    : null,
                              ),
                            )),
                          ],
                        ),
                      )),
                ],
              ),
          
              // Totals
              Divider(thickness: 2),
              _buildTotalRow("Subtotal", subtotal),
              _buildTotalRow("Tax", tax),
              _buildTotalRow("Discount", discount),
              _buildTotalRow("TOTAL", total, isBold: true),
              _buildTotalRow("Cash Change", cashChange),
          
              // Footer
              Divider(thickness: 2),
              Center(
                child: Column(
                  spacing: 10,
                  children: [
                    Text("Thank you for your visit!"),
                    if (isReprint)
                      Text("** REPRINT **", style: TextStyle(color: Colors.red)),
                    // Show returned items note if any items are marked as returned
                    if (items.any((item) => item['isReturned'] == true))
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "* Some items have been returned *",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      
    );
  }

  Widget _buildTotalRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          Expanded(flex: 3, child: Text(label)),
          Expanded(
              child: Text("\$${value.toStringAsFixed(2)}",
                  style:
                      isBold ? TextStyle(fontWeight: FontWeight.bold) : null)),
        ],
      ),
    );
  }
}
