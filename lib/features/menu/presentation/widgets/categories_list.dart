import 'package:flutter/material.dart';
import '../../../../core/utils/extensions/extensions.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Chip(
              label: Text('Category $index'),
              labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: context.ResponsiveValu(13,
                        mobile: 12, tablet: 16, desktop: 23),
                  ),
            ),
        separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
        itemCount: 10);
  }
}
