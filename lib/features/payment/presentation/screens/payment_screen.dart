import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/core/widgets/custom_button.dart';
import '../../../../core/entities/field.dart';
import '../../../../core/entities/form.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/global_form_builder/custom_form_builder.dart';
import '../../domain/entities/payment_type.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  static GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final List<PaymentType> paymentTypes =
        ModalRoute.of(context)!.settings.arguments as List<PaymentType>;
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
                SizedBox(
                  width: 25,
                ),
                Text(
                  "  ${DateTime.now().minute} :${DateTime.now().hour}  - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: context.AppResponsiveValue(16,
                            mobile: 12, tablet: 24, desktop: 30),
                      ),
                ),
                SizedBox(
                  width: 25,
                ),
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
        padding: const EdgeInsets.all(5),
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
                onSubmit: () {},
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      spacing: 5,
                      children: [
                        _buildAmountRow(context,
                            StringEnums.totalAmount.name.tr(), '100 JOD'),
                        _buildAmountRow(context,
                            StringEnums.discountAmount.name.tr(), '10 JOD'),
                        _buildAmountRow(context,
                            StringEnums.returned_amount.name.tr(), '10 JOD'),
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
                        child: CustomFormBuilder(FormParams(
                            formKey: _formKey,
                            fields: paymentTypes
                                .map((e) => FieldParams(
                                      label: context.trValue(
                                          e.paymentArDesc, e.paymentEnDesc),
                                      validators: [],
                                      icon: Icons.payment_outlined,
                                    ))
                                .toList()))),
                    VerticalDivider(),
                    Flexible(
                      flex: 2,
                      child: NumericKeypadInput(),
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

class NumericKeypadInput extends StatefulWidget {
  const NumericKeypadInput({super.key});

  @override
  State<NumericKeypadInput> createState() => _NumericKeypadInputState();
}

class _NumericKeypadInputState extends State<NumericKeypadInput> {
  String _inputValue = '';

  void _onKeyPressed(String value) {
    setState(() {
      if (value == 'X') {
        _inputValue = '';
      } else if (value == '.') {
        if (!_inputValue.contains('.')) {
          _inputValue += value;
        }
      } else {
        _inputValue += value;
      }
    });
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
        '10',
        '50',
        '100',
        '150',
        '200',
        '250',
      ].map((key) {
        return InkWell(
          onTap: () => _onKeyPressed(key),
          child: Card(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: key == 'X'
                    ? Colors.red
                    : (key == '10' ||
                            key == '50' ||
                            key == '100' ||
                            key == '150' ||
                            key == '200' ||
                            key == '250'
                        ? Theme.of(context).primaryColor
                        : null),
              ),
              child: Text(
                key,
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
