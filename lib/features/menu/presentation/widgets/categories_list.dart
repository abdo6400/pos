import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/widgets/errors/error_message.dart';
import '../bloc/category/category_bloc.dart';
import '../bloc/category_selection/category_selection_cubit.dart';
import 'category_chip.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategorySuccess && state.categories.isNotEmpty) {
          context
              .read<CategorySelectionCubit>()
              .selectCategory(state.categories[0]);
        }
      },
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
              itemBuilder: (context, index) => CategoryChip(
                    category: state is CategorySuccess
                        ? state.categories[index]
                        : null,
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
