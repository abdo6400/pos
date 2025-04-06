import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/entities/sale_date.dart';
import '../../../domain/usecases/get_sales_by_warehouse_usecase.dart';

part 'get_sales_by_warehouse_event.dart';
part 'get_sales_by_warehouse_state.dart';

class GetSalesByWarehouseBloc
    extends Bloc<GetSalesByWarehouseEvent, GetSalesByWarehouseState> {
  final GetSalesByWarehouseUsecase _getSalesByWarehouseUsecase;

  GetSalesByWarehouseBloc(this._getSalesByWarehouseUsecase)
      : super(GetSalesByWarehouseInitial()) {
    on<GetSalesByWarehouseRequested>((event, emit) async {
      emit(GetSalesByWarehouseLoading());
      final result = await _getSalesByWarehouseUsecase(event.branchId);
      result.fold(
        (failure) => emit(GetSalesByWarehouseFailure(message: failure.message)),
        (sales) => emit(GetSalesByWarehouseSuccess(sales: sales)),
      );
    });
  }
}
