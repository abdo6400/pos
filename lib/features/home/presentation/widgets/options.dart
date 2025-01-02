import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../../../../core/utils/enums/string_enums.dart';

class Options extends StatelessWidget {
  const Options({super.key});
  static final List<Option> options = [
    Option(
        title: StringEnums.pendingOrders.name,
        icon: Icons.list,
        color: Colors.red,
        onPress: () {}),
    Option(
        title: StringEnums.deleviry.name,
        icon: Icons.delivery_dining,
        color: Colors.green,
        onPress: () {}),
    Option(
        title: StringEnums.offers.name,
        icon: Icons.local_offer_outlined,
        color: Colors.amber,
        onPress: () {}),
    Option(
        title: StringEnums.discounts.name,
        icon: Icons.discount_outlined,
        color: Colors.blueAccent,
        onPress: () {}),
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 5),
      shape: BorderDirectional(
        top: BorderSide(color: Theme.of(context).hintColor.withAlpha(50)),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
            children: options
                .map((e) => Flexible(
                      child: InkWell(
                        onTap: () => e.onPress(),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: context.isMobile ? 10 : 30,
                                vertical: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: e.color),
                            ),
                            child: ResponsiveRowColumn(
                              layout: context.isMobile
                                  ? ResponsiveRowColumnType.ROW
                                  : ResponsiveRowColumnType.COLUMN,
                              rowMainAxisAlignment: MainAxisAlignment.center,
                              columnMainAxisAlignment: MainAxisAlignment.center,
                              rowSpacing: 10,
                              columnSpacing: 10,
                              rowPadding: const EdgeInsets.all(8),
                              children: [
                                ResponsiveRowColumnItem(
                                  child: Icon(
                                    e.icon,
                                    color: e.color,
                                    size: context.ResponsiveValu(20,
                                        mobile: 20, tablet: 35, desktop: 45),
                                  ),
                                ),
                                ResponsiveRowColumnItem(
                                  child: Text(e.title.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: context.ResponsiveValu(
                                                  11,
                                                  mobile: 10,
                                                  tablet: 20,
                                                  desktop: 30))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList()),
      ),
    );
  }
}

class Option {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPress;
  const Option(
      {required this.title,
      required this.icon,
      required this.onPress,
      required this.color});
}
