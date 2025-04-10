import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/api/end_points.dart';
import '../../../../core/models/cash_model.dart';
import '../models/invoice_id_model.dart';
import '../models/payment_type_model.dart';
import '../../../../core/models/sale_date_model.dart';

abstract class PaymentRemoteDataSource {
  Future<List<PaymentTypeModel>> getPaymentTypes();
  Future<void> pay(Map<String, dynamic> data);
  Future<InvoiceIdModel> getLastInvoiceId(int branchId);
  Future<CashModel> getCash(int userNo);
  Future<SaleDateModel> getSaleDate(int branchId);
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
    await _apiConsumer.post(EndPoints.insertInvoice,
        body: data, formDataIsEnabled: false);
  }

  @override
  Future<InvoiceIdModel> getLastInvoiceId(int branchId) async {
    final result = await _apiConsumer.get(EndPoints.getLastInvoiceNo,
        queryParameters: {ApiKeys.warehouse: branchId});
    return InvoiceIdModel.fromJson(result[EndPoints.response]);
  }

  @override
  Future<CashModel> getCash(int userNo) async {
    final result = await _apiConsumer.get(EndPoints.getSalesByUser,
        queryParameters: {ApiKeys.cashUser: userNo});
    return CashModel.fromJson(result[EndPoints.response]);
  }

  @override
  Future<SaleDateModel> getSaleDate(int branchId) async {
    final result = await _apiConsumer.get(EndPoints.getSalesByWarehouse,
        queryParameters: {ApiKeys.warehouse: branchId});
    return SaleDateModel.fromJson(result[EndPoints.response]);
  }
}
