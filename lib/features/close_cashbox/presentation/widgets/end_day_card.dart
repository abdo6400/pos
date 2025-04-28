import 'package:flutter/material.dart';

class EndDayCard extends StatelessWidget {
  final String cashierName;
  final double totalSales;
  final double totalTax;
  final double totalDiscount;
  final double cashAmount;
  final List<Map<String, dynamic>> paymentMethods;

  const EndDayCard({
    required this.cashierName,
    required this.totalSales,
    required this.totalTax,
    required this.totalDiscount,
    required this.cashAmount,
    required this.paymentMethods,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  Text("END OF DAY REPORT",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("Cashier: $cashierName"),
                  Text("Date: ${DateTime.now().toLocal()}"),
                  Divider(thickness: 2),
                ],
              ),
            ),

            // Summary
            _buildSummaryRow("Total Sales", totalSales),
            _buildSummaryRow("Total Tax", totalTax),
            _buildSummaryRow("Total Discount", totalDiscount),
            _buildSummaryRow("Cash in Drawer", cashAmount, isBold: true),
            Divider(thickness: 2),

            // Payment Methods
            Text("Payment Methods:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...paymentMethods.map((method) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Expanded(child: Text(method['name'])),
                      Expanded(
                          child:
                              Text("\$${method['amount'].toStringAsFixed(2)}")),
                    ],
                  ),
                )),

            // Footer
            Divider(thickness: 2),
            Center(
              child: Text("Day closed successfully",
                  style: TextStyle(fontStyle: FontStyle.italic)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label)),
          Expanded(
              child: Text("\$${value.toStringAsFixed(2)}",
                  style:
                      isBold ? TextStyle(fontWeight: FontWeight.bold) : null)),
        ],
      ),
    );
  }
}
