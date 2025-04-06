part of 'get_sales_by_warehouse_bloc.dart';

abstract class GetSalesByWarehouseEvent {}

class GetSalesByWarehouseRequested extends GetSalesByWarehouseEvent {
  final String branchId;

  GetSalesByWarehouseRequested(this.branchId);
}
