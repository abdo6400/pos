import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/core/widgets/custom_button.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../domain/entities/payment_type.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PaymentType> paymentTypes =
        ModalRoute.of(context)!.settings.arguments as List<PaymentType>;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: Icon(
          Icons.payment_outlined,
          size: context.AppResponsiveValue(25,
              mobile: 25, tablet: 35, desktop: 40),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "  ${DateTime.now().minute} :${DateTime.now().hour}  - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: context.AppResponsiveValue(16,
                        mobile: 12, tablet: 24, desktop: 30),
                  ),
            ),
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                spacing: 10,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 5,
                      children: [
                        Column(
                          children: [
                            _buildAmountRow(context,
                                StringEnums.totalAmount.name.tr(), '100 JOD'),
                            _buildAmountRow(context,
                                StringEnums.discountAmount.name.tr(), '10 JOD'),
                          ],
                        ),
                        Wrap(
                            alignment: WrapAlignment.spaceAround,
                            spacing: 2,
                            runSpacing: 2,
                            children: List.generate(
                              paymentTypes.length,
                              (index) => Card(
                                  child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: context.trValue(
                                    paymentTypes[index].paymentArDesc,
                                    paymentTypes[index].paymentEnDesc,
                                  ),
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: context.AppResponsiveValue(12,
                                            mobile: 10,
                                            tablet: 20,
                                            desktop: 24),
                                      ),
                                ),
                              )),
                            )),
                      ],
                    ),
                  ),
                  Flexible(child: NumericKeypadInput()),
                ],
              ),
            ),
          ),
        ],
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
                fontSize: context.AppResponsiveValue(16,
                    mobile: 14, tablet: 20, desktop: 24),
              ),
        ),
        const Spacer(),
        Text(
          amount,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: context.AppResponsiveValue(16,
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
      if (value == 'C') {
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
      childAspectRatio: 2,
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
        'C',
      ].map((key) {
        return InkWell(
          onTap: () => _onKeyPressed(key),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              key,
              style: TextStyle(
                  fontSize: context.AppResponsiveValue(12,
                      mobile: 8, tablet: 16, desktop: 22),
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }
}
