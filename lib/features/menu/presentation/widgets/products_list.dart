import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/widgets/errors/error_card.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../bloc/category_selection/category_selection_cubit.dart';
import '../bloc/product/product_bloc.dart';

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
                  ? state.filteredProducts(category!.catId)
                  : [];
              return ResponsiveGridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  gridDelegate: ResponsiveGridDelegate(
                      maxCrossAxisExtent: context.ResponsiveValu(150,
                          mobile: 100, tablet: 200, desktop: 300),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: state is ProductSuccess ? products.length : 10,
                  itemBuilder: (context, index) => Card(
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: context.generateColorFromValue(
                                products[index].proId.toString()),
                          ),
                          borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(10),
                              bottomStart: Radius.circular(15),
                              topEnd: Radius.circular(15),
                              topStart: Radius.circular(10)),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              image: products[index].icon != null
                                  ? DecorationImage(
                                      image: context.displayBase64Image(
                                          products[index].icon!))
                                  : null),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        state is ProductSuccess
                                            ? context.trValue(
                                                products[index].proArName,
                                                products[index].proEnName)
                                            : "Product $index",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: context.ResponsiveValu(
                                                  12,
                                                  mobile: 10,
                                                  tablet: 16,
                                                  desktop: 25),
                                            ),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state is ProductSuccess
                                        ? products[index].price.toString()
                                        : "0.00",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: context.ResponsiveValu(14,
                                              mobile: 10,
                                              tablet: 20,
                                              desktop: 24),
                                        ),
                                  ),
                                  IconButton.outlined(
                                      onPressed: () {}, icon: Icon(Icons.add))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ));
            },
          ),
        );
      },
    );
  }
}
