import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/widgets/errors/error_message.dart';
import '../bloc/category/category_bloc.dart';

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
        return Skeletonizer(
          enabled: state is CategoryLoading,
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Chip(
                    label: Text(state is CategorySuccess
                        ? context.trValue(state.categories[index].catArName,
                            state.categories[index].catEnName)
                        : 'Category $index'),
                    labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: context.ResponsiveValu(13,
                              mobile: 12, tablet: 16, desktop: 23),
                        ),
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
              itemCount:
                  state is CategorySuccess ? state.categories.length : 10),
        );
      },
    );
  }
}
