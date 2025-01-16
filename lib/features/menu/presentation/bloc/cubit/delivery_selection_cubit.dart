import 'package:bloc/bloc.dart';

import '../../../domain/entities/delivery.dart';
import '../../../domain/entities/delivery_discount.dart';

class DeliverySelectionCubit extends Cubit<DeliveryWithDiscount?> {
  DeliverySelectionCubit() : super(null);

  void changeDelivery(DeliveryWithDiscount? deliveries) => emit(deliveries);

  bool isDeliverySelected(int? id) => state?._delivery?.companyId == id;
}

class DeliveryWithDiscount {
  final Delivery? _delivery;
  final DeliveryDiscount? _discount;
  int get deliveryPriceCategory => _delivery?.priceCategory ?? 1;
  double get deliveryPriceDiscount => (_delivery != null && _discount != null)
      ? ((_isTimeBetween(
                  _discount.fromDate, _discount.toDate, DateTime.now()) &&
              _discount.isActive)
          ? _discount.discountValue
          : 0.0)
      : 0.0;

  double getPrice(double price, double price2, double price3, double price4) {
    double priceFinal = 0;
    switch (deliveryPriceCategory) {
      case 1:
        priceFinal = price;
        break;
      case 2:
        priceFinal = price2;
        break;
      case 3:
        priceFinal = price3;
        break;
      case 4:
        priceFinal = price4;
        break;
      default:
        priceFinal = price;
        break;
    }
    return priceFinal - ((deliveryPriceDiscount / 100) * priceFinal);
  }

  bool _isTimeBetween(
      DateTime startTime, DateTime endTime, DateTime timeToCheck) {
    // Handle cases where the endTime is on the next day (e.g., 23:00 to 02:00)
    if (endTime.isBefore(startTime)) {
      return timeToCheck.isAfter(startTime) || timeToCheck.isBefore(endTime);
    }
    // Normal case where startTime and endTime are on the same day
    return timeToCheck.isAfter(startTime) && timeToCheck.isBefore(endTime);
  }

  DeliveryWithDiscount(this._delivery, this._discount);
}
