import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../../../core/widgets/empty_message.dart';
import '../../../../../core/widgets/errors/error_message.dart';
import '../../../domain/entities/category.dart';
import '../../bloc/category/category_bloc.dart';
import '../../bloc/cubit/offer_selection_cubit.dart';
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
        final List<Category> categories = state is CategorySuccess
            ? state.categories.where((c) => c.saleable).toList()
            : [];
        return Skeletonizer(
          enabled: state is CategoryLoading,
          child: Row(
            children: [
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  context.read<OfferSelectionCubit>().ShowHideOffer(true);
                },
                child: Chip(
                    elevation: 10,
                    backgroundColor: (context
                            .watch<OfferSelectionCubit>()
                            .state)
                        ? Theme.of(context).colorScheme.secondary.withAlpha(50)
                        : null,
                    labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: context.watch<OfferSelectionCubit>().state
                              ? Colors.white
                              : null,
                          fontSize: context.AppResponsiveValue(13,
                              mobile: 12, tablet: 16, desktop: 23),
                        ),
                    label: Icon(
                      Icons.local_offer_sharp,
                      color: Colors.red,
                      size: context.AppResponsiveValue(13,
                          mobile: 12, tablet: 25, desktop: 35),
                    )),
              ),
              Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CategoryChip(
                          loading: state is CategoryLoading,
                          category: (state is CategorySuccess && index != 0)
                              ? categories[index - 1]
                              : null,
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                    itemCount:
                        state is CategorySuccess ? categories.length + 1 : 10),
              ),
            ],
          ),
        );
      },
    );
  }
}
