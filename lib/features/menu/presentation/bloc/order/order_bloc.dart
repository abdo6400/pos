import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/usecases/use_case.dart';
import '../../../domain/usecases/clear_orders_usecase.dart';
import '../../../domain/usecases/delete_order_usecase.dart';
import '../../../domain/usecases/get_orders_usecase.dart';
import '../../../domain/usecases/insert_order_usecase.dart';
import 'order_item.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final InsertOrderUseCase _insertOrderUseCase;
  final GetOrdersUseCase _getOrdersUseCase;
  final DeleteOrderUseCase _deleteOrderUsecase;
  final ClearOrdersUseCase _clearOrdersUsecase;
  OrderBloc(this._insertOrderUseCase, this._getOrdersUseCase,
      this._deleteOrderUsecase, this._clearOrdersUsecase)
      : super(OrderState()) {
    on<GetOrdersEvent>(_onGetOrdersEvent);
    on<AddOrderEvent>(_onAddOrderEvent);
    on<ClearOrdersEvent>(_onClearOrdersEvent);
    on<DeleteOrderEvent>(_onDeleteOrderEvent);
  }

  void _onDeleteOrderEvent(
      DeleteOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
        orders:
            state.orders.where((x) => x.orderId != event.orderId).toList()));
    await _deleteOrderUsecase(event.orderId);
  }

  void _onGetOrdersEvent(GetOrdersEvent event, Emitter<OrderState> emit) async {
    final result = await _getOrdersUseCase(NoParams());
    result.fold(
        (failure) => emit(state.copyWith(errorMessage: failure.message)),
        (orders) => emit(state.copyWith(
            orders: List<OrderItem>.from(
                orders.map((x) => OrderItem.convert(x))))));
  }

  void _onClearOrdersEvent(
      ClearOrdersEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(orders: []));
    await _clearOrdersUsecase(NoParams());
  }

  void _onAddOrderEvent(AddOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(orders: [event.orderItem, ...state.orders]));
    await _insertOrderUseCase(event.orderItem.toJson());
  }
}
