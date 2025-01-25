import '../../../../config/database/local/local_consumer.dart';
import '../../../../config/database/local/tables_keys.dart';
import '../models/invoice_model.dart';
import '../models/payment_type_model.dart';

abstract class PaymentLocalDataSource {
  Future<List<PaymentTypeModel>> getPaymentTypes();
  Future<List<InvoiceModel>> getPendingInvoices();
  Future<void> insertPaymentTypes(List<Map<String, dynamic>> dataList);
  Future<void> pay(Map<String, dynamic> data);
}

class PaymentLocalDataSourceImpl extends PaymentLocalDataSource {
  final LocalConsumer _localConsumer;

  PaymentLocalDataSourceImpl({required LocalConsumer localConsumer})
      : _localConsumer = localConsumer;
  @override
  Future<List<PaymentTypeModel>> getPaymentTypes() async {
    final response =
        await _localConsumer.queryAll(TablesKeys.paymentTypesTable);
    return List<PaymentTypeModel>.from(
        response.map((x) => PaymentTypeModel.fromJson(x)));
  }

  @override
  Future<void> pay(Map<String, dynamic> data) async {
    Map<String, dynamic> invoice = data[TablesKeys.invoices];
    List<Map<String, dynamic>> invoiceDtl =
        (data[TablesKeys.invoiceDtl] as List<dynamic>)
            .cast<Map<String, dynamic>>();
    List<Map<String, dynamic>> invoicePayment =
        (data[TablesKeys.invoicePayment] as List<dynamic>)
            .cast<Map<String, dynamic>>();
    await _localConsumer.insert(TablesKeys.paymentsTable, invoice);
    await _localConsumer.insertMultiple(TablesKeys.invoiceDtlTable, invoiceDtl);
    await _localConsumer.insertMultiple(
        TablesKeys.invoicePaymentTable, invoicePayment);
  }

  @override
  Future<List<InvoiceModel>> getPendingInvoices() async {
    final List<Map<String, dynamic>> data = [];
    final invoices = await _localConsumer.queryAll(TablesKeys.paymentsTable);
    final invoiceDtl =
        await _localConsumer.queryAll(TablesKeys.invoiceDtlTable);
    final payments =
        await _localConsumer.queryAll(TablesKeys.invoicePaymentTable);
    for (final invoice in invoices) {
      final mutableInvoice = Map<String, dynamic>.from(invoice);
      mutableInvoice[TablesKeys.invoiceDtl] = invoiceDtl
          .where(
              (x) => x[TablesKeys.invoiceNo] == invoice[TablesKeys.invoiceNo])
          .toList();
      mutableInvoice[TablesKeys.invoicePayment] = payments
          .where(
              (x) => x[TablesKeys.invoiceId] == invoice[TablesKeys.invoiceNo])
          .toList();
      data.add(mutableInvoice);
    }

    return List<InvoiceModel>.from(data.map((x) => InvoiceModel.fromJson(x)));
  }

  @override
  Future<void> insertPaymentTypes(List<Map<String, dynamic>> dataList) async {
    await _localConsumer.insertMultiple(TablesKeys.paymentTypesTable, dataList);
  }
}
