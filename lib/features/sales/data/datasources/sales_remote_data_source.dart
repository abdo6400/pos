import '../../../../config/database/api/api_consumer.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/api/end_points.dart';
import '../models/invoice_detail_model.dart';
import '../models/invoice_model.dart';

abstract class SalesRemoteDataSource {
  Future<List<InvoiceModel>> getInvoices({
    required String branchId,
    required String userId,
    required String startDate,
    required String endDate,
  });

  Future<InvoiceDetailModel> getInvoicesDetail({
    required String invoiceNo,
  });
}

class SalesRemoteDataSourceImpl extends SalesRemoteDataSource {
  final ApiConsumer _apiConsumer;

  SalesRemoteDataSourceImpl(this._apiConsumer);
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

    return List<InvoiceModel>.from(result.map((x) => InvoiceModel.fromJson(x)));
  }

  @override
  Future<InvoiceDetailModel> getInvoicesDetail(
      {required String invoiceNo}) async {
    final result =
        await _apiConsumer.get(EndPoints.getInvoiceDetail, queryParameters: {
      ApiKeys.invoiceNo: invoiceNo,
    });
    return InvoiceDetailModel.fromJson(result);
  }
}
