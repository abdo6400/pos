import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../utils/enums/string_enums.dart';

class NumericKeypadInput extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;

  const NumericKeypadInput({super.key, required this.formKey});

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
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 2.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 20,
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
    );
  }
}
