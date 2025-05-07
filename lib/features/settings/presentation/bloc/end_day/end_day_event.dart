part of 'end_day_bloc.dart';

abstract class EndDayEvent extends Equatable {
  const EndDayEvent();

  @override
  List<Object> get props => [];
}

class EndDayRequested extends EndDayEvent {
  final String lineDate;
  final String closeTime;


  const EndDayRequested({required this.lineDate, required this.closeTime});

  @override
  List<Object> get props => [lineDate, closeTime];
}
