import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../utils/constants.dart';
import '../utils/enums/string_enums.dart';

class LangPopMenu extends StatelessWidget {
  const LangPopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: SizedBox(
        child: Icon(
          Icons.language_rounded,
          color: Theme.of(context).primaryColor,
          size: context.AppResponsiveValue(25,
              mobile: 20, tablet: 35, desktop: 50),
        ),
      ),
      offset: Offset(10, 50),
      initialValue: context.locale,
      onSelected: (Locale result) {
        if (context.locale.languageCode != result.languageCode) {
          context.setLocale(result);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
        PopupMenuItem<Locale>(
          value: localArabic,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(StringEnums.arabic.name.tr(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: context.AppResponsiveValue(12,
                            mobile: 10, tablet: 16, desktop: 25),
                      )),
              Icon(
                  context.locale.languageCode != localArabic.languageCode
                      ? Icons.circle_outlined
                      : Icons.circle,
                  size: context.AppResponsiveValue(15,
                      mobile: 15, tablet: 20, desktop: 25),
                  color: Theme.of(context).primaryColor),
            ],
          ),
        ),
        PopupMenuItem<Locale>(
          value: localEnglish,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(StringEnums.english.name.tr(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: context.AppResponsiveValue(12,
                            mobile: 10, tablet: 16, desktop: 25),
                      )),
              Icon(
                  context.locale.languageCode != localEnglish.languageCode
                      ? Icons.circle_outlined
                      : Icons.circle,
                  size: context.AppResponsiveValue(15,
                      mobile: 15, tablet: 20, desktop: 25),
                  color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ],
    );
  }
}
