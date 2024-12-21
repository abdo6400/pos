import '../../../../../core/utils/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomBar extends StatelessWidget {
  final String title;
  final String subTitle;
  final String route;
  const CustomBottomBar(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title.tr(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: context.ResponsiveValu(12,
                          mobile: 10, tablet: 20, desktop: 24),
                    ),
              ),
              InkWell(
                onTap: () => context.go(route),
                child: Text(subTitle.tr(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          decoration: TextDecoration.underline,
                          fontSize: context.ResponsiveValu(13,
                              mobile: 10, tablet: 20, desktop: 24),
                        )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
