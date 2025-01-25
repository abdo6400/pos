import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/features/menu/domain/entities/delivery.dart';
import 'package:retail/features/menu/presentation/bloc/cubit/delivery_selection_cubit.dart';
import 'package:retail/features/menu/presentation/bloc/delivery/delivery_bloc.dart';
import '../../../../../core/utils/enums/string_enums.dart';

class DelivaryPopup extends StatelessWidget {
  const DelivaryPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryBloc, DeliveryState>(
      builder: (context, state) {
        return PopupMenuButton<Delivery?>(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: Colors.green),
            ),
            icon: Card(
              elevation: 0.5,
              color: Colors.green,
              margin: EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.delivery_dining_outlined,
                  color: Colors.white,
                  size: context.AppResponsiveValue(15,
                      mobile: 15, tablet: 25, desktop: 30),
                ),
              ),
            ),
            padding: EdgeInsets.zero,
            offset: Offset(-50, -50),
            initialValue:
                state is DeliverySuccess && state.deliveries.isNotEmpty
                    ? state.deliveries.first
                    : null,
            enabled: state is DeliverySuccess,
            itemBuilder: (BuildContext context) => state is DeliverySuccess
                ? ([null, ...state.deliveries]
                    .map(
                      (e) => PopupMenuItem<Delivery?>(
                          value: e,
                          onTap: () {
                            context
                                .read<DeliverySelectionCubit>()
                                .changeDelivery(DeliveryWithDiscount(
                                    e,
                                    state.deliveryDiscounts.firstWhereOrNull(
                                        (e) => e.companyId == e.companyId)));
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
                                      .read<DeliverySelectionCubit>()
                                      .isDeliverySelected(e?.companyId),
                                  onChanged: null),
                              Text(e != null
                                  ? e.companyName
                                  : StringEnums.no_delivery.name.tr()),
                            ],
                          )),
                    )
                    .toList())
                : []);
      },
    );
  }
}
