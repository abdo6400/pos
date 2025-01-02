import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../widgets/custom_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        elevation: 0.2,
        shape: BorderDirectional(
          start: BorderSide(color: Theme.of(context).hintColor.withAlpha(50)),
        ),
        child: Column(
          children: [
            Expanded(child: CustomAppBar()),
            Expanded(
              flex: context.ResponsiveValu(4, mobile: 5, tablet: 6, desktop: 6)
                  .toInt(),
              child: Column(
                children: [
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                      child: Card(
                    elevation: 0.2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Container(
                      width: double.infinity,
                    ),
                  )),
                ],
              ),
            ),
          ],
        ));
  }
}
