import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../../domain/entities/category.dart';
import '../bloc/category_selection/category_selection_cubit.dart';

class CategoryChip extends StatelessWidget {
  final Category? category;
  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final selected = category != null &&
        context.watch<CategorySelectionCubit>().state.catId == category!.catId;
    return InkWell(
      onTap: () => category != null
          ? context.read<CategorySelectionCubit>().selectCategory(category!)
          : null,
      child: Chip(
        label: Text(category != null
            ? context.trValue(category!.catArName, category!.catEnName)
            : 'Category'),
        backgroundColor:
            selected ? Theme.of(context).colorScheme.primary : null,
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: selected ? Colors.white : null,
              fontSize: context.ResponsiveValu(13,
                  mobile: 12, tablet: 16, desktop: 23),
            ),
      ),
    );
  }
}
