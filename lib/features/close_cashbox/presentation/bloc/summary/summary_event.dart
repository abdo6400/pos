part of 'summary_bloc.dart';

sealed class SummaryEvent extends Equatable {
  const SummaryEvent();

  @override
  List<Object> get props => [];
}

class GetSummaryEvent extends SummaryEvent {
  final int? userNo;
  const GetSummaryEvent({this.userNo});
}
