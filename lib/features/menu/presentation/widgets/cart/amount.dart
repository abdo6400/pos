import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/features/menu/presentation/bloc/cubit/delivery_selection_cubit.dart';
import 'package:retail/features/payment/presentation/bloc/pay/pay_bloc.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../payment/presentation/bloc/payment_types/payment_types_bloc.dart';
import '../../../../settings/presentation/bloc/checker_point/checker_point_bloc.dart';
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

  void payReceipt(BuildContext context,
      {required CartState cart,
      required bool isPrint,
      required Map<int, double> payments,
      required double taxPercentage,
      required bool priceIncludesTax,
      required bool taxIncludesDiscount,
      required Discount? discount,
      required double exChangeAmount,
      required DeliveryWithDiscount? delivery,
      bool addQrCode = false}) async {
    final user = await storage.getUser();
    if (user != null && cart.cart.isNotEmpty) {

      context.read<PayBloc>().add(Pay(
          isPrint: isPrint,
          exchangeAmount: exChangeAmount,
          invoiceParams: cart.createInvoice(
            trn: user.taxNo,
            remind: user.numbersOfDigits,
            payments: payments,
            branchId: int.parse(user.defaultBranch),
            addQrCode: addQrCode,
            userNo: user.userNo,
            isPrinted: isPrint,
            taxPercentage: taxPercentage,
            priceIncludesTax: priceIncludesTax,
            taxIncludesDiscount: taxIncludesDiscount,
            discount: discount?.discountPercentage ?? 0.0,
            deliveryCategory: delivery?.deliveryPriceCategory ?? 0,
            deliveryDiscount: delivery?.deliveryPriceDiscount ?? 0.0,
          )));
    } else {
      context.showMessageToast(msg: StringEnums.empty_cart.name.tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, setting) {
      double taxPercentage = 16.0;
      bool priceIncludesTax = true;
      bool taxIncludesDiscount = true;
      bool addQrCode = false;
      if (setting is SettingsSuccess) {
        taxPercentage = setting.getSetting(9).value2;
        priceIncludesTax = setting.getSetting(3).value4;
        taxIncludesDiscount = setting.getSetting(5).value4;
        addQrCode = setting.getSetting(2).value4;
      }
      return BlocBuilder<DeliverySelectionCubit, DeliveryWithDiscount?>(
        builder: (context, delivery) {
          return BlocBuilder<DiscountSelectionCubit, Discount?>(
            builder: (context, discount) => Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              color: Theme.of(context).hintColor.withAlpha(15),
              child: BlocConsumer<CartBloc, CartState>(
                listener: (context, state) {},
                builder: (context, cart) {
                  final receipt = cart.calculateTotalPrice(
                    taxPercentage: taxPercentage,
                    priceIncludesTax: priceIncludesTax,
                    taxIncludesDiscount: taxIncludesDiscount,
                    discount: discount?.discountPercentage ?? 0.0,
                    deliveryCategory: delivery?.deliveryPriceCategory ?? 0,
                    deliveryDiscount: delivery?.deliveryPriceDiscount ?? 0.0,
                  );

                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      spacing: context.AppResponsiveValue(1,
                          mobile: 1, tablet: 10, desktop: 15),
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _customListTile(StringEnums.subTotalAmount.name,
                                  receipt.price.toStringAsFixed(2), context),
                              _customListTile(StringEnums.taxAmount.name,
                                  receipt.tax.toStringAsFixed(2), context),
                              _customListTile(StringEnums.discountAmount.name,
                                  receipt.discount.toStringAsFixed(2), context),
                              Divider(
                                color: Theme.of(context).primaryColor,
                              ),
                              _customListTile(
                                  StringEnums.totalAmount.name,
                                  ((receipt.grandTotal)).toStringAsFixed(2),
                                  context),
                            ],
                          ),
                        ),
                        BlocBuilder<PaymentTypesBloc, PaymentTypesState>(
                          builder: (context, paymentTypes) => Column(
                            spacing: context.AppResponsiveValue(5,
                                mobile: 5, tablet: 10, desktop: 10),
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CustomButton(
                                buttonLabel: StringEnums.checkoutCash.name.tr(),
                                iconData: Icons.money_outlined,
                                backgroundColor: Colors.green,
                                onSubmit: () async {
                                  if (paymentTypes is PaymentTypesSuccess) {

                                    context.read<CheckerPointBloc>().add(
                                        CheckPointStatus(
                                            OnSuccess:() =>  payReceipt(context,
                                                cart: cart,
                                                exChangeAmount: 0,
                                                addQrCode: addQrCode,
                                                isPrint: true,
                                                payments: {
                                                  paymentTypes.paymentTypes.first.ptype:
                                                  receipt.grandTotal
                                                },
                                                taxPercentage: taxPercentage,
                                                priceIncludesTax: priceIncludesTax,
                                                taxIncludesDiscount:
                                                taxIncludesDiscount,
                                                discount: discount,
                                                delivery: delivery)
                                        )
                                    );

                                  } else {
                                    context.showMessageToast(
                                        msg: StringEnums.empty_cart.name.tr());
                                  }
                                },
                              ),
                              CustomButton(
                                buttonLabel: StringEnums.pay_by.name.tr(),
                                iconData: Icons.payment_outlined,
                                onSubmit: paymentTypes is PaymentTypesSuccess &&
                                        cart.cart.isNotEmpty
                                    ? () {
                                  context.read<CheckerPointBloc>().add(
                                      CheckPointStatus(
                                          OnSuccess:() =>  context.push(AppRoutes.payment, extra: [
                                            paymentTypes.paymentTypes,
                                                (payments, bool isPrint,
                                                double exChangeAmount) {
                                              payReceipt(context,
                                                  cart: cart,
                                                  isPrint: isPrint,
                                                  exChangeAmount: exChangeAmount,
                                                  addQrCode: addQrCode,
                                                  payments: payments,
                                                  taxPercentage: taxPercentage,
                                                  priceIncludesTax:
                                                  priceIncludesTax,
                                                  taxIncludesDiscount:
                                                  taxIncludesDiscount,
                                                  discount: discount,
                                                  delivery: delivery);
                                            },
                                            receipt.grandTotal,
                                          ])
                                      )
                                  );

                                      }
                                    : () {
                                        context.showMessageToast(
                                            msg: StringEnums.empty_cart.name
                                                .tr());
                                      },
                                backgroundColor: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    });
  }
}
