import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/features/menu/presentation/bloc/cubit/delivery_selection_cubit.dart';
import '../bloc/cubit/discount_selection_cubit.dart';
import '../bloc/cubit/oder_selection_cubit.dart';
import '../widgets/cart/amount.dart';
import '../widgets/cart/cart_list.dart';
import '../widgets/cart/custom_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DiscountSelectionCubit()),
        BlocProvider(create: (_) => OderSelectionCubit()),
        BlocProvider(create: (_) => DeliverySelectionCubit()),
      ],
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0.2,
        shape: BorderDirectional(
          start: BorderSide(color: Theme.of(context).hintColor.withAlpha(50)),
        ),
        child: Column(
          children: [
            CustomAppBar(),
            Expanded(child: CartList()),
            Amount(),
          ],
        ),
      ),
    );
  }
}
