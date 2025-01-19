import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/features/menu/presentation/bloc/cubit/delivery_selection_cubit.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../payment/presentation/bloc/payment_types/payment_types_bloc.dart';
import '../bloc/cubit/discount_selection_cubit.dart';
import '../bloc/cubit/oder_selection_cubit.dart';
import '../widgets/cart/amount.dart';
import '../widgets/cart/cart_list.dart';
import '../widgets/cart/custom_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DiscountSelectionCubit()),
        BlocProvider(create: (_) => OderSelectionCubit()),
        BlocProvider(create: (_) => DeliverySelectionCubit()),
      ],
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0.2,
        shape: BorderDirectional(
          start: BorderSide(color: Theme.of(context).hintColor.withAlpha(50)),
        ),
        child: Column(
          children: [
            CustomAppBar(),
            Expanded(child: CartList()),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                spacing: context.AppResponsiveValue(1,
                    mobile: 1, tablet: 10, desktop: 15),
                children: [
                  Amount(),
                  BlocBuilder<PaymentTypesBloc, PaymentTypesState>(
                    builder: (context, state) => Column(
                      spacing: context.AppResponsiveValue(5,
                          mobile: 5, tablet: 10, desktop: 10),
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomButton(
                          buttonLabel: StringEnums.checkoutCash.name.tr(),
                          iconData: Icons.money_outlined,
                          onSubmit: () {},
                          backgroundColor: Colors.green,
                        ),
                        CustomButton(
                          buttonLabel: StringEnums.pay_by.name.tr(),
                          iconData: Icons.payment_outlined,
                          onSubmit: state is PaymentTypesSuccess
                              ? () => context.push(AppRoutes.payment,
                                  extra: state.paymentTypes)
                              : () {},
                          backgroundColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
