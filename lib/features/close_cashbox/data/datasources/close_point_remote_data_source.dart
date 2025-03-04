import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/api/end_points.dart';
import '../models/cash_sale_model.dart';
import '../models/payment_summary_model.dart';
import '../models/sale_summary_model.dart';

abstract class ClosePointRemoteDataSource {
  Future<void> closePoint(Map<String, dynamic> data);
  Future<List<PaymentSummaryModel>> getPaymentsSummary(
      String cashNo, String wareHouse);
  Future<CashSaleModel> getCashSaleSummary(String cashNo);
  Future<List<SaleSummaryModel>> getSalesSummary(String cashNo);
}

class ClosePointRemoteDataSourceImpl extends ClosePointRemoteDataSource {
  final ApiConsumer _apiConsumer;

  ClosePointRemoteDataSourceImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  @override
  Future<void> closePoint(Map<String, dynamic> data) async {
    await _apiConsumer.post(EndPoints.closePoint, body: data);
  }

  @override
  Future<CashSaleModel> getCashSaleSummary(String cashNo) async {
    final response = await _apiConsumer.get(EndPoints.getCashSalesSummary,
        queryParameters: {ApiKeys.cashNo: cashNo});
    return CashSaleModel.fromJson(response);
  }

  @override
  Future<List<PaymentSummaryModel>> getPaymentsSummary(
      String cashNo, String wareHouse) async {
    final response = await _apiConsumer.get(EndPoints.getSalesByCashNo,
        queryParameters: {
          ApiKeys.warehouse: wareHouse,
          ApiKeys.cashNo: cashNo
        });
    return List<PaymentSummaryModel>.from(
        response.map((x) => PaymentSummaryModel.fromJson(x)));
  }

  @override
  Future<List<SaleSummaryModel>> getSalesSummary(String cashNo) async {
    final response = await _apiConsumer.get(EndPoints.getSalesSummary,
        queryParameters: {ApiKeys.cashNo: cashNo});
    return List<SaleSummaryModel>.from(
        response.map((x) => SaleSummaryModel.fromJson(x)));
  }
}
