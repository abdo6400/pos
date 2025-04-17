part of 'checker_point_bloc.dart';

sealed class CheckerPointEvent extends Equatable {
  const CheckerPointEvent();

  @override
  List<Object> get props => [];
}

final class CheckPointStatus extends CheckerPointEvent {
  const CheckPointStatus();

  @override
  List<Object> get props => [];
}
