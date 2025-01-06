import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../../../core/widgets/lang_theme_options.dart';
import '../../bloc/cubit/category_selection_cubit.dart';
import '../../bloc/cubit/search_cubit.dart';
import '../../bloc/product/product_bloc.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});
  static final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
              flex: 8,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state is ProductLoading,
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
                              fontSize: context.ResponsiveValu(14,
                                  mobile: 10, tablet: 20, desktop: 24))),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context
                              .read<CategorySelectionCubit>()
                              .selectCategory(null);
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
                              fontSize: context.ResponsiveValu(14,
                                  mobile: 10, tablet: 20, desktop: 24))),
                      trailing: [
                        context.watch<SearchCubit>().state != null
                            ? IconButton(
                                onPressed: () {
                                  context
                                      .read<SearchCubit>()
                                      .changeSearch(null);
                                  _controller.clear();
                                },
                                icon: Icon(Icons.clear))
                            : Icon(Icons.search)
                      ],
                    ),
                  );
                },
              )),
          Spacer(flex: 4),
          LangThemeOptions()
        ],
      ),
    );
  }
}
