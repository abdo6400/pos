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
        return state is DiscountSuccess
            ? PopupMenuButton<Discount?>(
                icon: SizedBox(
                  child: Icon(
                    Icons.discount_outlined,
                    color: Colors.blueAccent,
                    size: context.AppResponsiveValue(30,
                        mobile: 20, tablet: 35, desktop: 40),
                  ),
                ),
                offset: Offset(-50, -50),
                initialValue: state.discounts.first,
                itemBuilder: (BuildContext context) =>
                    [null, ...state.discounts]
                        .map(
                          (e) => PopupMenuItem<Discount?>(
                              value: e,
                              onTap: () {
                                context
                                    .read<DiscountSelectionCubit>()
                                    .changeDiscount(e);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
            : Icon(
                Icons.discount_outlined,
                color: Colors.blueAccent,
                size: context.AppResponsiveValue(30,
                    mobile: 20, tablet: 35, desktop: 40),
              );
      },
    );
  }
}
