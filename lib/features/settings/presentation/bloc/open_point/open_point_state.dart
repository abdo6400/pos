part of 'open_point_bloc.dart';

abstract class OpenPointState extends Equatable {
  const OpenPointState();

  @override
  List<Object> get props => [];
}

class OpenPointInitial extends OpenPointState {}

class OpenPointLoading extends OpenPointState {}

class OpenPointSuccess extends OpenPointState {}

class OpenPointFailure extends OpenPointState {
  final String error;

  const OpenPointFailure({required this.error});

  @override
  List<Object> get props => [error];
}
