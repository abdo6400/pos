import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/entities/sale_date.dart';
import '../../../domain/entities/setting.dart';

class ComparisonCubit extends Cubit<Map<String, dynamic>> {
  ComparisonCubit() : super({}) {
    init();
  }

  bool isError = false;
  bool isLoading = true;
  bool mustCloseDay = false;

  void init() {
    emit({});
  }

  void hasError() {
    isLoading = false;
    isError = true;
    emit(state);
  }

  bool get isSuccess => !isError && !isLoading && _compareValues();

  void updateFirstValue(SaleDate value) {
    isLoading = false;
    emit({...state, 'firstValue': value});
  }

  void updateSecondValue(List<Setting> value) {
    isLoading = false;
    emit({...state, 'secondValue': value});
  }

  bool _compareValues() {
    final SaleDate firstValue = state['firstValue'];
    final List<Setting> secondValue = state['secondValue'];
    bool isSuccess = false;
    if (secondValue.isNotEmpty) {
      final closingHour =
          int.parse(DateFormat.H().format(secondValue[1].value5));
      var closingTime = firstValue.lineDate;
      final hourDifference = 24 - closingHour;
      if (hourDifference > 12) {
        closingTime = closingTime.add(Duration(days: 1, hours: closingHour));
      } else {
        closingTime = closingTime.add(Duration(hours: closingHour));
      }

      if (DateTime.now().isAfter(closingTime)) {
        mustCloseDay = true;
      }
      isSuccess = true;
    }
    return isSuccess;
  }
}
