import 'package:bloc/bloc.dart';

import '../../../domain/entities/delivery.dart';
import '../../../domain/entities/delivery_discount.dart';

class DeliverySelectionCubit extends Cubit<DeliveryWithDiscount?> {
  DeliverySelectionCubit() : super(null);

  void changeDelivery(DeliveryWithDiscount? deliveries) => emit(deliveries);
}

class DeliveryWithDiscount {
  final Delivery? delivery;
  final DeliveryDiscount? discount;
  DeliveryWithDiscount({required this.delivery, required this.discount});
}
