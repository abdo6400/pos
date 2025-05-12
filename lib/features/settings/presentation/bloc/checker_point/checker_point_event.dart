part of 'checker_point_bloc.dart';

sealed class CheckerPointEvent extends Equatable {
  const CheckerPointEvent();

  @override
  List<Object> get props => [];
}

final class CheckPointStatus extends CheckerPointEvent {
 final VoidCallback? OnSuccess;
  const CheckPointStatus({this.OnSuccess});

  @override
  List<Object> get props => [];
}
