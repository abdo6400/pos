import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../domain/entities/discount.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cubit/discount_selection_cubit.dart';
import 'discount_popup.dart';

class Amount extends StatelessWidget {
  const Amount({super.key});

  Widget _customListTile(String title, String value, BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: context.AppResponsiveValue(12,
            mobile: 10, tablet: 20, desktop: 25));
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
      return BlocListener<DiscountSelectionCubit, Discount?>(
        listener: (context, state) {
          context.read<CartBloc>().add(CalculateTotalPriceEvent(
                taxPercentage: taxPercentage,
                priceIncludesTax: priceIncludesTax,
                taxIncludesDiscount: taxIncludesDiscount,
                discount: state?.discountPercentage ?? 0.0,
              ));
        },
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          color: Theme.of(context).hintColor.withAlpha(15),
          child: BlocConsumer<CartBloc, CartState>(
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) {
              context.read<CartBloc>().add(CalculateTotalPriceEvent(
                    taxPercentage: taxPercentage,
                    priceIncludesTax: priceIncludesTax,
                    taxIncludesDiscount: taxIncludesDiscount,
                    discount: context
                            .read<DiscountSelectionCubit>()
                            .state
                            ?.discountPercentage ??
                        0.0,
                  ));
            },
            builder: (context, stats) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 3,
                  children: [
                    _customListTile(StringEnums.subTotalAmount.name,
                        stats.totalPrice.toStringAsFixed(3), context),
                    _customListTile(StringEnums.taxAmount.name,
                        stats.totalTax.toStringAsFixed(3), context),
                    Row(
                      children: [
                        DiscountPopup(),
                        Expanded(
                          child: _customListTile(
                              StringEnums.discountAmount.name,
                              stats.discount.toStringAsFixed(3),
                              context),
                        ),
                      ],
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                    ),
                    _customListTile(StringEnums.totalAmount.name,
                        ((stats.grandTotal)).toStringAsFixed(3), context),
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
