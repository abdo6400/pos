import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../../../../../core/utils/enums/string_enums.dart';
import '../../../domain/entities/category.dart';
import '../../bloc/cubit/category_selection_cubit.dart';

class CategoryChip extends StatelessWidget {
  final Category? category;
  final bool loading;
  const CategoryChip({super.key, required this.category, this.loading = false});

  @override
  Widget build(BuildContext context) {
    final selected =
        context.watch<CategorySelectionCubit>().state?.catId == category?.catId;
    return InkWell(
      onTap: () =>
          context.read<CategorySelectionCubit>().selectCategory(category),
      child: Chip(
        elevation: 10,
        label: Text(category != null
            ? context.trValue(category!.catArName, category!.catEnName)
            : loading
                ? StringEnums.loading.name.tr()
                : StringEnums.all.name.tr()),
        backgroundColor: (selected && !loading)
            ? context.generateColorFromValue(category?.catId ?? "0",
                darkenFactor: 0.2)
            : null,
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: selected ? Colors.white : null,
              fontSize: context.ResponsiveValu(13,
                  mobile: 12, tablet: 16, desktop: 23),
            ),
      ),
    );
  }
}
