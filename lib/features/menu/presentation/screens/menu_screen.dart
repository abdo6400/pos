import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/features/menu/presentation/bloc/cubit/category_selection_cubit.dart';
import '../bloc/cubit/offer_selection_cubit.dart';
import '../bloc/cubit/search_cubit.dart';
import '../widgets/menu/categories_list.dart';
import '../widgets/menu/custom_app_bar.dart';
import '../widgets/menu/products_list.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategorySelectionCubit()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(create: (_) => OfferSelectionCubit()),
      ],
      child: Column(
        children: [
          Expanded(
              flex: context.AppResponsiveValue(3,
                      mobile: 2, tablet: 2, desktop: 2)
                  .toInt(),
              child: CustomAppBar()),
          Expanded(flex: 2, child: CategoriesList()),
          Expanded(
              flex: context.AppResponsiveValue(14,
                      mobile: 14, tablet: 19, desktop: 20)
                  .toInt(),
              child: ProductsList()),
        ],
      ),
    );
  }
}
