import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/custom_button.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cubit/discount_selection_cubit.dart';
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
      ],
      child: Card(
          margin: EdgeInsets.zero,
          elevation: 0.2,
          shape: BorderDirectional(
            start: BorderSide(color: Theme.of(context).hintColor.withAlpha(50)),
          ),
          child: Column(
            children: [
              Expanded(child: CustomAppBar()),
              Expanded(
                flex: context.AppResponsiveValue(4,
                        mobile: 5, tablet: 7, desktop: 6)
                    .toInt(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(StringEnums.current_order.name.tr(),
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontSize: context.AppResponsiveValue(12,
                                    mobile: 10, tablet: 20, desktop: 25),
                              )),
                    ),
                    Expanded(child: CartList()),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        spacing: 5,
                        children: [
                          Amount(),
                          Row(
                            spacing: 10,
                            children: [
                              Flexible(
                                child: CustomButton(
                                  buttonLabel:
                                      StringEnums.checkoutCash.name.tr(),
                                  iconData: Icons.money_outlined,
                                  onSubmit: () {},
                                  backgroundColor: Colors.green,
                                ),
                              ),
                              Flexible(
                                child: CustomButton(
                                  buttonLabel:
                                      StringEnums.checkoutVisa.name.tr(),
                                  iconData: Icons.payment_outlined,
                                  onSubmit: () {},
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          Row(spacing: 10, children: [
                            Flexible(
                              child: CustomButton(
                                buttonLabel: StringEnums.save.name.tr(),
                                iconData: Icons.cached_outlined,
                                onSubmit: () {},
                                backgroundColor: Colors.purple,
                              ),
                            ),
                            Flexible(
                              child: CustomButton(
                                buttonLabel: StringEnums.clear.name.tr(),
                                iconData: Icons.clear,
                                onSubmit: () => context
                                    .read<CartBloc>()
                                    .add(ClearCartEvent()),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ]),
                          CustomButton(
                            buttonLabel: StringEnums.pendingOrders.name.tr(),
                            iconData: Icons.pending_actions_outlined,
                            onSubmit: () {},
                            backgroundColor: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
