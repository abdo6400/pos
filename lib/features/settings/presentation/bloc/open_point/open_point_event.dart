part of 'open_point_bloc.dart';

abstract class OpenPointEvent extends Equatable {
  const OpenPointEvent();

  @override
  List<Object> get props => [];
}

class OpenPointRequested extends OpenPointEvent {
  final double cashCustody;
  const OpenPointRequested({ required this.cashCustody});

  @override
  List<Object> get props => [cashCustody];
}
