import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../core/bloc/cubit/printing_cubit.dart';
import '../../../../core/entities/settings.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enums/state_enums.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/invoice_card.dart';
import '../../../menu/presentation/bloc/cart/cart_bloc.dart';
import '../../../menu/presentation/screens/cart_screen.dart';
import '../../../menu/presentation/screens/menu_screen.dart';
import '../../../payment/presentation/bloc/pay/pay_bloc.dart';

class HomeScreen extends StatelessWidget {
  final Settings settings;
  const HomeScreen({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PayBloc, PayState>(
        listener: (context, state) {
          if (state is PaySuccess) {
            context.read<CartBloc>().add(ClearCartEvent());
            context.handleState(
                StateEnum.success, StringEnums.payment_success.name.tr());
            if (state.isPrint) {
              context.read<PrintingCubit>().handlePrint(
                    settings,
                    context,
                    widget: InvoiceCard(
                      exChangeAmount: state.exChangeAmount,
                      invoiceNumber: state.invoiceNo,
                      cashierName: state.invoice.invoices.takerName,
                      items: state.invoice.invoiceDtl
                          .map((e) => {
                                'name':
                                    context.trValue(e.proArName, e.proEnName),
                                'qty': e.qty,
                                'price': e.price,
                                'isReturned': false,
                                'total': e.grandTotal,
                              })
                          .toList(),
                      subtotal: state.invoice.invoices.invoiceSubTotal,
                      tax: state.invoice.invoices.invoiceTaxTotal,
                      discount: state.invoice.invoices.invoiceDiscountTotal,
                      total: state.invoice.invoices.invoiceGrandTotal,
                      cashChange: state.invoice.invoices.cashPayment,
                      isReprint: false,
                    ),
                  );
            }
          } else if (state is PayError) {
            context.handleState(StateEnum.error, state.message);
          } else if (state is PayLoading) {
            context.showLottieOverlayLoader(Assets.loader);
          }
        },
        child: Row(
          children: [
            Expanded(flex: 2, child: CartScreen()),
            Expanded(
              flex: 5,
              child: MenuScreen(),
            ),
          ],
        ));
  }
}
