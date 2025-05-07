part of 'checker_point_bloc.dart';

sealed class CheckerPointState extends Equatable {
  final SaleDate? warehouseSales;
  final List<Setting>? settings;
  final Cash? userSales;
  final bool mustCloseDay;
  final bool hasPoint;
  final String startDate;
  final String closeTime;

  const CheckerPointState({
    this.warehouseSales,
    this.settings,
    this.userSales,
    this.mustCloseDay = false,
    this.hasPoint = false,
    this.startDate = '',
    this.closeTime = '',
  });

  CheckerPointState copyWith({
    SaleDate? warehouseSales,
    List<Setting>? settings,
    Cash? userSales,
    bool? mustCloseDay,
    bool? hasPoint,
    String? startDate,
    String? closeTime,
  });

  @override
  List<Object?> get props => [
        warehouseSales,
        settings,
        userSales,
        mustCloseDay,
        hasPoint,
        startDate,
        closeTime,
      ];
}

final class CheckerPointInitial extends CheckerPointState {
  const CheckerPointInitial() : super();

  @override
  CheckerPointInitial copyWith({
    SaleDate? warehouseSales,
    List<Setting>? settings,
    Cash? userSales,
    bool? mustCloseDay,
    bool? hasPoint,
    String? startDate,
    String? closeTime,
  }) {
    return const CheckerPointInitial();
  }
}

final class CheckerPointLoading extends CheckerPointState {
  const CheckerPointLoading() : super();

  @override
  CheckerPointLoading copyWith({
    SaleDate? warehouseSales,
    List<Setting>? settings,
    Cash? userSales,
    bool? mustCloseDay,
    bool? hasPoint,
    String? startDate,
    String? closeTime,
  }) {
    return const CheckerPointLoading();
  }
}

final class CheckerPointReady extends CheckerPointState {
  const CheckerPointReady({
    required SaleDate warehouseSales,
    required List<Setting> settings,
    required Cash? userSales,
    required bool mustCloseDay,
    required bool hasPoint,
    required String startDate,
    required String closeTime,
  }) : super(
          warehouseSales: warehouseSales,
          settings: settings,
          userSales: userSales,
          mustCloseDay: mustCloseDay,
          hasPoint: hasPoint,
          startDate: startDate,
          closeTime: closeTime,
        );

  @override
  CheckerPointReady copyWith({
    SaleDate? warehouseSales,
    List<Setting>? settings,
    Cash? userSales,
    bool? mustCloseDay,
    bool? hasPoint,
    String? startDate,
    String? closeTime,
  }) {
    return CheckerPointReady(
      warehouseSales: warehouseSales ?? this.warehouseSales!,
      settings: settings ?? this.settings!,
      userSales: userSales ?? this.userSales!,
      mustCloseDay: mustCloseDay ?? this.mustCloseDay,
      hasPoint: hasPoint ?? this.hasPoint,
      startDate: startDate ?? this.startDate,
      closeTime: closeTime ?? this.closeTime,
    );
  }
}

final class CheckerPointError extends CheckerPointState {
  final String errorMessage;

  const CheckerPointError({
    required this.errorMessage,
  }) : super();

  @override
  List<Object> get props => [errorMessage];

  @override
  CheckerPointError copyWith({
    SaleDate? warehouseSales,
    List<Setting>? settings,
    Cash? userSales,
    bool? mustCloseDay,
    bool? hasPoint,
    String? startDate,
    String? closeTime,
    String? errorMessage,
  }) {
    return CheckerPointError(
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
