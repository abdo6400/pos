import '../../../../../core/utils/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/enums/string_enums.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PopupMenuButton<Locale>(
            icon: SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.language_rounded,
                    color: Theme.of(context).primaryColor,
                    size: context.ResponsiveValu(20,
                        mobile: 12, tablet: 25, desktop: 30),
                  ),
                  SizedBox(width: 5),
                  Text(StringEnums.language.name.tr(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: context.ResponsiveValu(14,
                                mobile: 12, tablet: 16, desktop: 20),
                          )),
                ],
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
                    Text(StringEnums.arabic.name.tr()),
                    Icon(
                        context.locale.languageCode != localArabic.languageCode
                            ? Icons.circle_outlined
                            : Icons.circle,
                        size: 15,
                        color: Theme.of(context).primaryColor),
                  ],
                ),
              ),
              PopupMenuItem<Locale>(
                value: localEnglish,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(StringEnums.english.name.tr()),
                    Icon(
                        context.locale.languageCode != localEnglish.languageCode
                            ? Icons.circle_outlined
                            : Icons.circle,
                        size: 15,
                        color: Theme.of(context).primaryColor),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
