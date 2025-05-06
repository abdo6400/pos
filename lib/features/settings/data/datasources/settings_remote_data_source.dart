import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/api/end_points.dart';
import '../../../../core/models/cash_model.dart';
import '../../../../core/models/sale_date_model.dart';
import '../models/end_day_report_model.dart';
import '../models/setting_model.dart';

abstract class SettingsRemoteDataSource {
  Future<List<SettingModel>> getSettings(String branchId);
  Future<SaleDateModel> getSalesByWarehouse(String branchId);
  Future<CashModel> getSalesByUser(int userId);
  Future<List<CashModel>> getOpenedPointsByUser(
      String startDate, String branchId);
  Future<void> openPointByParameters(Map<String, dynamic> data);
  Future<void> endDay(Map<String, dynamic> data);
  Future<void> insertByParameters(Map<String, dynamic> data);
  Future<List<EndDayReportModel>> getEndDayReport(
      int branchId, String lineDate);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final ApiConsumer _apiConsumer;

  SettingsRemoteDataSourceImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  @override
  Future<List<SettingModel>> getSettings(String branchId) async {
    final response = await _apiConsumer.get(EndPoints.getSettings,
        queryParameters: {ApiKeys.warehouse: branchId});
    return List<SettingModel>.from(
        response[EndPoints.response].map((x) => SettingModel.fromJson(x)));
  }

  @override
  Future<SaleDateModel> getSalesByWarehouse(String branchId) async {
    final response = await _apiConsumer.get(EndPoints.getSalesByWarehouse,
        queryParameters: {ApiKeys.warehouse: branchId});
    return SaleDateModel.fromJson(response[EndPoints.response]);
  }

  @override
  Future<CashModel> getSalesByUser(int userId) async {
    final response = await _apiConsumer.get(EndPoints.getSalesByUser,
        queryParameters: {ApiKeys.cashUser: userId});
    return CashModel.fromJson(response[EndPoints.response]);
  }

  @override
  Future<void> openPointByParameters(Map<String, dynamic> data) async {
    await _apiConsumer.post(EndPoints.openPointByParameters,
        queryParameters: data);
  }

  @override
  Future<void> endDay(Map<String, dynamic> data) async {
    await _apiConsumer.post(EndPoints.endDay,
        body: data, formDataIsEnabled: false);
  }

  @override
  Future<List<CashModel>> getOpenedPointsByUser(
      String startDate, String branchId) async {
    final response = await _apiConsumer.get(EndPoints.getSalesByDate,
        queryParameters: {
          ApiKeys.cashStartDate: startDate,
          ApiKeys.warehouse: branchId
        });
    return List<CashModel>.from(
        response[EndPoints.response].map((x) => CashModel.fromJson(x)));
  }

  @override
  Future<void> insertByParameters(Map<String, dynamic> data) async {
    await _apiConsumer.post(EndPoints.insertByParameters,
        queryParameters: data);
  }

  @override
  Future<List<EndDayReportModel>> getEndDayReport(
      int branchId, String lineDate) async {
    final result = await _apiConsumer.get(EndPoints.getSalesZReport,
        queryParameters: {
          ApiKeys.warehouse: branchId,
          ApiKeys.lineDate: lineDate
        });
    return result[EndPoints.response]
        .map<EndDayReportModel>(
            (x) => EndDayReportModel.fromJson(x[ApiKeys.zReport]))
        .toList();
  }
}
