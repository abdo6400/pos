import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/api/end_points.dart';
import '../models/invoice_detail_model.dart';
import '../models/invoice_model.dart';
import '../models/return_invoice_detail_model.dart';
import '../models/return_invoice_model.dart';

abstract class SalesRemoteDataSource {
  Future<List<InvoiceModel>> getInvoices({
    required String branchId,
    required String userId,
    required String startDate,
    required String endDate,
  });

  Future<List<ReturnInvoiceModel>> getReturnedInvoices({
    required String branchId,
    required int userId,
  });

  Future<InvoiceDetailModel> getInvoicesDetail({
    required String invoiceNo,
  });
  Future<ReturnInvoiceDetailModel> getReturnedInvoicesDetail({
    required int returnId,
    required String branchId,
  });

  Future<void> returnInvoice(Map<String, dynamic> data);
}

class SalesRemoteDataSourceImpl extends SalesRemoteDataSource {
  final ApiConsumer _apiConsumer;

  SalesRemoteDataSourceImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  @override
  Future<List<InvoiceModel>> getInvoices(
      {required String branchId,
      required String userId,
      required String startDate,
      required String endDate}) async {
    final result = await _apiConsumer
        .get(EndPoints.getInvoicesByIntervalDate, queryParameters: {
      ApiKeys.warehouse: branchId,
      ApiKeys.userNo: userId,
      ApiKeys.fromDate: startDate,
      ApiKeys.toDate: endDate,
    });

    return List<InvoiceModel>.from(
        result[EndPoints.response].map((x) => InvoiceModel.fromJson(x)));
  }

  @override
  Future<InvoiceDetailModel> getInvoicesDetail(
      {required String invoiceNo}) async {
    final result =
        await _apiConsumer.get(EndPoints.getInvoiceDetail, queryParameters: {
      ApiKeys.invoiceNo: invoiceNo,
    });
    return InvoiceDetailModel.fromJson(result[EndPoints.response]);
  }

  @override
  Future<void> returnInvoice(Map<String, dynamic> data) async {
    await _apiConsumer.post(EndPoints.insertReturn,
        body: data, formDataIsEnabled: false);
  }

  @override
  Future<List<ReturnInvoiceModel>> getReturnedInvoices(
      {required String branchId, required int userId}) async {
    final result =
        await _apiConsumer.get(EndPoints.getReturnedInvoices, queryParameters: {
      ApiKeys.warehouse: branchId,
      ApiKeys.returnedBy: userId,
    });
    return List<ReturnInvoiceModel>.from(
        result[EndPoints.response].map((x) => ReturnInvoiceModel.fromJson(x)));
  }

  @override
  Future<ReturnInvoiceDetailModel> getReturnedInvoicesDetail(
      {required int returnId, required String branchId}) async {
    final result = await _apiConsumer
        .get(EndPoints.getReturnedInvoiceDetail, queryParameters: {
      ApiKeys.returnId: returnId,
      ApiKeys.warehouse: branchId,
    });
    return ReturnInvoiceDetailModel.fromJson(result[EndPoints.response]);
  }
}
