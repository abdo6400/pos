import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../domain/entities/discount.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cubit/discount_selection_cubit.dart';

class Amount extends StatelessWidget {
  const Amount({super.key});

  Widget _customListTile(String title, String value, BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize:
            context.AppResponsiveValue(8, mobile: 8, tablet: 16, desktop: 22));
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
    return BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, setting) {
      double taxPercentage = 16.0;
      bool priceIncludesTax = true;
      bool taxIncludesDiscount = true;
      if (setting is SettingsSuccess) {
        taxPercentage = setting.getSetting(9).value2;
        priceIncludesTax = setting.getSetting(3).value4;
        taxIncludesDiscount = setting.getSetting(5).value4;
      }
      return BlocBuilder<DiscountSelectionCubit, Discount?>(
        builder: (context, discount) => Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          color: Theme.of(context).hintColor.withAlpha(15),
          child: BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {},
            //  listenWhen: (previous, current) => previous != current,
            builder: (context, stats) {
              final data = stats.calculateTotalPrice(
                taxPercentage: taxPercentage,
                priceIncludesTax: priceIncludesTax,
                taxIncludesDiscount: taxIncludesDiscount,
                discount: discount?.discountPercentage ?? 0.0,
              );
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _customListTile(StringEnums.subTotalAmount.name,
                        data.price.toStringAsFixed(3), context),
                    _customListTile(StringEnums.taxAmount.name,
                        data.tax.toStringAsFixed(3), context),
                    _customListTile(StringEnums.discountAmount.name,
                        data.discount.toStringAsFixed(3), context),
                    Divider(
                      color: Theme.of(context).primaryColor,
                    ),
                    _customListTile(StringEnums.totalAmount.name,
                        ((data.grandTotal)).toStringAsFixed(3), context),
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
