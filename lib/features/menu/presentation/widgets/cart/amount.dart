import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:retail/core/utils/extensions/responsive.dart';
import '../../../../../core/utils/enums/string_enums.dart';

class Amount extends StatelessWidget {
  final double subTotalAmount;
  final double taxAmount;
  final double discountAmount;
  final String currency;
  const Amount(
      {super.key,
      required this.subTotalAmount,
      required this.taxAmount,
      required this.currency,
      required this.discountAmount});
  Widget _customListTile(String title, String value, BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize:
            context.ResponsiveValu(12, mobile: 10, tablet: 20, desktop: 25));
    return Row(
      children: [
        Expanded(
          child: Text(
            title.tr(),
            style: style,
          ),
        ),
        Text(
          value + ' ' + currency,
          style: style,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Theme.of(context).hintColor.withAlpha(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 3,
          children: [
            _customListTile(StringEnums.subTotalAmount.name,
                subTotalAmount.toString(), context),
            _customListTile(
                StringEnums.taxAmount.name, taxAmount.toString(), context),
            _customListTile(StringEnums.discountAmount.name,
                discountAmount.toString(), context),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            _customListTile(
                StringEnums.totalAmount.name,
                (subTotalAmount + taxAmount - discountAmount).toString(),
                context),
          ],
        ),
      ),
    );
  }
}
