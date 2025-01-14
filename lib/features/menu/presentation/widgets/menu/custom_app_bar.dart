import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/bloc/cubit/user_cubit.dart';
import '../../../../../core/entities/auth_tokens.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../../../core/widgets/lang_theme_options.dart';
import '../../bloc/cubit/category_selection_cubit.dart';
import '../../bloc/cubit/offer_selection_cubit.dart';
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
            flex: 3,
            child: BlocBuilder<UserCubit, AuthTokens?>(
              builder: (context, state) {
                return Skeletonizer(
                  enabled: state == null,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Info(StringEnums.user_name.name.tr(),
                            state?.username ?? ""),
                        // Info(StringEnums.branch.name.tr(),
                        //     state?.defaultBranch ?? ""),
                        Info(StringEnums.currency.name.tr(),
                            state?.defaultCurrency ?? ""),
                      ]
                          .map(
                            (e) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    e.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: context.AppResponsiveValue(
                                              12,
                                              mobile: 10,
                                              tablet: 17,
                                              desktop: 25),
                                        ),
                                  ),
                                  Text(
                                    e.value,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: context.AppResponsiveValue(
                                              12,
                                              mobile: 10,
                                              tablet: 17,
                                              desktop: 25),
                                        ),
                                  ),
                                ]),
                          )
                          .toList()),
                );
              },
            ),
          ),
          Expanded(
              flex: 8,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state is ProductLoading,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: context.AppResponsiveValue(5,
                              mobile: 5, tablet: 0, desktop: 0)),
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
                                    mobile: 10, tablet: 20, desktop: 28))),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            context
                                .read<OfferSelectionCubit>()
                                .ShowHideOffer(false);
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
                                fontSize: context.AppResponsiveValue(12,
                                    mobile: 10, tablet: 20, desktop: 30))),
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
                    ),
                  );
                },
              )),
          LangThemeOptions()
        ],
      ),
    );
  }
}

class Info {
  final String title;
  final String value;
  Info(this.title, this.value);
}
