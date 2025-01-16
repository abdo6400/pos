import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/bloc/cubit/user_cubit.dart';
import '../../../../../core/entities/auth_tokens.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/enums/string_enums.dart';

class InfoPopup extends StatelessWidget {
  final dynamic cubit;
  const InfoPopup({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: context.AppResponsiveValue(12,
              mobile: 10, tablet: 16, desktop: 20),
        );
    return PopupMenuButton<String>(
      icon: Icon(Icons.person_2_outlined),
      offset: Offset.fromDirection(3.14 / 2, 50),
      iconSize:
          context.AppResponsiveValue(25, mobile: 25, tablet: 35, desktop: 40),
      onSelected: (value) {
        if (value == 'logout') {
        } else if (value == 'settings') {}
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'user_info',
            enabled: false,
            child: BlocProvider.value(
              value: cubit as UserCubit,
              child: BlocBuilder<UserCubit, AuthTokens?>(
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state == null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: 5,
                            children: [
                              state?.defaultBranch,
                              state?.defaultCurrency,
                            ]
                                .map(
                                  (e) => Text(
                                    e ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: style,
                                  ),
                                )
                                .toList()),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 5,
                          children: [
                            Image.asset(
                              Assets.logo,
                              height: context.AppResponsiveValue(30,
                                  mobile: 30, tablet: 40, desktop: 50),
                            ),
                            Text(state?.username ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: style),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem(
            value: 'settings',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.settings, color: Colors.blue),
                Text(
                  StringEnums.settings.name.tr(),
                  style: style,
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'logout',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.logout, color: Colors.red),
                Text(
                  StringEnums.logout.name.tr(),
                  style: style,
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
