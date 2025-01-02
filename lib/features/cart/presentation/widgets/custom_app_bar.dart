import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/bloc/cubit/user_cubit.dart';
import '../../../../core/entities/auth_tokens.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/app_logo.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(color: Theme.of(context).hintColor.withAlpha(20)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppLogo(),
          Container(
            width: 2,
            height: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            color: Theme.of(context).colorScheme.primary,
          ),
          Expanded(
            child: BlocBuilder<UserCubit, AuthTokens?>(
              builder: (context, state) {
                return Skeletonizer(
                  enabled: state == null,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 5,
                      children: [
                        Info(StringEnums.user_name.name.tr(),
                            state?.username ?? ""),
                        Info(StringEnums.branch.name.tr(),
                            state?.defaultBranch ?? ""),
                        Info(StringEnums.currency.name.tr(),
                            state?.defaultCurrency ?? ""),
                      ]
                          .map(
                            (e) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: context.ResponsiveValu(12,
                                              mobile: 10,
                                              tablet: 18,
                                              desktop: 25),
                                        ),
                                  ),
                                  Text(
                                    e.value,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: context.ResponsiveValu(12,
                                              mobile: 10,
                                              tablet: 18,
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
