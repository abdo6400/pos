part of 'pay_bloc.dart';

sealed class PayState extends Equatable {
  const PayState();

  @override
  List<Object> get props => [];
}

class PayInitial extends PayState {}

class PayLoading extends PayState {}

class PaySuccess extends PayState {}

class PayError extends PayState {
  final String message;
  const PayError({required this.message});
}
