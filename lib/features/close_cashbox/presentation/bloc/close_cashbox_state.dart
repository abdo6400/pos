part of 'close_cashbox_bloc.dart';

abstract class CloseCashboxState extends Equatable {
  const CloseCashboxState();

  @override
  List<Object> get props => [];
}

class CloseCashboxInitial extends CloseCashboxState {}

class CloseCashboxLoading extends CloseCashboxState {}

class CloseCashboxSuccess extends CloseCashboxState {}

class CloseCashboxError extends CloseCashboxState {
  final String message;
  const CloseCashboxError({required this.message});
}
