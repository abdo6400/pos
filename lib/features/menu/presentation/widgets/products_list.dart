import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        gridDelegate: ResponsiveGridDelegate(
            maxCrossAxisExtent: context.ResponsiveValu(150,
                mobile: 100, tablet: 200, desktop: 300),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) => Card(
              child: Container(
                alignment: Alignment.center,
                child: Text("Product $index"),
              ),
            ));
  }
}
