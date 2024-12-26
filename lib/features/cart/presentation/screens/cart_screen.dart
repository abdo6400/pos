import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/app_logo.dart';

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
            Expanded(
                child: Container(
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(
                      color: Theme.of(context).hintColor.withAlpha(50)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringEnums.click_here.name.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: context.ResponsiveValu(14,
                                  mobile: 10, tablet: 20, desktop: 24),
                            ),
                      ),
                      Text(
                        StringEnums.click_here.name.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: context.ResponsiveValu(14,
                                  mobile: 10, tablet: 20, desktop: 24),
                            ),
                      ),
                    ],
                  ),
                  AppLogo(),
                ],
              ),
            )),
            Expanded(
              flex: 7,
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
