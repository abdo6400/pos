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
        padding: EdgeInsets.symmetric(
            vertical: context.AppResponsiveValue(5,
                mobile: 5, tablet: 10, desktop: 5),
            horizontal: 5),
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom:
                BorderSide(color: Theme.of(context).hintColor.withAlpha(20)),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(StringEnums.current_order.name.tr(),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: context.AppResponsiveValue(12,
                            mobile: 10, tablet: 21, desktop: 25),
                      )),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: context.AppResponsiveValue(2,
                  mobile: 2, tablet: 10, desktop: 15),
              children: [
                DelivaryPopup(),
                PendingOrdersPopup(),
                DiscountPopup(),
              ],
            ),
          ],
        ));
  }
}
