part of 'open_point_bloc.dart';

abstract class OpenPointEvent extends Equatable {
  const OpenPointEvent();

  @override
  List<Object> get props => [];
}

class OpenPointRequested extends OpenPointEvent {
  final Map<String, dynamic> data;

  const OpenPointRequested({required this.data});

  @override
  List<Object> get props => [data];
}
