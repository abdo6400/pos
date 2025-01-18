import '../../../../config/database/local/local_consumer.dart';
import '../../../../config/database/local/tables_keys.dart';
import '../models/payment_type_model.dart';

abstract class PaymentLocalDataSource {
  Future<List<PaymentTypeModel>> getPaymentTypes();
  Future<List<Map<String, dynamic>>> getPendingInvoices();
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
    await _localConsumer.insert(TablesKeys.paymentsTable, data);
  }

  @override
  Future<List<Map<String, dynamic>>> getPendingInvoices() async {
    return await _localConsumer.queryAll(TablesKeys.paymentsTable);
  }

  @override
  Future<void> insertPaymentTypes(List<Map<String, dynamic>> dataList) async {
    await _localConsumer.insertMultiple(TablesKeys.paymentTypesTable, dataList);
  }
}
