import 'package:flutter/material.dart';
import '../../../../core/widgets/app_logo.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        elevation: 0.2,
        shape: BorderDirectional(
          start: BorderSide(color: Colors.black),
        ),
        child: Column(
          children: [
            Expanded(
                child: Container(
              alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(color: Theme.of(context).hintColor),
                ),
              ),
              child: AppLogo(),
            )),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                      child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 0.2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    color: Theme.of(context).colorScheme.secondary,
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
