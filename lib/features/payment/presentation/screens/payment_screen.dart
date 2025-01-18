import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/widgets/custom_button.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../bloc/payment_types/payment_types_bloc.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: BlocBuilder<PaymentTypesBloc, PaymentTypesState>(
                  builder: (context, state) {
                    if (state is PaymentTypesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PaymentTypesSuccess) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 80,
                        ),
                        itemCount: state.paymentTypes.length,
                        itemBuilder: (context, index) => Card(
                          child: CheckboxListTile(
                            onChanged: (value) {},
                            value: index == 0,
                            title:
                                Text(state.paymentTypes[index].paymentEnDesc),
                          ),
                        ),
                      );
                    } else if (state is PaymentTypesError) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                        backgroundColor: Colors.red,
                        buttonLabel: StringEnums.close.name,
                        onSubmit: () => Navigator.pop(context)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: CustomButton(
                    backgroundColor: Colors.green,
                    buttonLabel: StringEnums.confirm.name,
                    onSubmit: () {},
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
