part of 'get_sales_by_user_bloc.dart';

abstract class GetSalesByUserEvent {}

class GetSalesByUserRequested extends GetSalesByUserEvent {
  final int userId;

  GetSalesByUserRequested(this.userId);
}
