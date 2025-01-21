import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/invoice_id.dart';

class InvoiceIdModel extends InvoiceId {
  InvoiceIdModel({required super.invoiceNo, required super.queue});

  factory InvoiceIdModel.fromJson(Map<String, dynamic> json) => InvoiceIdModel(
        invoiceNo: json[ApiKeys.invoiceNo],
        queue: json[ApiKeys.queue],
      );

  Map<String, dynamic> toJson() => {
        ApiKeys.invoiceNo: invoiceNo,
        ApiKeys.queue: queue,
      };
}
