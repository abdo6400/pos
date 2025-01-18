import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/api/end_points.dart';
import '../models/payment_type_model.dart';

abstract class PaymentRemoteDataSource {
  Future<List<PaymentTypeModel>> getPaymentTypes();
  Future<void> pay(Map<String, dynamic> data);
  Future<String> getLastInvoiceId(int branchId);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final ApiConsumer _apiConsumer;

  PaymentRemoteDataSourceImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;
  @override
  Future<List<PaymentTypeModel>> getPaymentTypes() async {
    final response = await _apiConsumer.get(EndPoints.getAllPaymentTypes);
    return List<PaymentTypeModel>.from(
        response.map((x) => PaymentTypeModel.fromJson(x)));
  }

  @override
  Future<void> pay(Map<String, dynamic> data) async {
    return await _apiConsumer.post(EndPoints.insertInvoice,
        body: data, formDataIsEnabled: false);
  }

  @override
  Future<String> getLastInvoiceId(int branchId) async {
    return (await _apiConsumer.get(EndPoints.getLastInvoiceNo,
            queryParameters: {ApiKeys.warehouse: branchId}))[EndPoints.response]
        [ApiKeys.invoiceNo];
  }
}
