import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../widgets/categories_list.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/products_list.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: context.ResponsiveValu(3, mobile: 2, tablet: 2, desktop: 2)
                .toInt(),
            child: CustomAppBar()),
        Expanded(
            flex: context.ResponsiveValu(4, mobile: 2, tablet: 2, desktop: 2)
                .toInt(),
            child: CategoriesList()),
        Expanded(
            flex:
                context.ResponsiveValu(14, mobile: 14, tablet: 14, desktop: 16)
                    .toInt(),
            child: ProductsList()),
      ],
    );
  }
}
