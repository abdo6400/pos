part of 'end_day_bloc.dart';

abstract class EndDayState extends Equatable {
  const EndDayState();

  @override
  List<Object> get props => [];
}

class EndDayInitial extends EndDayState {}

class EndDayLoading extends EndDayState {}

class EndDaySuccess extends EndDayState {}

class EndDayFailure extends EndDayState {
  final String error;

  const EndDayFailure({required this.error});

  @override
  List<Object> get props => [error];
}
