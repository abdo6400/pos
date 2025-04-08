part of 'opened_points_bloc.dart';

sealed class OpenedPointsState extends Equatable {
  const OpenedPointsState();

  @override
  List<Object> get props => [];
}

final class OpenedPointsInitial extends OpenedPointsState {}

final class OpenedPointsLoading extends OpenedPointsState {}

final class OpenedPointsSuccess extends OpenedPointsState {
  final List<Cash> openedPoints;

  const OpenedPointsSuccess({required this.openedPoints});

  @override
  List<Object> get props => [openedPoints];
}

final class OpenedPointsFailure extends OpenedPointsState {
  final String message;

  const OpenedPointsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
