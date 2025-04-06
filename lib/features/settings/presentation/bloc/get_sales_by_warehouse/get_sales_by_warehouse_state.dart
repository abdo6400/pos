part of 'get_sales_by_warehouse_bloc.dart';

abstract class GetSalesByWarehouseState {}

class GetSalesByWarehouseInitial extends GetSalesByWarehouseState {}

class GetSalesByWarehouseLoading extends GetSalesByWarehouseState {}

class GetSalesByWarehouseSuccess extends GetSalesByWarehouseState {
  final List<SaleDate> sales;

  GetSalesByWarehouseSuccess({required this.sales});
}

class GetSalesByWarehouseFailure extends GetSalesByWarehouseState {
  final String message;

  GetSalesByWarehouseFailure({required this.message});
}
