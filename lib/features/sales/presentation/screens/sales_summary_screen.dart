import 'package:flutter/material.dart';
import '../../../../core/entities/settings.dart';
import '../widgets/invoices_table.dart';

class SalesSummaryScreen extends StatelessWidget {
  final Settings settings;
  const SalesSummaryScreen({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InvoicesTable(
        settings: settings,
      ),
    );
  }
}
