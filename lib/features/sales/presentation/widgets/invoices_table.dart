import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/entities/field.dart';
import '../../../../core/entities/form.dart';
import '../../../../core/entities/settings.dart';
import '../../../../core/utils/enums/field_type_enums.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/empty_message.dart';
import '../../../../core/widgets/errors/error_card.dart';
import '../../../../core/widgets/global_form_builder/custom_form_builder.dart';
import '../../domain/entities/invoice.dart';
import '../../domain/entities/return_invoice.dart';
import '../bloc/invoice/invoice_bloc.dart';

class InvoicesTable extends StatefulWidget {
  final Settings settings;
  const InvoicesTable({super.key, required this.settings});

  @override
  InvoicesTableState createState() => InvoicesTableState();
}

class InvoicesTableState extends State<InvoicesTable> {
  static GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    int _rowsPerPage =
        context.AppResponsiveValue(5, mobile: 5, tablet: 10, desktop: 10)
            .toInt();
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
        bottomEnd: Radius.circular(20),
      )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            Expanded(
              child: BlocBuilder<InvoiceBloc, InvoiceState>(
                builder: (context, state) {
                  if (state is InvoicesError) {
                    return ErrorCard(
                      message: state.message,
                      onRetry: () {
                        final fromDate = _formKey.currentState!
                            .value[StringEnums.from_date.name] as DateTime;
                        final toDate = _formKey.currentState!
                            .value[StringEnums.to_date.name] as DateTime;
                        context.read<InvoiceBloc>().add(GetInvoicesEvent(
                            '${fromDate.year}-${fromDate.month}-${fromDate.day}',
                            '${toDate.year}-${toDate.month}-${toDate.day}'));
                      },
                    );
                  }
                  if (state is InvoicesSuccess && state.invoices.isEmpty) {
                    return EmptyMessage(
                        message: StringEnums.no_sales.name.tr());
                  }

                  final List<Invoice> invoices =
                      state is InvoicesSuccess ? state.invoices : [];
                  final List<ReturnInvoice> returnInvoices =
                      state is InvoicesSuccess ? state.returnInvoices : [];
                  return Skeletonizer(
                    enabled: state is InvoicesLoading,
                    child: Column(
                      children: [
                        Expanded(
                            child: _buildDataGrid(invoices, returnInvoices,
                                _rowsPerPage, context, widget.settings)),
                        // if (state is InvoicesSuccess)
                        //   _buildPaginationControls(invoices.length,
                        //       _rowsPerPage, _InvoiceDataSource(invoices)),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildSearchForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchForm(BuildContext context) {
    return Row(
      spacing: 30,
      children: [
        Expanded(
          flex: 3,
          child: CustomFormBuilder(FormParams(
              formKey: _formKey,
              layout: ResponsiveRowColumnType.ROW,
              fields: [
                FieldParams(
                    label: StringEnums.from_date.name,
                    icon: Icons.calendar_month,
                    type: FieldTypeEnums.dateTimePicker,
                    validators: []),
                FieldParams(
                    label: StringEnums.to_date.name,
                    icon: Icons.calendar_month,
                    type: FieldTypeEnums.dateTimePicker,
                    validators: []),
              ])),
        ),
        Expanded(
          child: CustomButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              buttonLabel: StringEnums.search.name,
              onSubmit: () {
                if (_formKey.currentState!.saveAndValidate()) {
                  final fromDate = _formKey.currentState!
                      .value[StringEnums.from_date.name] as DateTime;
                  final toDate = _formKey.currentState!
                      .value[StringEnums.to_date.name] as DateTime;
                  context.read<InvoiceBloc>().add(GetInvoicesEvent(
                      '${fromDate.year}-${fromDate.month}-${fromDate.day}',
                      '${toDate.year}-${toDate.month}-${toDate.day}'));
                }
              }),
        ),
        Expanded(child: SizedBox())
      ],
    );
  }

  Widget _buildDataGrid(
      List<Invoice> invoices,
      List<ReturnInvoice> returnInvoices,
      int rowsPerPage,
      BuildContext context,
      Settings settings) {
    final _invoiceDataSource = _InvoiceDataSource(invoices, returnInvoices,
        context: context, settings: settings);
    return SfDataGrid(
      columnWidthMode: ColumnWidthMode.fill,
      showCheckboxColumn: false,
      rowsPerPage: rowsPerPage,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      tableSummaryRows: [
        GridTableSummaryRow(
            showSummaryInRow: true,
            title: '${StringEnums.subTotalAmount.name.tr()}: {Sum}  ',
            columns: [
              GridSummaryColumn(
                  name: 'Sum',
                  columnName: StringEnums.subTotalAmount.name,
                  summaryType: GridSummaryType.sum)
            ],
            position: GridTableSummaryRowPosition.bottom)
      ],
      columns: [
        StringEnums.invoice_number,
        StringEnums.invoice_date,
        StringEnums.subTotalAmount,
        StringEnums.discountAmount,
        StringEnums.taxAmount,
        StringEnums.totalAmount,
        StringEnums.settings,
      ]
          .map((e) => GridColumn(
                columnName: e.name,
                label: Center(
                  child: Text(e.name.tr(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ))
          .toList(),
      source: _invoiceDataSource,
    );
  }

  // Widget _buildPaginationControls(
  //     int totalRows, int rowsPerPage, DataGridSource source) {
  //   final pageCount = (totalRows / rowsPerPage).ceil();
  //   return SfDataPager(
  //     delegate: source,
  //     pageCount: pageCount > 0 ? pageCount.toDouble() : 1.0,
  //     direction: Axis.horizontal,
  //     onPageNavigationStart: (int pageIndex) {
  //       // Optional: Add any logic needed when page navigation starts
  //     },
  //     onPageNavigationEnd: (int pageIndex) {
  //       // Optional: Add any logic needed when page navigation completes
  //     },);
  //}
}

class _InvoiceDataSource extends DataGridSource {
  final List<Invoice> _invoices;
  final List<ReturnInvoice> _returnInvoices;
  final BuildContext context;
  final Settings settings;

  _InvoiceDataSource(this._invoices, this._returnInvoices,
      {required this.context, required this.settings}) {
    _buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void _buildDataGridRows() {
    _dataGridRows = _invoices.map<DataGridRow>((invoice) {
      return DataGridRow(cells: [
        DataGridCell<double>(
            columnName: StringEnums.invoice_number.name,
            value: invoice.invoiceNo),
        DataGridCell<DateTime>(
            columnName: StringEnums.invoice_date.name,
            value: invoice.salesDate),
        DataGridCell<double>(
            columnName: StringEnums.subTotalAmount.name,
            value: invoice.invoiceSubTotal),
        DataGridCell<double>(
            columnName: StringEnums.discountAmount.name,
            value: invoice.invoiceDiscountTotal),
        DataGridCell<double>(
            columnName: StringEnums.taxAmount.name,
            value: invoice.invoiceTaxTotal),
        DataGridCell<double>(
            columnName: StringEnums.totalAmount.name,
            value: invoice.invoiceGrandTotal),
        DataGridCell<Map<String, dynamic>>(
            columnName: StringEnums.settings.name,
            value: {
              StringEnums.invoices.name: invoice,
              StringEnums.returnedItems.name: _returnInvoices.firstWhereOrNull(
                  (element) => element.invoiceNo == invoice.invoiceNo),
              StringEnums.settings.name: settings
            }),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      // color: _returnInvoices.firstWhereOrNull((element) =>
      //             element.invoiceNo == row.getCells()[0].value) !=
      //         null
      //     ? Colors.red.withOpacity(0.3)
      //     : null,
      cells: row.getCells().map<Widget>((dataGridCell) {
        if (dataGridCell.columnName == StringEnums.settings.name) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.visibility,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: () => context.push(AppRoutes.invoiceDetails,
                      extra: {...dataGridCell.value.cast<String, dynamic>(), 'isPrint': false}.cast<String, dynamic>()),
                ),
                IconButton(
                  icon: Icon(Icons.print,
                      color: Theme.of(context).colorScheme.secondary),
                  onPressed: () => context.push(AppRoutes.invoiceDetails,
                      extra: {...dataGridCell.value.cast<String, dynamic>(), 'isPrint': true}.cast<String, dynamic>()),
                ),
              ],
            ),
          );
        }
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(dataGridCell.value.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        );
      }).toList(),
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    // This method is called when the user navigates to a different page
    // We don't need to manually filter the data as SfDataGrid handles this internally
    // Just return true to allow the page change
    return true;
  }
}
