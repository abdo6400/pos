part of 'close_cashbox_bloc.dart';

abstract class CloseCashboxEvent extends Equatable {
  const CloseCashboxEvent();

  @override
  List<Object> get props => [];
}

class ClosePointEvent extends CloseCashboxEvent {
  final ClosePointParams closePointParams;

  const ClosePointEvent({required this.closePointParams});
}
