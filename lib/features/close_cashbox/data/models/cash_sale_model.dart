import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/cash_sale.dart';

class CashSaleModel extends CashSale {
  CashSaleModel(
      {required super.cashSales,
      required super.orderReturn,
      required super.cashCustody});

  factory CashSaleModel.fromJson(Map<String, dynamic> json) {
    return CashSaleModel(
        cashSales: json[ApiKeys.cashSales],
        orderReturn: json[ApiKeys.orderReturn],
        cashCustody: json[ApiKeys.cashCustody]);
  }
}
