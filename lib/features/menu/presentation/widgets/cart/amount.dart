import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../domain/entities/discount.dart';
import '../../bloc/cubit/discount_selection.dart';
import '../../bloc/discount/discount_bloc.dart';

class Amount extends StatelessWidget {
  final double subTotalAmount;
  final double taxAmount;

  const Amount(
      {super.key, required this.subTotalAmount, required this.taxAmount});

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
          value,
          style: style,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double discountAmount =
        context.watch<DiscountSelection>().state != null
            ? context.read<DiscountSelection>().state!.discountPercentage
            : 0.0;
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Theme.of(context).hintColor.withAlpha(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 3,
          children: [
            _customListTile(StringEnums.subTotalAmount.name,
                subTotalAmount.toString(), context),
            _customListTile(
                StringEnums.taxAmount.name, taxAmount.toString(), context),
            BlocBuilder<DiscountBloc, DiscountState>(
              builder: (context, state) {
                return Row(
                  children: [
                    state is DiscountSuccess
                        ? PopupMenuButton<Discount?>(
                            icon: SizedBox(
                              child: Icon(
                                Icons.discount_outlined,
                                color: Colors.blueAccent,
                                size: context.ResponsiveValu(30,
                                    mobile: 20, tablet: 35, desktop: 40),
                              ),
                            ),
                            offset: Offset(-50, -50),
                            initialValue: state.discounts.first,
                            onSelected: (Discount? discount) {
                              context
                                  .read<DiscountSelection>()
                                  .changeDiscount(discount);
                            },
                            itemBuilder: (BuildContext context) =>
                                [null, ...state.discounts]
                                    .map(
                                      (e) => PopupMenuItem<Discount?>(
                                          value: e,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(e != null
                                                  ? context.trValue(
                                                      e.discountTypeAr,
                                                      e.discountTypeEn)
                                                  : StringEnums.no_discount.name
                                                      .tr()),
                                              Text(e != null
                                                  ? e.discountPercentage
                                                      .toString()
                                                  : "0.0")
                                            ],
                                          )),
                                    )
                                    .toList())
                        : Icon(
                            Icons.discount_outlined,
                            color: Colors.blueAccent,
                            size: context.ResponsiveValu(30,
                                mobile: 20, tablet: 35, desktop: 40),
                          ),
                    Expanded(
                      child: _customListTile(StringEnums.discountAmount.name,
                          discountAmount.toString(), context),
                    ),
                  ],
                );
              },
            ),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            _customListTile(
                StringEnums.totalAmount.name,
                ((subTotalAmount + taxAmount) - discountAmount).toString(),
                context),
          ],
        ),
      ),
    );
  }
}
