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
  String startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String closeTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
  void init() {
    isLoading = true;
    isError = false;
    emit({});
  }

  void hasError() {
    isLoading = false;
    isError = true;
    emit(state);
  }

  bool get isSuccess => !isError && !isLoading && _compareValues();

  void updateFirstValue(SaleDate value) {
    if (state.isNotEmpty) {
      isLoading = false;
    }
    if (!isError) {
      emit({...state, 'firstValue': value});
    }
  }

  void updateSecondValue(List<Setting> value) {
    if (state.isNotEmpty) {
      isLoading = false;
    }
    if (!isError) {
      emit({...state, 'secondValue': value});
    }
  }

  bool _compareValues() {
    final SaleDate? firstValue = state['firstValue'];
    final List<Setting>? secondValue = state['secondValue'];
    bool isSuccess = false;
    if (firstValue != null && secondValue != null && secondValue.isNotEmpty) {
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
      closeTime = closingTime.toIso8601String();
      startDate = firstValue.lineDate.toIso8601String();
      isSuccess = true;
    }
    return isSuccess;
  }
}
