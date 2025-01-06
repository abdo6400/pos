import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/cart/amount.dart';
import '../widgets/cart/cart_list.dart';
import '../widgets/cart/custom_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        elevation: 0.2,
        shape: BorderDirectional(
          start: BorderSide(color: Theme.of(context).hintColor.withAlpha(50)),
        ),
        child: Column(
          children: [
            Expanded(child: CustomAppBar()),
            Expanded(
              flex: context.ResponsiveValu(4, mobile: 5, tablet: 6, desktop: 6)
                  .toInt(),
              child: Column(
                children: [
                  Expanded(child: CartList()),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      spacing: 10,
                      children: [
                        Amount(
                          subTotalAmount: 0.0,
                          taxAmount: 0.0,
                          discountAmount: 0.0,
                          currency: 'jod',
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Flexible(
                              child: CustomButton(
                                buttonLabel: StringEnums.checkoutCash.name.tr(),
                                iconData: Icons.money_outlined,
                                onSubmit: () {},
                                backgroundColor: Colors.green,
                              ),
                            ),
                            Flexible(
                              child: CustomButton(
                                buttonLabel: StringEnums.checkoutVisa.name.tr(),
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
                              onSubmit: () {},
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
        ));
  }
}
