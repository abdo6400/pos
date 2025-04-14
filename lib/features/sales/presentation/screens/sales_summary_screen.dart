import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/invoice/invoice_bloc.dart';
import '../bloc/invoice_detail/invoice_detail_bloc.dart';
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
