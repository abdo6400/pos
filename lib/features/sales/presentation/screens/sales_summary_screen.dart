import 'package:flutter/material.dart';
import '../widgets/invoices_table.dart';

class SalesSummaryScreen extends StatelessWidget {
  const SalesSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InvoicesTable(),
    );
  }
}
