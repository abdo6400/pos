import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../domain/entities/discount.dart';
import '../../bloc/cubit/discount_selection_cubit.dart';
import '../../bloc/discount/discount_bloc.dart';

class DelivaryPopup extends StatelessWidget {
  const DelivaryPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountBloc, DiscountState>(
      builder: (context, state) {
        return PopupMenuButton<Discount?>(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: Colors.green),
            ),
            icon: Card(
              elevation: 0.5,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.delivery_dining_outlined,
                  color: Colors.white,
                  size: context.AppResponsiveValue(15,
                      mobile: 15, tablet: 30, desktop: 40),
                ),
              ),
            ),
            padding: EdgeInsets.zero,
            offset: Offset(-50, -50),
            initialValue:
                state is DiscountSuccess ? state.discounts.first : null,
            enabled: state is DiscountSuccess,
            itemBuilder: (BuildContext context) => state is DiscountSuccess
                ? ([null, ...state.discounts]
                    .map(
                      (e) => PopupMenuItem<Discount?>(
                          value: e,
                          onTap: () {
                            context
                                .read<DiscountSelectionCubit>()
                                .changeDiscount(e);
                          },
                          labelTextStyle: WidgetStatePropertyAll(
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: context.AppResponsiveValue(12,
                                      mobile: 10, tablet: 16, desktop: 25),
                                  color: context
                                              .read<DiscountSelectionCubit>()
                                              .state
                                              ?.discountPercentage ==
                                          e?.discountPercentage
                                      ? Colors.blue
                                      : Colors.black)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e != null
                                  ? context.trValue(
                                      e.discountTypeAr, e.discountTypeEn)
                                  : StringEnums.no_discount.name.tr()),
                              Text(e != null
                                  ? e.discountPercentage.toString()
                                  : "0.0")
                            ],
                          )),
                    )
                    .toList())
                : []);
      },
    );
  }
}
