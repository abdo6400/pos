part of 'discount_bloc.dart';

sealed class DiscountState extends Equatable {
  const DiscountState();

  @override
  List<Object> get props => [];
}

final class DiscountInitial extends DiscountState {}

class DiscountLoading extends DiscountState {}

class DiscountSuccess extends DiscountState {
  final List<Discount> discounts;

  DiscountSuccess(this.discounts);
}

class DiscountError extends DiscountState {
  final String message;
  DiscountError(this.message);
}
