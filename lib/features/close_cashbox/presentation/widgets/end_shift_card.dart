import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../../domain/entities/payment_summary.dart';

class EndShiftCard extends StatelessWidget {
  final String cashierName;
  final double totalSales;
  final double totalTax;
  final double totalDiscount;
  final double cashAmount;
  final List<PaymentSummary> paymentMethods;

  const EndShiftCard({
    required this.cashierName,
    required this.totalSales,
    required this.totalTax,
    required this.totalDiscount,
    required this.cashAmount,
    required this.paymentMethods,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle smallTextStyle1 = TextStyle(fontFamily: 'ARIAL', fontSize: 14,color: Colors.black);
    TextStyle smallBoldTextStyle =
    TextStyle(fontFamily: 'ARIAL', fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black);

    TextStyle bigBoldTextStyle =
    TextStyle(fontFamily: 'ARIAL', fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black);
    return Container(
      width: 600,
      padding: EdgeInsets.symmetric(
          horizontal: context.AppResponsiveValue(
            20,
            mobile: 20,
            tablet: 20,
            desktop: 20,
          ),
          vertical: 20),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Text(
              "X",
              style: TextStyle(
                fontFamily: 'ARIAL',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(color: Colors.black, height: 1),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text(
              'Restaurant Name',
              style: smallBoldTextStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              "Close Shift",
              style: smallBoldTextStyle,
            ),
          ),
          Divider(color: Colors.black, height: 1, thickness: 2),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Cashier",
                    style: smallBoldTextStyle,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(":", style: smallTextStyle1),
                ),
                Expanded(
                  flex: 12,
                  child: Text(
                    cashierName, // Replace 'pos' with actual cashier name
                    style: smallTextStyle1,
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
                  flex: 4,
                  child: Text("Start Time", style: smallBoldTextStyle),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(":", style: smallTextStyle1),
                ),
                Expanded(
                  flex: 12,
                  child: Text('start .toString()', style: smallTextStyle1),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text("End Time", style: smallBoldTextStyle),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(":", style: smallTextStyle1),
                ),
                Expanded(
                  flex: 12,
                  child: Text('EndDays.toString()', style: smallTextStyle1),
                ),
              ],
            ),
          ),

          // Sales Summary
          SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text("Sales Summery Value", style: bigBoldTextStyle),
                ),
              ],
            ),
          ),
          Divider(color: Colors.black, height: 2, thickness: 2),

          // Totals
          _buildSummaryRow("Subtotal", totalSales),
          _buildSummaryRow("Discount", totalDiscount),
          _buildSummaryRow("Subtotal+Discount", totalSales-totalTax),
          _buildSummaryRow("Tax", totalTax),
          _buildSummaryRow("Total", totalSales),

          // Payments
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text("Payment Methods", style: bigBoldTextStyle),
                ),
              ],
            ),
          ),
          Divider(color: Colors.red, height: 2, thickness: 2),

          // Payment Methods Header
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text("Payment Type", textAlign: TextAlign.center, style: smallBoldTextStyle),
                ),
                Expanded(
                  flex: 1,
                  child: Text("Value", textAlign: TextAlign.center, style: smallBoldTextStyle),
                ),
              ],
            ),
          ),
          // List payment methods
          ...paymentMethods.map((method) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Expanded(child: Text(method.desc)),
                Expanded(child: Text("\$${method.sum.toStringAsFixed(2)}")),
              ],
            ),
          )),

          SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text("General Summery", style: bigBoldTextStyle),
                ),
              ],
            ),
          ),
          Divider(color: Colors.black, height: 1),

          // General Summary
          _buildSummaryRow("Cash Payment", cashAmount),
          _buildSummaryRow("Return Payment", 4),
          _buildSummaryRow("Opening Balance", 5),

          // Footer
          Divider(color: Colors.black, height: 1),
          Container(
            color: Colors.black,
            child: Column(
              children: [
                _buildFooterRow("Available Cash", '5'),
                _buildFooterRow("Required Cash", '5'),
                _buildFooterRow("Difference", '5'),
              ],
            ),
          ),
          Divider(color: Colors.black, height: 1),

          // Print Button
          MaterialButton(
            onPressed: () {
              // Utils.capture(myKey, context);
            },
            color: Colors.blueAccent,
            child: Text("Print"),
          ),
        ],
      ),

// Helper Methods





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
  Widget _buildFooterRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text(label, style: TextStyle(color: Colors.white))),
          Expanded(flex: 12, child: Text(value, style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
