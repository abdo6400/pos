part of 'opened_points_bloc.dart';

sealed class OpenedPointsEvent extends Equatable {
  const OpenedPointsEvent();

  @override
  List<Object> get props => [];
}

final class OpenedPointsRequested extends OpenedPointsEvent {
  final String startDate;
  const OpenedPointsRequested(this.startDate);
}
