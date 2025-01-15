import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/features/menu/presentation/bloc/order/order_item.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cubit/oder_selection_cubit.dart';
import '../../bloc/order/order_bloc.dart';

class PendingOrdersPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return PopupMenuButton<OrderItem>(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: Colors.yellow),
            ),
            icon: Card(
              elevation: 0.5,
              color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.pending_actions_outlined,
                  color: Colors.white,
                  size: context.AppResponsiveValue(15,
                      mobile: 15, tablet: 30, desktop: 40),
                ),
              ),
            ),
            offset: Offset(0, 0),
            padding: EdgeInsets.zero,
            initialValue: state.orders.isNotEmpty ? state.orders.first : null,
            enabled: state.orders.isNotEmpty,
            itemBuilder: (BuildContext context) => state.orders
                .map(
                  (e) => PopupMenuItem<OrderItem>(
                      value: e,
                      onTap: () {
                        context.read<OderSelectionCubit>().selectOrder(e);
                        context
                            .read<CartBloc>()
                            .add(AddCartsEvent(cartItems: e.cartItems));
                        context.read<OrderBloc>().add(DeleteOrderEvent(
                              e.orderId,
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " ${DateTime.parse(e.orderDate).day} / ${DateTime.parse(e.orderDate).month} / ${DateTime.parse(e.orderDate).year} - ${DateTime.parse(e.orderDate).minute} : ${DateTime.parse(e.orderDate).hour} ",
                          ),
                        ],
                      )),
                )
                .toList());
      },
    );
  }
}
