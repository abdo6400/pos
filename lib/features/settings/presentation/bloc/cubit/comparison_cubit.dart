import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/entities/cash.dart';
import '../../../../../core/entities/sale_date.dart';
import '../../../domain/entities/setting.dart';

// Define a proper state class for better state management
class ComparisonState extends Equatable {
  final SaleDate? firstValue;
  final List<Setting>? secondValue;
  final Cash? thirdValue;
  final bool isLoading;
  final bool isError;
  final bool mustCloseDay;
  final bool hasPoint;
  final String startDate;
  final String closeTime;

  const ComparisonState({
    this.firstValue,
    this.secondValue,
    this.thirdValue,
    this.isLoading = true,
    this.isError = false,
    this.mustCloseDay = false,
    this.hasPoint = false,
    this.startDate = '',
    this.closeTime = '',
  });

  ComparisonState copyWith({
    SaleDate? firstValue,
    List<Setting>? secondValue,
    Cash? thirdValue,
    bool? isLoading,
    bool? isError,
    bool? mustCloseDay,
    bool? hasPoint,
    String? startDate,
    String? closeTime,
  }) {
    return ComparisonState(
      firstValue: firstValue ?? this.firstValue,
      secondValue: secondValue ?? this.secondValue,
      thirdValue: thirdValue ?? this.thirdValue,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      mustCloseDay: mustCloseDay ?? this.mustCloseDay,
      hasPoint: hasPoint ?? this.hasPoint,
      startDate: startDate ?? this.startDate,
      closeTime: closeTime ?? this.closeTime,
    );
  }

  @override
  List<Object?> get props => [
        firstValue,
        secondValue,
        thirdValue,
        isLoading,
        isError,
        mustCloseDay,
        hasPoint,
        startDate,
        closeTime,
      ];
}

class ComparisonCubit extends Cubit<ComparisonState> {
  ComparisonCubit() : super(ComparisonState(
    startDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    closeTime: DateFormat('yyyy-MM-dd').format(DateTime.now()),
  )) {
    init();
  }

  void init() {
    emit(state.copyWith(isLoading: true, isError: false));
  }

  void hasError() {
    emit(state.copyWith(isLoading: false, isError: true));
  }

  bool get isSuccess => !state.isError && !state.isLoading && _compareValues();
  bool get isLoading => state.isLoading;
  bool get isError => state.isError;
  bool get mustCloseDay => state.mustCloseDay;
  bool get hasPoint => state.hasPoint;
  String get startDate => state.startDate;
  String get closeTime => state.closeTime;

  void updateFirstValue(SaleDate value) {
    final newState = state.copyWith(firstValue: value);
    _updateLoadingState(newState);
  }

  void updateSecondValue(List<Setting> value) {
    final newState = state.copyWith(secondValue: value);
    _updateLoadingState(newState);
  }

  void updateThirdValue(Cash value) {
    final newState = state.copyWith(
      thirdValue: value,
      hasPoint: true,
      mustCloseDay: false,
    );
    _updateLoadingState(newState);
  }

  void _updateLoadingState(ComparisonState newState) {
    // Only set isLoading to false when we have all the values we need
    final bool shouldStopLoading = newState.firstValue != null && 
                                  newState.secondValue != null && 
                                  newState.secondValue!.isNotEmpty;
    
    if (shouldStopLoading && !newState.isError) {
      final updatedState = _calculateDerivedValues(newState.copyWith(isLoading: false));
      emit(updatedState);
    } else {
      emit(newState);
    }
  }

  ComparisonState _calculateDerivedValues(ComparisonState currentState) {
    if (currentState.firstValue == null ||
        currentState.secondValue == null ||
        currentState.secondValue!.isEmpty) {
      return currentState;
    }

    final firstValue = currentState.firstValue!; 
    final secondValue = currentState.secondValue!;
    final thirdValue = currentState.thirdValue;

    bool hasPointValue = thirdValue != null;

    final closingHour = int.parse(DateFormat.H().format(secondValue[1].value5));
    var closingTime = firstValue.lineDate;
    final hourDifference = 24 - closingHour;

    if (hourDifference > 12) {
      closingTime = closingTime.add(Duration(days: 1, hours: closingHour));
    } else {
      closingTime = closingTime.add(Duration(hours: closingHour));
    }

    final mustCloseDayValue = DateTime.now().isAfter(closingTime);

    final closeTimeValue = closingTime.toIso8601String();
    final startDateValue = firstValue.lineDate.toIso8601String();

    return currentState.copyWith(
      hasPoint: hasPointValue,
      mustCloseDay: mustCloseDayValue,
      closeTime: closeTimeValue,
      startDate: startDateValue,
    );
  }

  bool _compareValues() {
    return state.firstValue != null && 
           state.secondValue != null && 
           state.secondValue!.isNotEmpty;
  }
}
