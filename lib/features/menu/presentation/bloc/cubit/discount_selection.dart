import 'package:bloc/bloc.dart';

import '../../../domain/entities/discount.dart';

class DiscountSelection extends Cubit<Discount?> {
  DiscountSelection() : super(null);

  void changeDiscount(Discount? discount) => emit(discount);
}
