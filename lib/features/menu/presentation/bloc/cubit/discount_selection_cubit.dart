import 'package:bloc/bloc.dart';

import '../../../domain/entities/discount.dart';

class DiscountSelectionCubit extends Cubit<Discount?> {
  DiscountSelectionCubit() : super(null);

  void changeDiscount(Discount? discount) => emit(discount);
}
