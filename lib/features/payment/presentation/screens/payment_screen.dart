import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/core/widgets/custom_button.dart';
import '../../../../core/entities/field.dart';
import '../../../../core/entities/form.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/global_form_builder/custom_form_builder.dart';
import '../../domain/entities/payment_type.dart';
import '../bloc/cubit/payment_type_selection_cubit.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  static GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final List<PaymentType> paymentTypes =
        ModalRoute.of(context)!.settings.arguments as List<PaymentType>;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaymentTypeSelectionCubit(),
        )
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
                child: Row(
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
                        onSubmit: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            _formKey.currentState!.fields.forEach((key, value) {
                              print('$key: ${value.value}');
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        backgroundColor: Colors.blue,
                        buttonLabel: StringEnums.print.name,
                        onSubmit: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
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
                                    '100 JOD'),
                                _buildAmountRow(
                                    context,
                                    StringEnums.discountAmount.name.tr(),
                                    '10 JOD'),
                                _buildAmountRow(
                                    context,
                                    StringEnums.returned_amount.name.tr(),
                                    '10 JOD'),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
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
                                            label: context.trValue(
                                                e.paymentArDesc,
                                                e.paymentEnDesc),
                                            validators: [
                                              if (!e.paymentEnDesc
                                                  .toUpperCase()
                                                  .contains(
                                                      'Cash'.toUpperCase()))
                                                FormBuilderValidators.range(
                                                    0, 300,
                                                    checkNullOrEmpty: false),
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
                              child: NumericKeypadInput(
                                formKey: _formKey,
                                paymentTypes: paymentTypes,
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
          },
        ),
      ),
    );
  }

  // Helper method to build amount rows
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
  final List<PaymentType> paymentTypes;

  const NumericKeypadInput({
    super.key,
    required this.formKey,
    required this.paymentTypes,
  });

  void _onKeyPressed(String value, BuildContext context) {
    final activeField = context.read<PaymentTypeSelectionCubit>().state;
    final currentValue = formKey.currentState?.fields[activeField]?.value ?? '';

    String newValue = currentValue;

    if (value == 'X') {
      // Handle backspace (remove last character)
      if (newValue.isNotEmpty) {
        newValue = newValue.substring(0, newValue.length - 1);
      }
    } else if (value == 'exact') {
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

    // Update the form field with the new value
    if (formKey.currentState != null) {
      formKey.currentState!.fields[activeField]?.didChange(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
                  fontSize: context.AppResponsiveValue(12,
                      mobile: 8, tablet: 24, desktop: 30),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
