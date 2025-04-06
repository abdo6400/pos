part of 'end_day_bloc.dart';

abstract class EndDayEvent extends Equatable {
  const EndDayEvent();

  @override
  List<Object> get props => [];
}

class EndDayRequested extends EndDayEvent {
  final Map<String, dynamic> data;

  const EndDayRequested({required this.data});

  @override
  List<Object> get props => [data];
}
