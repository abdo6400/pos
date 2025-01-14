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
            Expanded(
                flex: context.AppResponsiveValue(2,
                        mobile: 2, tablet: 1, desktop: 1)
                    .toInt(),
                child: CustomAppBar()),
            Expanded(flex: 10, child: CartList()),
            Expanded(
              flex: context.AppResponsiveValue(8,
                      mobile: 8, tablet: 5, desktop: 4)
                  .toInt(),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  spacing: context.AppResponsiveValue(1,
                      mobile: 1, tablet: 10, desktop: 15),
                  children: [
                    Expanded(child: Amount()),
                    Column(
                        spacing: context.AppResponsiveValue(0,
                            mobile: 0, tablet: 5, desktop: 5),
                        mainAxisSize: MainAxisSize.max,
                        children: [
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
                        ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
