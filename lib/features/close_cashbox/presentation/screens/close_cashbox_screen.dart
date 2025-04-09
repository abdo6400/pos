import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/bloc/cubit/user_cubit.dart';
import '../../../../core/entities/auth_tokens.dart';
import '../../../../core/entities/field.dart';
import '../../../../core/entities/form.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/enums/field_type_enums.dart';
import '../../../../core/utils/enums/state_enums.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/errors/error_card.dart';
import '../../../../core/widgets/global_form_builder/custom_form_builder.dart';
import '../../domain/usecases/close_point_usecase.dart';
import '../bloc/close_cashbox_bloc.dart';
import '../bloc/summary/summary_bloc.dart';

class CloseCashboxScreen extends StatelessWidget {
  const CloseCashboxScreen({super.key});
  static GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  Widget _buildRow(String title, String value, BuildContext context) => Card(
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                title.trExists() ? title.tr() : title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: context.AppResponsiveValue(16,
                          mobile: 12, tablet: 25, desktop: 30),
                    ),
              ),
              Spacer(),
              Text(
                double.parse(value).toStringAsFixed(3),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: context.AppResponsiveValue(16,
                          mobile: 12, tablet: 24, desktop: 30),
                    ),
              ),
            ],
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    final bool isEndDay = ModalRoute.of(context)!.settings.arguments != null;
    return BlocListener<CloseCashboxBloc, CloseCashboxState>(
      listener: (context, state) {
        if (state is CloseCashboxSuccess) {
          if (isEndDay) {
            context.hideOverlayLoader();
            context.pop();
          } else {
            storage.clearAuthTokenState();
            context.go(AppRoutes.login);
          }
        } else if (state is CloseCashboxError) {
          context.handleState(StateEnum.error, state.message);
        } else if (state is CloseCashboxLoading) {
          context.showLottieOverlayLoader(Assets.loader);
        }
      },
      child: Card(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: isEndDay
                ? null
                : Icon(
                    Icons.money,
                    color: Theme.of(context).primaryColor,
                    size: context.AppResponsiveValue(25,
                        mobile: 25, tablet: 35, desktop: 40),
                  ),
            actions: [
              SizedBox(width: 25),
              Text(
                "  ${DateTime.now().minute} :${DateTime.now().hour}  - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: context.AppResponsiveValue(16,
                          mobile: 12, tablet: 24, desktop: 30),
                    ),
              ),
              SizedBox(width: 25),
            ],
            title: Text(
              StringEnums.close_cash.name.tr(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: context.AppResponsiveValue(16,
                        mobile: 12, tablet: 24, desktop: 30),
                  ),
            ),
          ),
          body: BlocBuilder<SummaryBloc, SummaryState>(
            builder: (context, state) {
              if (state is SummaryLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SummarySuccess) {
                return Center(
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 20,
                        children: [
                          Expanded(
                            child: Column(spacing: 30, children: [
                              Text(StringEnums.sales_summary.name.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: context.AppResponsiveValue(16,
                                            mobile: 12,
                                            tablet: 30,
                                            desktop: 30),
                                      )),
                              Column(
                                spacing: 20,
                                children: [
                                  for (var sale in state.paymentsSummary)
                                    _buildRow(
                                      sale.desc,
                                      sale.sum.toString(),
                                      context,
                                    ),
                                  for (var sale in state.salesSummary)
                                    Column(
                                      children: [
                                        _buildRow(
                                          StringEnums.subTotalAmount.name.tr(),
                                          sale.grandTotal.toString(),
                                          context,
                                        ),
                                        _buildRow(
                                          StringEnums.returned_amount.name.tr(),
                                          state.cashSaleSummary.orderReturn
                                              .toString(),
                                          context,
                                        ),
                                        _buildRow(
                                          StringEnums.totalAmount.name.tr(),
                                          "${sale.grandTotal - state.cashSaleSummary.orderReturn}",
                                          context,
                                        ),
                                      ],
                                    ),
                                  _buildRow(
                                    StringEnums.requiredAmount.name.tr(),
                                    state.cashSaleSummary.cashCustody
                                        .toString(),
                                    context,
                                  ),
                                ],
                              ),
                            ]),
                          ),
                          VerticalDivider(),
                          Expanded(
                            child: Column(
                              spacing: 10,
                              children: [
                                CustomFormBuilder(
                                  FormParams(formKey: _formKey, fields: [
                                    FieldParams(
                                      type: FieldTypeEnums.text,
                                      label: StringEnums.amount.name,
                                      validators: [
                                        FormBuilderValidators.numeric(),
                                        FormBuilderValidators.positiveNumber(),
                                      ],
                                      icon: Icons.money_outlined,
                                    ),
                                  ]),
                                ),
                                NumericKeypadInput(
                                  formKey: _formKey,
                                  grandTotal: 0,
                                ),
                                BlocBuilder<UserCubit, AuthTokens?>(
                                  builder: (context, user) {
                                    return CustomButton(
                                      backgroundColor: Colors.green,
                                      buttonLabel: StringEnums.shift_end.name,
                                      onSubmit: () {
                                        if (_formKey.currentState
                                                ?.saveAndValidate() ??
                                            false) {
                                          if ((state.cashSaleSummary.cashSales +
                                                      state.cashSaleSummary
                                                          .cashCustody) -
                                                  state.cashSaleSummary
                                                      .orderReturn ==
                                              (double.tryParse(_formKey
                                                          .currentState!.value[
                                                      StringEnums
                                                          .amount.name]) ??
                                                  0)) {
                                            locator<CloseCashboxBloc>().add(
                                                ClosePointEvent(
                                                    closePointParams:
                                                        ClosePointParams(
                                                            cashNo: state
                                                                    .salesSummary
                                                                    .isNotEmpty
                                                                ? state
                                                                    .salesSummary
                                                                    .first
                                                                    .cashNo
                                                                    .toString()
                                                                : state.paymentsSummary
                                                                        .isNotEmpty
                                                                    ? state
                                                                        .paymentsSummary
                                                                        .first
                                                                        .cashno
                                                                        .toString()
                                                                    : "1",
                                                            cashUser: user?.userNo ??
                                                                0,
                                                            cashRealEndTime:
                                                                DateTime.now(),
                                                            cashWithDrawals: 0,
                                                            cashServiceTotal: 0,
                                                            voidBefore: 0,
                                                            availableCash:
                                                                double.tryParse(_formKey.currentState!.value[StringEnums.amount.name]) ??
                                                                    0,
                                                            requiredCash: (state
                                                                        .cashSaleSummary
                                                                        .cashSales +
                                                                    state.cashSaleSummary.cashCustody) -
                                                                state.cashSaleSummary.orderReturn,
                                                            illegalOpenCashDrawer: 0,
                                                            cashSubTotal: state.salesSummary.isNotEmpty ? state.salesSummary.first.subTotal : 0,
                                                            cashGrandTotal: state.salesSummary.isNotEmpty ? state.salesSummary.first.grandTotal : 0,
                                                            cashDiscountTotal: state.salesSummary.isNotEmpty ? state.salesSummary.first.discount : 0,
                                                            cashTaxTotal: state.salesSummary.isNotEmpty ? state.salesSummary.first.tax : 0,
                                                            cashCustomerPayment: state.cashSaleSummary.cashSales,
                                                            voidAfter: state.cashSaleSummary.orderReturn)));
                                          } else {
                                            context.showMessageToast(
                                                msg:
                                                    "${StringEnums.requiredAmount.name.tr()} ${(state.cashSaleSummary.cashSales + state.cashSaleSummary.cashCustody) - state.cashSaleSummary.orderReturn}",
                                                backgroundColor: Colors.red);
                                          }
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ]),
                  )),
                );
              } else if (state is SummaryError) {
                return ErrorCard(
                  message: state.message,
                  onRetry: () => context.read<SummaryBloc>().add(
                        GetSummaryEvent(),
                      ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class NumericKeypadInput extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final double grandTotal;

  const NumericKeypadInput(
      {super.key, required this.formKey, required this.grandTotal});

  void _onKeyPressed(String value, BuildContext context) {
    final currentValue =
        formKey.currentState?.fields[StringEnums.amount.name]?.value ?? '';
    String newValue = currentValue;

    if (value == 'X') {
      // Handle backspace (remove last character)
      if (newValue.isNotEmpty) {
        newValue = newValue.substring(0, newValue.length - 1);
      }
    } else if (value == '.') {
      // Handle decimal point (only allow one decimal point)
      if (!newValue.contains('.')) {
        newValue += value;
      }
    } else {
      // Append the pressed number
      newValue += value;
    }

    // Update the form field value
    if (formKey.currentState != null) {
      formKey.currentState!.fields[StringEnums.amount.name]
          ?.didChange(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          childAspectRatio: 2.5,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          children: [
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
            '7',
            '8',
            '9',
            '.',
            '0',
            'X',
          ].map((key) {
            return InkWell(
              onTap: () => _onKeyPressed(key, context),
              child: Card(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: (key == 'X') ? Colors.red : null),
                  child: Text(
                    key,
                    style: TextStyle(
                      color: (key == 'X') ? Colors.white : null,
                      fontSize: context.AppResponsiveValue(12,
                          mobile: 8, tablet: 24, desktop: 30),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
