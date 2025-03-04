import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sales_report_event.dart';
part 'sales_report_state.dart';

class SalesReportBloc extends Bloc<SalesReportEvent, SalesReportState> {
  SalesReportBloc() : super(SalesReportInitial()) {
    on<SalesReportEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
