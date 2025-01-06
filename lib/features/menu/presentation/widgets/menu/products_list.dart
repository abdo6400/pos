import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../../../core/widgets/empty_message.dart';
import '../../../../../core/widgets/errors/error_card.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/product.dart';
import '../../bloc/cubit/category_selection_cubit.dart';
import '../../bloc/cubit/search_cubit.dart';
import '../../bloc/product/product_bloc.dart';
import 'product_card.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductError) {
          return ErrorCard(
            message: state.message,
            onRetry: () => context.read<ProductBloc>().add(
                  GetProductsEvent(),
                ),
          );
        }

        return Skeletonizer(
          enabled: state is ProductLoading,
          child: BlocBuilder<CategorySelectionCubit, Category?>(
            builder: (context, category) {
              final List<Product> products = state is ProductSuccess
                  ? category != null
                      ? state.filteredProductsByCategory(category.catId)
                      : state.filteredProductsByName(
                          context.watch<SearchCubit>().state)
                  : [];
              if (state is ProductSuccess && products.isEmpty) {
                return EmptyMessage(
                  message: StringEnums.no_products_found.name.tr(),
                );
              }
              return ResponsiveGridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  gridDelegate: ResponsiveGridDelegate(
                      maxCrossAxisExtent: context.ResponsiveValu(200,
                          mobile: 100, tablet: 250, desktop: 350),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: state is ProductSuccess ? products.length : 10,
                  itemBuilder: (context, index) => ProductCard(
                        product:
                            state is ProductSuccess ? products[index] : null,
                      ));
            },
          ),
        );
      },
    );
  }
}
