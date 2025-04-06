part of 'get_sales_by_user_bloc.dart';

abstract class GetSalesByUserState {}

class GetSalesByUserInitial extends GetSalesByUserState {}

class GetSalesByUserLoading extends GetSalesByUserState {}

class GetSalesByUserSuccess extends GetSalesByUserState {
  final Cash cash;

  GetSalesByUserSuccess({required this.cash});
}

class GetSalesByUserFailure extends GetSalesByUserState {
  final String message;

  GetSalesByUserFailure({required this.message});
}
