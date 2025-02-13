import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/invoice/invoice_bloc.dart';
import '../bloc/invoice_detail/invoice_detail_bloc.dart';
import 'invoices_table.dart';

class SalesSummaryScreen extends StatelessWidget {
  const SalesSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<InvoiceBloc>()),
        BlocProvider.value(value: locator<InvoiceDetailBloc>()),
      ],
      child: Scaffold(
        body: InvoicesTable(),
      ),
    );
  }
}
