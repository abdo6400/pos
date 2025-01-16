import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/enums/string_enums.dart';
import '../../bloc/cubit/category_selection_cubit.dart';
import '../../bloc/cubit/offer_selection_cubit.dart';
import '../../bloc/cubit/search_cubit.dart';
import '../../bloc/product/product_bloc.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});
  static final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is ProductLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.AppResponsiveValue(5,
                    mobile: 5, tablet: 2, desktop: 2)),
            child: SearchBar(
              controller: _controller,
              elevation: WidgetStatePropertyAll(0.2),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
              textStyle: WidgetStatePropertyAll(Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(
                      fontSize: context.AppResponsiveValue(12,
                          mobile: 10, tablet: 20, desktop: 25))),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context.read<OfferSelectionCubit>().ShowHideOffer(false);
                  context.read<CategorySelectionCubit>().selectCategory(null);
                  context.read<SearchCubit>().changeSearch(value);
                } else {
                  context.read<SearchCubit>().changeSearch(null);
                }
              },
              hintText: StringEnums.search_about_item.name.tr(),
              hintStyle: WidgetStatePropertyAll(Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: context.AppResponsiveValue(12,
                          mobile: 10, tablet: 20, desktop: 25))),
              trailing: [
                context.watch<SearchCubit>().state != null
                    ? IconButton(
                        onPressed: () {
                          context.read<SearchCubit>().changeSearch(null);
                          _controller.clear();
                        },
                        icon: Icon(Icons.clear))
                    : Icon(Icons.search)
              ],
            ),
          ),
        );
      },
    );
  }
}
