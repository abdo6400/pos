part of 'sales_report_bloc.dart';

abstract class SalesReportState extends Equatable {
  const SalesReportState();  

  @override
  List<Object> get props => [];
}
class SalesReportInitial extends SalesReportState {}
