import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:retail/core/entities/auth_tokens.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/core/widgets/custom_button.dart';
import '../../../../core/bloc/cubit/user_cubit.dart';
import '../../../../core/entities/field.dart';
import '../../../../core/entities/form.dart';
import '../../../../core/entities/settings.dart';
import '../../../../core/utils/enums/field_type_enums.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/global_form_builder/custom_form_builder.dart';
import '../../domain/entities/payment_type.dart';
import '../bloc/cubit/payment_type_selection_cubit.dart';
import '../bloc/cubit/returned_amount_cubit.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  static GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  void payInvoice(
      List<PaymentType> paymentTypes,
      bool isPrint,
      double grandTotal,
      double exChangeAmount,
      Function(Map<int, double>, bool, double) pay,
      BuildContext context) {
    if (_formKey.currentState!.saveAndValidate()) {
      final paymentTypeLookup = <String, int>{};
      for (final paymentType in paymentTypes) {
        paymentTypeLookup[paymentType.paymentEnDesc] = paymentType.ptype;
        paymentTypeLookup[paymentType.paymentArDesc] = paymentType.ptype;
      }

      final payments = <int, double>{};
      _formKey.currentState!.fields.forEach((key, value) {
        if (value.value != null && value.value!.isNotEmpty) {
          final amount = double.parse(value.value!);
          if (amount > 0) {
            final ptype = paymentTypeLookup[key];
            if (ptype != null) {
              payments.putIfAbsent(ptype, () => amount);
            }
          }
        }
      });
      double totalPaymentsBefore =
          payments.values.fold(0, (sum, amount) => sum + amount);

      if (payments.isEmpty || totalPaymentsBefore < grandTotal) {
        context.showMessageToast(
          msg: StringEnums.please_enter_amount.name.tr(),
        );
        return;
      }

      // Calculate the total of non-cash payments (PayType 1, PayType 2, etc.)
      double nonCashTotal = 0;
      payments.forEach((ptype, amount) {
        if (ptype != 0) {
          // Exclude cash payment (PayType 0)
          nonCashTotal += amount;
        }
      });

      // Calculate the required cash payment (PayType 0)
      double cashPayment = grandTotal - nonCashTotal;

      // Ensure cash payment is not negative
      if (cashPayment < 0) {
        cashPayment = 0;
      }

      // Add or update the cash payment in the payments map
      payments[0] = cashPayment; // Assuming PayType 0 is cash

      // Calculate the total payments
      double totalPayments =
          payments.values.fold(0, (sum, amount) => sum + amount);

      if (totalPayments >= grandTotal) {
        Navigator.pop(context);
        pay(payments, isPrint, exChangeAmount); // Send the payments
      } else {
        context.showMessageToast(
          msg: StringEnums.amount_less_than_grand_total.name.tr(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final param = ModalRoute.of(context)!.settings.arguments as List;
    final List<PaymentType> paymentTypes =
        (param[0] as List<PaymentType>).takeWhile((e) => e.isActive).toList();
    final pay = param[1] as Function(Map<int, double>, bool, double);
    final grandTotal = param[2] as double;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaymentTypeSelectionCubit(),
        ),
        BlocProvider(create: (_) => ReturnedAmountCubit()),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              context.AppResponsiveValue(1, mobile: 1, tablet: 20, desktop: 30),
          vertical:
              context.AppResponsiveValue(1, mobile: 1, tablet: 20, desktop: 30),
        ),
        child: BlocBuilder<PaymentTypeSelectionCubit, String?>(
          builder: (context, state) {
            return  BlocBuilder<UserCubit,AuthTokens?>(
                builder: (context,state) {
                  final int numbersOfDigits = state?.numbersOfDigits??3;
                  return Scaffold(
                  appBar: context.isMobile
                      ? null
                      : AppBar(
                          leading: Icon(
                            Icons.payment_outlined,
                            size: context.AppResponsiveValue(25,
                                mobile: 25, tablet: 35, desktop: 40),
                          ),
                          actions: [
                            SizedBox(width: 25),
                            Text(
                              "  ${DateTime.now().minute} :${DateTime.now().hour}  - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontSize: context.AppResponsiveValue(16,
                                            mobile: 12, tablet: 24, desktop: 30),
                                      ),
                            ),
                            SizedBox(width: 25),
                          ],
                          title: Text(
                            StringEnums.pay_by.name.tr(),
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: context.AppResponsiveValue(16,
                                      mobile: 12, tablet: 24, desktop: 30),
                                ),
                          ),
                        ),
                  bottomNavigationBar: Padding(
                    padding: EdgeInsets.all(
                      context.AppResponsiveValue(5,
                          mobile: 1, tablet: 30, desktop: 40),
                    ),
                    child:  BlocBuilder<ReturnedAmountCubit, double>(
                          builder: (context, exChangeAmount) {
                            return Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    backgroundColor: Colors.red,
                                    buttonLabel: StringEnums.close.name,
                                    onSubmit: () => Navigator.pop(context),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomButton(
                                    backgroundColor: Colors.green,
                                    buttonLabel: StringEnums.save.name,
                                    onSubmit: () => payInvoice(paymentTypes, false,
                                        grandTotal, exChangeAmount, pay, context),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomButton(
                                    backgroundColor: Colors.blue,
                                    buttonLabel: StringEnums.print.name,
                                    onSubmit: () => payInvoice(paymentTypes, true,
                                        grandTotal, exChangeAmount, pay, context),
                                  ),
                                ),
                              ],
                            );
                          },
                        )

                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  spacing: 5,
                                  children: [
                                    _buildAmountRow(
                                        context,
                                        StringEnums.totalAmount.name.tr(),
                                        grandTotal.toStringAsFixed(numbersOfDigits)),
                                    BlocBuilder<ReturnedAmountCubit, double>(
                                      builder: (context, state) {
                                        return _buildAmountRow(
                                            context,
                                            StringEnums.returned_amount.name.tr(),
                                            state.toStringAsFixed(numbersOfDigits));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              spacing: 10,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: CustomFormBuilder(
                                    FormParams(
                                      formKey: _formKey,
                                      onFocus: (paymentType) {

                                        context
                                            .read<PaymentTypeSelectionCubit>()
                                            .selectPaymentType(paymentType);
                                      },
                                      fields: paymentTypes
                                          .map((e) => FieldParams(
                                                type: FieldTypeEnums.text,
                                                readOnly: true,
                                                label: context.trValue(
                                                    e.paymentArDesc,
                                                    e.paymentEnDesc),
                                                validators: [
                                                  FormBuilderValidators.numeric(
                                                      checkNullOrEmpty: false),
                                                  FormBuilderValidators
                                                      .positiveNumber(
                                                          checkNullOrEmpty: false),
                                                ],
                                                icon: Icons.payment_outlined,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                VerticalDivider(),
                                Flexible(
                                  flex: 2,
                                  child: BlocBuilder<ReturnedAmountCubit, double>(
                                    builder: (context, state) {
                                      return NumericKeypadInput(
                                        formKey: _formKey,
                                        grandTotal: grandTotal,
                                        paymentTypes: paymentTypes,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            );
          },
        ),
      ),
    );
  }

  Widget _buildAmountRow(BuildContext context, String label, String amount) {
    return Row(
      children: [
        Text(
          label.tr(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: context.AppResponsiveValue(14,
                    mobile: 14, tablet: 20, desktop: 24),
              ),
        ),
        const Spacer(),
        Text(
          amount,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: context.AppResponsiveValue(14,
                    mobile: 14, tablet: 20, desktop: 24),
              ),
        ),
      ],
    );
  }
}

class NumericKeypadInput extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final double grandTotal;
  final List<PaymentType> paymentTypes;

  const NumericKeypadInput({
    super.key,
    required this.formKey,
    required this.grandTotal,
    required this.paymentTypes,
  });

  void _onKeyPressed(String value, BuildContext context) {
    final activeField = context.read<PaymentTypeSelectionCubit>().state;
    final currentValue = formKey.currentState?.fields[activeField]?.value ?? '';
    String newValue = currentValue;

    // Get the active payment type
    final activePaymentType = paymentTypes.firstWhereOrNull(
      (element) =>
          element.paymentEnDesc == activeField ||
          element.paymentArDesc == activeField,
    );

    if(activePaymentType==null)
      return;


    if (value == 'X') {
      // Handle backspace (remove last character)
      if (newValue.isNotEmpty) {
        newValue = newValue.substring(0, newValue.length - 1);
      }
    } else if (value == 'exact') {
      // Handle exact (set value to the remaining amount)
      double totalPayments = 0;

      // Sum up all payment values except the active field
      formKey.currentState?.fields.forEach((key, value) {
        if (key != activeField) {
          final paymentValue = double.tryParse(value.value ?? '0') ?? 0;
          totalPayments += paymentValue;
        }
      });

      // Calculate the remaining amount
      double remainingAmount = grandTotal - totalPayments;

      // Ensure the remaining amount is not negative
      if (remainingAmount < 0) {
        remainingAmount = 0;
      }

      // Set the active field's value to the remaining amount
      newValue = remainingAmount.toStringAsFixed(3);
    } else if (value == 'C') {
      // Handle clear (delete all text)
      newValue = '';
    } else if (value == '.') {
      // Handle decimal point
      if (!newValue.contains('.')) {
        newValue += value;
      }
    } else if (value == '20' ||
        value == '50' ||
        value == '100' ||
        value == '200') {
      // Handle predefined amounts
      newValue = value;
    } else {
      // Handle numeric input
      newValue += value;
    }

    // Validate non-cash payments
    if (activePaymentType.ptype != 0) {
      // Non-cash payment type (e.g., Visa, MasterCard)
      final newAmount = double.tryParse(newValue) ?? 0;
      if (newAmount > grandTotal) {
        // Show an error or limit the value to the grandTotal
        newValue = grandTotal.toStringAsFixed(3);
      }
    }

    // Update the form field with the new value
    if (formKey.currentState != null) {
      formKey.currentState!.fields[activeField]?.didChange(newValue);
    }

    // Calculate the returned amount if the total exceeds grandTotal
    _calculateReturnedAmount(context);
  }

  void _calculateReturnedAmount(BuildContext context) {
    double totalPayments = 0;
    formKey.currentState?.fields.forEach((key, value) {
      final paymentValue = double.tryParse(value.value ?? '0') ?? 0;
      totalPayments += paymentValue;
    });
    if (totalPayments > grandTotal) {
      final returned = totalPayments - grandTotal;
      context
          .read<ReturnedAmountCubit>()
          .setReturnedAmount(double.parse(returned.toStringAsFixed(3)));
    } else {
      context.read<ReturnedAmountCubit>().setReturnedAmount(0.0);
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
            '20',
            '50',
            'C',
            '100',
            '200',
            'exact'
          ].map((key) {
            return InkWell(
              onTap: () => _onKeyPressed(key, context),
              child: Card(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: (key == 'X')
                          ? Colors.red
                          : (key == 'C')
                              ? Colors.blue
                              : (key == '20' ||
                                      key == '50' ||
                                      key == '100' ||
                                      key == '200')
                                  ? Theme.of(context).primaryColor
                                  : (key == 'exact')
                                      ? Colors.green
                                      : null),
                  child: Text(
                    key.trExists() ? key.tr() : key,
                    style: TextStyle(
                      color: (key == 'X') ||
                              (key == 'C') ||
                              (key == '20' ||
                                  key == '50' ||
                                  key == '100' ||
                                  key == '200') ||
                              (key == 'exact')
                          ? Colors.white
                          : null,
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
        CustomButton(
          backgroundColor: Colors.red,
          buttonLabel: StringEnums.clear_all.name,
          onSubmit: () {
            formKey.currentState?.fields.forEach((key, value) {
              value.didChange('');
            });
            context.read<ReturnedAmountCubit>().setReturnedAmount(0.0);
          },
        ),
      ],
    );
  }
}
