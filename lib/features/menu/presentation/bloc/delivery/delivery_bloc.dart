import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/usecases/use_case.dart';
import '../../../domain/entities/delivery.dart';
import '../../../domain/entities/delivery_discount.dart';
import '../../../domain/usecases/get_deliveries_usecase.dart';
import '../../../domain/usecases/get_delivery_discounts_usecase.dart';

part 'delivery_event.dart';
part 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  final GetDeliveriesUsecase _getDeliveriesUsecase;
  final GetDeliveryDiscountsUsecase _deliveryDiscountsUsecase;
  DeliveryBloc(this._getDeliveriesUsecase, this._deliveryDiscountsUsecase)
      : super(DeliveryInitial()) {
    on<DeliveryEvent>((event, emit) async {
      emit(DeliveryLoading());
      final result = await _getDeliveriesUsecase(NoParams());
      final discountResult = await _deliveryDiscountsUsecase(NoParams());
      result.fold(
        (failure) {
          emit(DeliveryError(failure.message));
        },
        (deliveries) {
          discountResult.fold(
            (failure) {
              emit(DeliverySuccess(deliveries, []));
            },
            (discounts) {
              emit(DeliverySuccess(deliveries, discounts));
            },
          );
        },
      );
    });
  }
}
