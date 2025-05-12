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
import '../../../domain/entities/offer.dart';
import '../../../domain/entities/product.dart';
import '../../bloc/cubit/category_selection_cubit.dart';
import '../../bloc/cubit/offer_selection_cubit.dart';
import '../../bloc/cubit/search_cubit.dart';
import '../../bloc/offer/offer_bloc.dart';
import '../../bloc/product/product_bloc.dart';
import 'product_card.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferBloc, OfferState>(
      builder: (context, offerState) {
        final List<Offer> offers =
            offerState is OfferSuccess ? offerState.offers : [];
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
                  List<Product> products = state is ProductSuccess
                      ? !context.watch<OfferSelectionCubit>().state
                          ? (category != null
                              ? state.filteredProductsByCategory(category.catId)
                              : state.filteredProductsByName(
                                  context.watch<SearchCubit>().state))
                          : state.products
                              .where((x) =>
                                  offers.any((y) => y.productId == x.proId))
                              .toList()
                      : [];
                  products = products.where((x) => !x.rawMaterial).toList();
                  if (state is ProductSuccess && products.isEmpty) {
                    return EmptyMessage(
                      message: StringEnums.no_products_found.name.tr(),
                    );
                  }
                  return ResponsiveGridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      gridDelegate: ResponsiveGridDelegate(
                          maxCrossAxisExtent: context.AppResponsiveValue(150,
                              mobile: 100, tablet: 200, desktop: 250),
                          childAspectRatio: 4 / 5,
                          crossAxisSpacing: context.AppResponsiveValue(2,
                              mobile: 2, tablet: 10, desktop: 15),
                          mainAxisSpacing: context.AppResponsiveValue(2,
                              mobile: 2, tablet: 10, desktop: 15)),
                      itemCount: state is ProductSuccess ? products.length : 10,
                      itemBuilder: (context, index) => ProductCard(
                            product: state is ProductSuccess
                                ? products[index]
                                : null,
                          ));
                },
              ),
            );
          },
        );
      },
    );
  }
}
