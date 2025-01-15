import 'package:bloc/bloc.dart';

import '../../../domain/entities/delivery.dart';

class DeliverySelectionCubit extends Cubit<Delivery?> {
  DeliverySelectionCubit() : super(null);

  void changeDelivery(Delivery? deliveries) => emit(deliveries);
}
