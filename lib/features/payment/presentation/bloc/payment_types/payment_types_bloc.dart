import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecases/use_case.dart';
import '../../../domain/entities/payment_type.dart';
import '../../../domain/usecases/get_payment_types_usecase.dart';
part 'payment_types_event.dart';
part 'payment_types_state.dart';

class PaymentTypesBloc extends Bloc<PaymentTypesEvent, PaymentTypesState> {
  final GetPaymentTypesUsecase _getPaymentTypesUsecase;
  PaymentTypesBloc(this._getPaymentTypesUsecase)
      : super(PaymentTypesInitial()) {
    on<GetPaymentTypesEvent>((event, emit) async {
      emit(PaymentTypesLoading());
      final result = await _getPaymentTypesUsecase(NoParams());
      result.fold(
          (failure) => emit(PaymentTypesError(message: failure.message)),
          (paymentTypes) =>
              emit(PaymentTypesSuccess(paymentTypes: paymentTypes)));
    });
  }
}
