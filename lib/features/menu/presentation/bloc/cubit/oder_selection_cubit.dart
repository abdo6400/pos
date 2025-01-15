import 'package:bloc/bloc.dart';
import '../order/order_item.dart';

class OderSelectionCubit extends Cubit<OrderItem?> {
  OderSelectionCubit() : super(null);

  void selectOrder(OrderItem? order) => emit(order);
}
