import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/features/menu/presentation/bloc/cubit/category_selection_cubit.dart';
import '../bloc/cubit/barcode_reader_cubit.dart';
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
        BlocProvider(create: (_) => BarcodeReaderCubit()),
      ],
      child: Column(
        spacing: 5,
        children: [
          Expanded(child: CustomAppBar()),
          Expanded(
              flex: 10,
              child: Column(
                children: [
                  Expanded(child: CategoriesList()),
                  Expanded(
                      flex: context.isMobile ? 8 : 12, child: ProductsList()),
                ],
              )),
        ],
      ),
    );
  }
}
