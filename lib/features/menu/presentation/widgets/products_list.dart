import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/widgets/errors/error_card.dart';
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
          child: ResponsiveGridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              gridDelegate: ResponsiveGridDelegate(
                  maxCrossAxisExtent: context.ResponsiveValu(150,
                      mobile: 100, tablet: 200, desktop: 300),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: state is ProductSuccess ? state.products.length : 10,
              itemBuilder: (context, index) => Card(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(state is ProductSuccess
                          ? context.trValue(state.products[index].proArName,
                              state.products[index].proEnName)
                          : "Product $index"),
                    ),
                  )),
        );
      },
    );
  }
}
