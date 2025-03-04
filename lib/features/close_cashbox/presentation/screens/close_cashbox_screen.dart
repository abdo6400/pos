import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../../../../core/entities/field.dart';
import '../../../../core/entities/form.dart';
import '../../../../core/utils/enums/field_type_enums.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/global_form_builder/custom_form_builder.dart';

class CloseCashboxScreen extends StatelessWidget {
  const CloseCashboxScreen({super.key});
  static GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(
            Icons.payment_outlined,
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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Expanded(
                  child: Column(
                    spacing: 20,
                    children: [
                      Text(StringEnums.sales_summary.name.tr(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: context.AppResponsiveValue(16,
                                        mobile: 12, tablet: 24, desktop: 30),
                                  )),
                      Row(
                        children: [
                          Text(
                            StringEnums.amount.name.tr(),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: context.AppResponsiveValue(16,
                                          mobile: 12, tablet: 24, desktop: 30),
                                    ),
                          ),
                          Spacer(),
                          Text(
                            "0.00",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: context.AppResponsiveValue(16,
                                          mobile: 12, tablet: 24, desktop: 30),
                                    ),
                          ),
                        ],
                      )
                    ],
                  ),
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
                      CustomButton(
                        backgroundColor: Colors.green,
                        buttonLabel: StringEnums.shift_end.name,
                        onSubmit: () {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {}
                        },
                      ),
                    ],
                  ),
                )
              ]),
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
