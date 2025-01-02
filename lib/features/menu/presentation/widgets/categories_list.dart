import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/empty_message.dart';
import '../../../../core/widgets/errors/error_message.dart';
import '../bloc/category/category_bloc.dart';
import 'category_chip.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryError) {
          return ErrorMessage(
            message: state.message,
            onRetry: () =>
                context.read<CategoryBloc>().add(GetCategoriesEvent()),
          );
        }
        if (state is CategorySuccess && state.categories.isEmpty) {
          return EmptyMessage(
            message: StringEnums.no_categories_found.name.tr(),
          );
        }
        return Skeletonizer(
          enabled: state is CategoryLoading,
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CategoryChip(
                    loading: state is CategoryLoading,
                    category: (state is CategorySuccess && index != 0)
                        ? state.categories[index - 1]
                        : null,
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
              itemCount:
                  state is CategorySuccess ? state.categories.length + 1 : 10),
        );
      },
    );
  }
}
