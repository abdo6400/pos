import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/enums/state_enums.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../core/bloc/cubit/printing_cubit.dart';
import '../../../../core/entities/settings.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/errors/error_card.dart';
import '../../../../core/widgets/invoice_card.dart';
import '../../domain/entities/invoice.dart';
import '../../domain/entities/invoice_detail.dart';
import '../../domain/entities/return_invoice.dart';
import '../../domain/entities/return_invoice_detail.dart';
import '../../domain/usecases/return_invoice_usecase.dart';
import '../bloc/cubit/return_items_cubit.dart';
import '../bloc/invoice_detail/invoice_detail_bloc.dart';
import '../bloc/return_invoice/return_invoice_bloc.dart';
import '../widgets/return_invoice_card.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key});
  static ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final invoice = data[StringEnums.invoices.name] as Invoice;
    final returnInvoice =
        (data[StringEnums.returnedItems.name]) as ReturnInvoice?;
    final bool isPrint = data[StringEnums.isPrint.name] as bool;
    final settings = data[StringEnums.settings.name] as Settings;
    final fun = data[StringEnums.sales_summary.name];
    return BlocConsumer<ReturnInvoiceBloc, ReturnInvoiceState>(
      listener: (context, state) {
        if (state is ReturnInvoiceLoading) {
          context.showLottieOverlayLoader(Assets.loader);
        } else if (state is ReturnInvoiceLoaded) {
          context.handleState(
              StateEnum.success, StringEnums.returnedItems.name.tr());
          Navigator.pop(context);
          context.read<PrintingCubit>().handlePrint(settings, context,
              widget: ReturnInvoiceCard(returnInvoice: state.returnedInvoice),onPrint:(){
                fun();
              });
        } else if (state is ReturnInvoiceError) {
          context.handleState(StateEnum.error, state.message);
        }
      },
      builder: (context, state) {
        return BlocProvider(
          create: (context) => ReturnItemsCubit(),
          child: Scaffold(
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
                    if (!isPrint)
                      BlocBuilder<InvoiceDetailBloc, InvoiceDetailState>(
                        builder: (context, state) {
                          if (state is InvoiceDetailSuccess) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: BlocBuilder<ReturnItemsCubit,
                                  ReturnItemsState>(
                                builder: (context, _) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      _showReturnItemsDialog(
                                          context,
                                          state.invoiceDetail.invoiceDtl,
                                          state.invoiceDetail.invoices,
                                          invoice,
                                          (state.returnedInvoiceDetail?.dtl) ??
                                              []);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: Text(
                                      StringEnums.returnItems.name.tr(),
                                      style: TextStyle(
                                          fontSize: context.AppResponsiveValue(
                                              14,
                                              mobile: 12,
                                              tablet: 20,
                                              desktop: 16)),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                  ],
                ),
              ),
              bottomNavigationBar: isPrint
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 300, vertical: 20),
                      child: CustomButton(
                          buttonLabel: StringEnums.print.name,
                          onSubmit: () {
                            screenshotController.capture().then((image) {
                              if (image != null) {
                                context.read<PrintingCubit>().handlePrint(
                                    settings, context,
                                    image: image);
                              }
                            });
                          }),
                    )
                  : null,
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
                              invoiceId: invoice.invoiceNo.toString(),
                              returnId: returnInvoice?.returnId)),
                    );
                  } else if (state is InvoiceDetailSuccess) {
                    return isPrint
                        ? Center(
                          child: Screenshot(
                              controller: screenshotController,
                              child: SingleChildScrollView(
                                child: InvoiceCard(
                                  isReprint: true,
                                  exChangeAmount: 0,
                                  cashierName:
                                  state.invoiceDetail.invoices.takerName,
                                  cashChange:
                                  state.invoiceDetail.invoices.cashPayment,
                                  invoiceNumber: state
                                      .invoiceDetail.invoices.invoiceNo
                                      .toString(),
                                  items: state.invoiceDetail.invoiceDtl.map((e) {
                                    // Check if this item has been returned
                                    final bool isReturned = state
                                        .returnedInvoiceDetail?.dtl
                                        .any((returnItem) =>
                                    returnItem.itemId == e.item) ??
                                        false;
                          
                                    // If returned, find the returned item to get its quantity
                                    final returnedItem = isReturned
                                        ? state.returnedInvoiceDetail!.dtl
                                        .firstWhere((returnItem) =>
                                    returnItem.itemId == e.item)
                                        : null;
                          
                                    // Calculate the actual quantity after returns
                                    final actualQty = isReturned
                                        ? e.qty - returnedItem!.qty
                                        : e.qty;
                          
                                    // Calculate the actual total after returns
                                    final actualTotal = isReturned
                                        ? e.grandTotal - returnedItem!.grandTotal
                                        : e.grandTotal;
                          
                                    return {
                                      "name": isReturned
                                          ? "${e.item} (Partial Return)"
                                          : e.item,
                                      "qty": actualQty,
                                      "price": e.price,
                                      "total": actualTotal,
                                      "isReturned": isReturned
                                    };
                                  }).toList(),
                                  subtotal:
                                  state.invoiceDetail.invoices.invoiceSubTotal -
                                      (state.returnedInvoiceDetail != null
                                          ? state.returnedInvoiceDetail!.hdr
                                          .returnsSubTotal
                                          : 0.0),
                                  tax:
                                  state.invoiceDetail.invoices.invoiceTaxTotal -
                                      (state.returnedInvoiceDetail != null
                                          ? state.returnedInvoiceDetail!.hdr
                                          .returnsTaxTotal
                                          : 0.0),
                                  discount: state.invoiceDetail.invoices
                                      .invoiceDiscountTotal -
                                      (state.returnedInvoiceDetail != null
                                          ? state.returnedInvoiceDetail!.hdr
                                          .returnsDiscountTotal
                                          : 0.0),
                                  total: state.invoiceDetail.invoices
                                      .invoiceGrandTotal -
                                      (state.returnedInvoiceDetail != null
                                          ? state.returnedInvoiceDetail!.hdr
                                          .returnsGrandTotal
                                          : 0.0),
                                ),
                              ),
                            ),
                        )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInvoiceHeader(
                                        context,
                                        state.invoiceDetail.invoices,
                                        state.returnedInvoiceDetail?.hdr),
                                    const SizedBox(height: 20),
                                    _buildInvoiceItems(
                                        context,
                                        state.invoiceDetail.invoiceDtl,
                                        state.returnedInvoiceDetail?.dtl ?? []),
                                    const SizedBox(height: 20),
                                    _buildPaymentInfo(context,
                                        state.invoiceDetail.invoicePayment),
                                  ]),
                            ));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
        );
      },
    );
  }

  Widget _buildInvoiceHeader(BuildContext context, Invoices invoice,
      ReturnInvoiceHdr? returnInvoiceHdr) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    return Card(
      elevation: 0.2,
      color: returnInvoiceHdr != null ? Colors.red.withAlpha(100) : null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                StringEnums.invoices.name.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.AppResponsiveValue(16,
                      mobile: 14, tablet: 18, desktop: 20),
                ),
              ),
            ),
            _buildInfoRow(StringEnums.invoice_number.name.tr(),
                invoice.invoiceNo.toString(),
                context: context),
            _buildInfoRow(StringEnums.invoice_date.name.tr(),
                dateFormat.format(invoice.salesDate),
                context: context),
            _buildInfoRow(
                StringEnums.subTotalAmount.name.tr(),
                (invoice.invoiceSubTotal -
                        (returnInvoiceHdr?.returnsSubTotal ?? 0.0))
                    .toStringAsFixed(2),
                context: context),
            _buildInfoRow(
                StringEnums.discount.name.tr(),
                (invoice.invoiceDiscountTotal -
                        (returnInvoiceHdr?.returnsDiscountTotal ?? 0.0))
                    .toStringAsFixed(2),
                context: context),
            _buildInfoRow(
                StringEnums.taxAmount.name.tr(),
                (invoice.invoiceTaxTotal -
                        (returnInvoiceHdr?.returnsTaxTotal ?? 0.0))
                    .toStringAsFixed(2),
                context: context),
            _buildInfoRow(
                StringEnums.totalAmount.name.tr(),
                (invoice.invoiceGrandTotal -
                        (returnInvoiceHdr?.returnsGrandTotal ?? 0.0))
                    .toStringAsFixed(2),
                isTotal: true,
                context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {bool isTotal = false,
      bool isReturn = false,
      required BuildContext context}) {
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
                  color: isReturn ? Colors.red : null,
                  fontSize: context.AppResponsiveValue(14,
                      mobile: 12, tablet: 16, desktop: 16))),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isReturn ? Colors.red : null,
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

  Widget _buildInvoiceItems(BuildContext context, List<InvoiceDtl> items,
      List<returnInvoiceDtl> returnItems) {
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
            ...items.map((item) => Container(
                  decoration: BoxDecoration(
                    color: returnItems
                            .any((returnItem) => returnItem.itemId == item.item)
                        ? Colors.red.withOpacity(0.2)
                        : null,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              // Add a lock icon for returned items
                              if (returnItems.any((returnItem) =>
                                  returnItem.itemId == item.item))
                                const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.lock,
                                      color: Colors.red, size: 16),
                                ),
                              Expanded(
                                child: Text(item.item,
                                    style: TextStyle(
                                        fontSize: context.AppResponsiveValue(14,
                                            mobile: 12,
                                            tablet: 16,
                                            desktop: 16))),
                              ),
                            ],
                          )),
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

  void _showReturnItemsDialog(BuildContext ctx, List<InvoiceDtl> items,
      Invoices invoice, Invoice invoice1, List<returnInvoiceDtl> returnItems) {
    // Initialize the ReturnItemsCubit with the invoice items and previously returned items
    ctx.read<ReturnItemsCubit>().initItems(items, returnItems);

    showDialog(
      context: ctx,
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: ctx.read<ReturnItemsCubit>(),
          ),
        ],
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            width: MediaQuery.of(ctx).size.width * 0.8,
            height: MediaQuery.of(ctx).size.height * 0.8,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      invoice.invoiceNo.toString(),
                      style: TextStyle(
                        fontSize: ctx.AppResponsiveValue(20,
                            mobile: 18, tablet: 24, desktop: 26),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(dialogContext).pop(),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: Row(
                    children: [
                      // Available Items List
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringEnums.items.name.tr(),
                              style: TextStyle(
                                fontSize: ctx.AppResponsiveValue(16,
                                    mobile: 14, tablet: 18, desktop: 20),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: BlocBuilder<ReturnItemsCubit,
                                  ReturnItemsState>(
                                builder: (context, state) {
                                  return ListView.builder(
                                    itemCount: state.Items.length,
                                    itemBuilder: (context, index) {
                                      final item = state.Items[index];
                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: ListTile(
                                          title: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item.item,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Text(
                                            '${StringEnums.quentity.name.tr()}: ${item.qty} - ${StringEnums.price.name.tr()}: ${item.price.toStringAsFixed(2)}',
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(
                                                Icons.arrow_forward,
                                                color: Colors.green),
                                            onPressed: () {
                                              context
                                                  .read<ReturnItemsCubit>()
                                                  .addToReturnItems(item);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(),
                      // Return Items List
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringEnums.returnItems.name.tr(),
                              style: TextStyle(
                                fontSize: ctx.AppResponsiveValue(16,
                                    mobile: 14, tablet: 18, desktop: 20),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: BlocBuilder<ReturnItemsCubit,
                                  ReturnItemsState>(
                                builder: (context, state) {
                                  return ListView.builder(
                                    itemCount: state.returnItems.length,
                                    itemBuilder: (context, index) {
                                      final item = state.returnItems[index];
                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: ListTile(
                                          title: Text(
                                            item.item,
                                          ),
                                          subtitle: Text(
                                            '${StringEnums.quentity.name.tr()}: ${item.qty} - ${StringEnums.price.name.tr()}: ${item.price.toStringAsFixed(2)}',
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.arrow_back,
                                                color: Colors.red),
                                            onPressed: () {
                                              context
                                                  .read<ReturnItemsCubit>()
                                                  .removeFromReturnItems(item);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(),
                      // Return Items List
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringEnums.returnedItems.name.tr(),
                              style: TextStyle(
                                fontSize: ctx.AppResponsiveValue(16,
                                    mobile: 14, tablet: 18, desktop: 20),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: BlocBuilder<ReturnItemsCubit,
                                  ReturnItemsState>(
                                builder: (context, state) {
                                  return ListView.builder(
                                    itemCount: state.originallyReturned.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        // Apply red background for originally returned items
                                        color: Colors.red.withAlpha(100),
                                        child: ListTile(
                                            leading: const Icon(Icons.lock,
                                                color: Colors.red, size: 20),
                                            title: Text(
                                              state.originallyReturned[index]
                                                  .item,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              '${StringEnums.quentity.name.tr()}: ${state.originallyReturned[index].qty} - ${StringEnums.price.name.tr()}: ${state.originallyReturned[index].price.toStringAsFixed(2)}',
                                            ),
                                            trailing: Tooltip(
                                              message: StringEnums
                                                  .cannot_be_modified.name
                                                  .tr(),
                                              child: const Icon(
                                                  Icons.info_outline,
                                                  color: Colors.red),
                                            )),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: Text(StringEnums.cancel.name.tr()),
                        ),
                        const SizedBox(width: 16),
                        BlocBuilder<ReturnItemsCubit, ReturnItemsState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state.returnItems.isEmpty
                                  ? null
                                  : () {
                                      // // Create header for return invoice
                                      final hdr = Hdr(
                                        returnId:
                                            0, // Will be assigned by backend
                                        returnDate: DateTime.now(),
                                        invoiceNo: invoice1.invoiceNo,
                                        returnedBy: invoice.empTaker,
                                        fromCash: invoice1.invoiceCashNo,
                                        voidReason: 3, // Default reason
                                        extraNote: '',
                                        returnsSubTotal: _calculateSubTotal(
                                            state.returnItems),
                                        returnsDiscountTotal:
                                            _calculateDiscountTotal(
                                                state.returnItems),
                                        returnsServiceTotal: 0,
                                        returnsTaxTotal: _calculateTaxTotal(
                                            state.returnItems),
                                        returnsGrandTotal: _calculateGrandTotal(
                                            state.returnItems),
                                        warehouse: invoice.warehouse.toString(),
                                        encryptionSeal:
                                            invoice.encryptionSeal ?? "",
                                        guid: invoice.guid,
                                        qrcode: invoice.qrcode,
                                        companyId: invoice
                                            .deliveryCompany, // Default company ID
                                        payType: 0, // Default payment type
                                          stationId:''

                                      );

                                      // Create detail items for return
                                      final dtlItems = <Dtl>[];
                                      int index = 0;
                                      for (final item in state.returnItems) {
                                        dtlItems.add(Dtl(
                                          returnId: 0,
                                          indexId: index,
                                          itemId: item.item,
                                          qty: item.qty.toInt(),
                                          unitPrice: item.price,
                                          subTotal: item.subtotal,
                                          discount: item.discountV,
                                          taxValue: item.taxV,
                                          discountPercentage: item.discountP,
                                          taxPercentage: item.taxP,
                                          grandTotal: item.grandTotal,
                                          posted: true,
                                          warehouse: item.warehouse.toString(),
                                        ));
                                        index++; // Increment index after each item
                                      }
                                      Navigator.of(dialogContext).pop();
                                      ctx.read<ReturnInvoiceBloc>().add(
                                          ReturnedInvoice(ReturnParams(
                                              hdr: hdr, dtl: dtlItems)));
                                    },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              child: Text(StringEnums.confirm.name.tr()),
                            );
                          },
                        ),
                      ],
                    ),
                    BlocBuilder<ReturnItemsCubit, ReturnItemsState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            ctx.read<ReturnItemsCubit>().returnAllItems();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: state.Items.isEmpty
                                  ? Colors.red
                                  : Theme.of(ctx).primaryColor),
                          child: Text(
                            state.Items.isEmpty
                                ? StringEnums.restoreAll.name.tr()
                                : StringEnums.returnAll.name.tr(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods for calculating totals
  double _calculateSubTotal(List<InvoiceDtl> items) {
    return items.fold(0, (sum, item) => sum + item.subtotal);
  }

  double _calculateDiscountTotal(List<InvoiceDtl> items) {
    return items.fold(0, (sum, item) => sum + item.discountV);
  }

  double _calculateTaxTotal(List<InvoiceDtl> items) {
    return items.fold(0, (sum, item) => sum + item.taxV);
  }

  double _calculateGrandTotal(List<InvoiceDtl> items) {
    return items.fold(0, (sum, item) => sum + item.grandTotal);
  }
}
