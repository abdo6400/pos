import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/entities/cash.dart';
import '../../../../../core/entities/sale_date.dart';
import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/setting.dart';
import '../../../domain/usecases/get_sales_by_user_usecase.dart';
import '../../../domain/usecases/get_sales_by_warehouse_usecase.dart';
import '../../../domain/usecases/get_settings_usecase.dart';

part 'checker_point_event.dart';
part 'checker_point_state.dart';

class CheckerPointBloc extends Bloc<CheckerPointEvent, CheckerPointState> {
  final GetSalesByWarehouseUsecase getSalesByWarehouse;
  final GetSalesByUserUsecase getSalesByUser;
  final GetSettingsUsecase getSettings;

  CheckerPointBloc(
    this.getSalesByWarehouse,
    this.getSalesByUser,
    this.getSettings,
  ) : super(CheckerPointInitial()) {
    on<CheckPointStatus>(_onCheckPointStatus);
  }

  Future<void> _onCheckPointStatus(
    CheckPointStatus event,
    Emitter<CheckerPointState> emit,
  ) async {
    emit(CheckerPointLoading());

    try {
      final user = (await storage.getUser());
      // Step 1: Get warehouse sales
      final warehouseSalesEither =
          await getSalesByWarehouse(user?.defaultBranch ?? "0");
      if (warehouseSalesEither.isLeft()) {
        emit(CheckerPointError(
          errorMessage: (warehouseSalesEither as Left).value.toString(),
        ));
        return;
      }
      final warehouseSales = (warehouseSalesEither as Right).value;
      emit(state.copyWith(warehouseSales: warehouseSales));
      // Step 2: Get settings
      final settingsEither = await getSettings(user?.defaultBranch ?? "0");
      if (settingsEither.isLeft()) {
        emit(CheckerPointError(
          errorMessage: (settingsEither as Left).value.toString(),
        ));
        return;
      }
      final settings = (settingsEither as Right).value;
      emit(state.copyWith(settings: settings));
      // Step 3: Get user sales
      final userSalesEither = await getSalesByUser(user?.userNo ?? 0);
      if (userSalesEither.isLeft()) {
        emit(CheckerPointError(
          errorMessage: (userSalesEither as Left).value.toString(),
        ));
        return;
      }
      final userSales = (userSalesEither as Right).value;
      // Calculate derived values
      final mustCloseDay = _calculateMustCloseDay(
        warehouseSales.lineDate,
        settings[1].value5, // Assuming this is the closing hour
      );
      emit(CheckerPointReady(
        warehouseSales: warehouseSales,
        settings: settings,
        userSales: userSales,
        mustCloseDay: mustCloseDay,
        hasPoint: userSales != null,
        startDate: warehouseSales.lineDate.toIso8601String(),
        closeTime: _calculateCloseTime(
          warehouseSales.lineDate,
          settings[1].value5,
        ).toIso8601String(),
      ));
    } catch (e) {
      emit(CheckerPointError(errorMessage: e.toString()));
    }
  }

  DateTime _calculateCloseTime(DateTime lineDate, DateTime closingHourStr) {
    final closingHour = int.parse(DateFormat.H().format(closingHourStr));
    final hourDifference = 24 - closingHour;

    if (hourDifference > 12) {
      return lineDate.add(Duration(days: 1, hours: closingHour));
    } else {
      return lineDate.add(Duration(hours: closingHour));
    }
  }

  bool _calculateMustCloseDay(DateTime lineDate, DateTime closingHourStr) {
    final closingTime = _calculateCloseTime(lineDate, closingHourStr);
    return DateTime.now().isAfter(closingTime);
  }
}
