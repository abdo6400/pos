import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/usecases/use_case.dart';
import '../../../domain/entities/delivery.dart';
import '../../../domain/usecases/get_deliveries_usecase.dart';

part 'delivery_event.dart';
part 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  final GetDeliveriesUsecase _getDeliveriesUsecase;
  DeliveryBloc(this._getDeliveriesUsecase) : super(DeliveryInitial()) {
    on<DeliveryEvent>((event, emit) async {
      emit(DeliveryLoading());
      final result = await _getDeliveriesUsecase(NoParams());
      result.fold((l) => emit(DeliveryError(l.message)),
          (r) => emit(DeliverySuccess(r)));
    });
  }
}
