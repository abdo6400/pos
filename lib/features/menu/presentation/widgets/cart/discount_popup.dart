import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../domain/entities/discount.dart';
import '../../bloc/cubit/discount_selection_cubit.dart';
import '../../bloc/discount/discount_bloc.dart';

class DiscountPopup extends StatelessWidget {
  const DiscountPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountBloc, DiscountState>(
      builder: (context, state) {
        return PopupMenuButton<Discount?>(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: Colors.blue),
            ),
            enabled: state is DiscountSuccess,
            icon: Card(
              elevation: 0.5,
              color: Colors.blue,
              margin: EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.discount_outlined,
                  color: Colors.white,
                  size: context.AppResponsiveValue(15,
                      mobile: 15, tablet: 25, desktop: 30),
                ),
              ),
            ),
            padding: EdgeInsets.zero,
            offset: Offset(-50, -50),
            initialValue: state is DiscountSuccess && state.discounts.isNotEmpty
                ? state.discounts.first
                : null,
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
                                  )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                  value: context
                                          .read<DiscountSelectionCubit>()
                                          .state
                                          ?.discountPercentage ==
                                      e?.discountPercentage,
                                  onChanged: null),
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
