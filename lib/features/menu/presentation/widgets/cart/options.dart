import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../../../../../core/utils/enums/string_enums.dart';

class Options extends StatelessWidget {
  const Options({super.key});
  static final List<Option> options = [
    Option(
        title: StringEnums.pending.name,
        icon: Icons.list,
        color: Colors.amber,
        onPress: () {}),
    Option(
        title: StringEnums.deleviry.name,
        icon: Icons.delivery_dining,
        color: Colors.green,
        onPress: () {}),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
          spacing: 20,
          children: options
              .map((e) => Flexible(
                    child: InkWell(
                      onTap: () => e.onPress(),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Card(
                          elevation: 0.2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: e.color),
                          ),
                          child: ResponsiveRowColumn(
                            layout: ResponsiveRowColumnType.COLUMN,
                            rowMainAxisAlignment: MainAxisAlignment.center,
                            columnMainAxisAlignment: MainAxisAlignment.center,
                            rowSpacing: 1,
                            columnSpacing: 1,
                            rowPadding: const EdgeInsets.all(8),
                            children: [
                              ResponsiveRowColumnItem(
                                child: Icon(
                                  e.icon,
                                  color: e.color,
                                  size: context.AppResponsiveValue(20,
                                      mobile: 20, tablet: 35, desktop: 45),
                                ),
                              ),
                              ResponsiveRowColumnItem(
                                child: Text(e.title.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontSize:
                                                context.AppResponsiveValue(11,
                                                    mobile: 10,
                                                    tablet: 14,
                                                    desktop: 25))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList()),
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
