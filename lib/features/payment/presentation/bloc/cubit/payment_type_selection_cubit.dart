import 'package:bloc/bloc.dart';

class PaymentTypeSelectionCubit extends Cubit<String?> {
  PaymentTypeSelectionCubit() : super(null);

  void selectPaymentType(String? paymentType) => emit(paymentType);
}
