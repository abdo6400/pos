import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'lang_pop_menu.dart';

class LangThemeOptions extends StatelessWidget {
  const LangThemeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LangPopMenu(),
        IconButton(
          onPressed: () =>
              AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                  ? AdaptiveTheme.of(context).setLight()
                  : AdaptiveTheme.of(context).setDark(),
          icon: Icon(AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
              ? Icons.dark_mode_outlined
              : Icons.light_mode_outlined),
          iconSize: context.AppResponsiveValue(25,
              mobile: 25, tablet: 35, desktop: 40),
        ),
      ],
    );
  }
}
