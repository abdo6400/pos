import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import 'delivary_popup.dart';
import 'discount_popup.dart';
import 'pending_orders_popup.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom:
                BorderSide(color: Theme.of(context).hintColor.withAlpha(20)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(StringEnums.current_order.name.tr(),
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: context.AppResponsiveValue(12,
                              mobile: 10, tablet: 20, desktop: 25),
                        )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DelivaryPopup(),
                PendingOrdersPopup(),
                DiscountPopup(),
              ],
            )
          ],
        ));
  }
}
