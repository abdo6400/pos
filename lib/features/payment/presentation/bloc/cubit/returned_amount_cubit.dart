import 'package:bloc/bloc.dart';

class ReturnedAmountCubit extends Cubit<double> {
  ReturnedAmountCubit() : super(0.0);

  void setReturnedAmount(double amount) => emit(amount);
}
