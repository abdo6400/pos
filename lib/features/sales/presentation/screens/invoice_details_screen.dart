import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/responsive.dart';

import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/errors/error_card.dart';
import '../../domain/entities/invoice.dart';
import '../../domain/entities/invoice_detail.dart';
import '../bloc/invoice_detail/invoice_detail_bloc.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invoice = ModalRoute.of(context)?.settings.arguments as Invoice;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(context.AppResponsiveValue(60,
              mobile: 60, tablet: 80, desktop: 80)),
          child: AppBar(
            centerTitle: true,
            elevation: 2,
            title: Text(
                "${StringEnums.invoice_details.name.tr()} : " +
                    invoice.invoiceNo.toString(),
                style: TextStyle(
                    fontSize: context.AppResponsiveValue(20,
                        mobile: 18, tablet: 24, desktop: 30),
                    fontWeight: FontWeight.bold)),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, 
                  ),
                  child: Text(
                    StringEnums.returnItems.name.tr(),
                    style: TextStyle(
                        fontSize: context.AppResponsiveValue(14,
                            mobile: 12, tablet: 20, desktop: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<InvoiceDetailBloc, InvoiceDetailState>(
          builder: (context, state) {
            if (state is InvoiceDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is InvoiceDetailError) {
              return ErrorCard(
                message: state.message,
                onRetry: () => context.read<InvoiceDetailBloc>().add(
                    GetInvoiceDetailEvent(
                        invoiceId: invoice.invoiceNo.toString())),
              );
            } else if (state is InvoiceDetailSuccess) {
              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInvoiceHeader(
                              context, state.invoiceDetail.invoices),
                          const SizedBox(height: 20),
                          _buildInvoiceItems(
                              context, state.invoiceDetail.invoiceDtl),
                          const SizedBox(height: 20),
                          _buildPaymentInfo(
                              context, state.invoiceDetail.invoicePayment),
                        ]),
                  ));
            }
            // Initial state - trigger loading
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<InvoiceDetailBloc>().add(GetInvoiceDetailEvent(
                  invoiceId: invoice.invoiceNo.toString()));
            });
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget _buildInvoiceHeader(BuildContext context, Invoices invoice) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(StringEnums.invoice_number.name.tr(),
                invoice.invoiceNo.toString(),
                context: context),
            _buildInfoRow(StringEnums.invoice_date.name.tr(),
                dateFormat.format(invoice.salesDate),
                context: context),
            _buildInfoRow(StringEnums.subTotalAmount.name.tr(),
                invoice.invoiceSubTotal.toStringAsFixed(2),
                context: context),
            _buildInfoRow(StringEnums.discount.name.tr(),
                invoice.invoiceDiscountTotal.toStringAsFixed(2),
                context: context),
            _buildInfoRow(StringEnums.taxAmount.name.tr(),
                invoice.invoiceTaxTotal.toStringAsFixed(2),
                context: context),
            _buildInfoRow(StringEnums.totalAmount.name.tr(),
                invoice.invoiceGrandTotal.toStringAsFixed(2),
                isTotal: true, context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {bool isTotal = false, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: context.AppResponsiveValue(4.0,
              mobile: 4.0, tablet: 6.0, desktop: 8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: context.AppResponsiveValue(14,
                      mobile: 12, tablet: 16, desktop: 16))),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: context.AppResponsiveValue(isTotal ? 16 : 14,
                  mobile: isTotal ? 14 : 12,
                  tablet: isTotal ? 18 : 16,
                  desktop: isTotal ? 20 : 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceItems(BuildContext context, List<InvoiceDtl> items) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringEnums.items.name.tr(),
              style: TextStyle(
                  fontSize: context.AppResponsiveValue(18,
                      mobile: 16, tablet: 20, desktop: 24),
                  fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 8),
            // Table header
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text(StringEnums.name.name.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.AppResponsiveValue(14,
                                mobile: 12, tablet: 16, desktop: 16)))),
                Expanded(
                    child: Text(StringEnums.quentity.name.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.AppResponsiveValue(14,
                                mobile: 12, tablet: 16, desktop: 16)),
                        textAlign: TextAlign.center)),
                Expanded(
                    child: Text(StringEnums.price.name.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.AppResponsiveValue(14,
                                mobile: 12, tablet: 16, desktop: 16)),
                        textAlign: TextAlign.center)),
                Expanded(
                    child: Text(StringEnums.discount.name.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.AppResponsiveValue(14,
                                mobile: 12, tablet: 16, desktop: 16)),
                        textAlign: TextAlign.center)),
                Expanded(
                    flex: 2,
                    child: Text(StringEnums.total_price.name.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.AppResponsiveValue(14,
                                mobile: 12, tablet: 16, desktop: 16)),
                        textAlign: TextAlign.end)),
              ],
            ),
            const Divider(),
            // Table rows
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(item.item,
                              style: TextStyle(
                                  fontSize: context.AppResponsiveValue(14,
                                      mobile: 12, tablet: 16, desktop: 16)))),
                      Expanded(
                          child: Text(item.qty.toString(),
                              style: TextStyle(
                                  fontSize: context.AppResponsiveValue(14,
                                      mobile: 12, tablet: 16, desktop: 16)),
                              textAlign: TextAlign.center)),
                      Expanded(
                          child: Text(item.price.toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: context.AppResponsiveValue(14,
                                      mobile: 12, tablet: 16, desktop: 16)),
                              textAlign: TextAlign.center)),
                      Expanded(
                          child: Text(
                              item.discountV > 0
                                  ? item.discountV.toStringAsFixed(2)
                                  : '-',
                              style: TextStyle(
                                  fontSize: context.AppResponsiveValue(14,
                                      mobile: 12, tablet: 16, desktop: 16)),
                              textAlign: TextAlign.center)),
                      Expanded(
                          flex: 2,
                          child: Text(item.grandTotal.toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: context.AppResponsiveValue(14,
                                      mobile: 12, tablet: 16, desktop: 16)),
                              textAlign: TextAlign.end)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentInfo(
      BuildContext context, List<InvoicePayment> payments) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringEnums.payment_method.name.tr(),
              style: TextStyle(
                  fontSize: context.AppResponsiveValue(18,
                      mobile: 16, tablet: 20, desktop: 24),
                  fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 8),
            ...payments.map((payment) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(payment.payType.toString(),
                          style: TextStyle(
                              fontSize: context.AppResponsiveValue(14,
                                  mobile: 12, tablet: 16, desktop: 16))),
                      Text(payment.payment.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: context.AppResponsiveValue(14,
                                  mobile: 12, tablet: 16, desktop: 16))),
                    ],
                  ),
                )),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(StringEnums.total_price.name.tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.AppResponsiveValue(16,
                            mobile: 14, tablet: 18, desktop: 18))),
                Text(
                  payments
                      .fold(0.0, (sum, payment) => sum + payment.payment)
                      .toStringAsFixed(2),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: context.AppResponsiveValue(16,
                          mobile: 14, tablet: 18, desktop: 18)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
