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
      spacing: 10,
      children: [
        IconButton(
          onPressed: () =>
              AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                  ? AdaptiveTheme.of(context).setLight()
                  : AdaptiveTheme.of(context).setDark(),
          icon: Icon(AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
              ? Icons.dark_mode_outlined
              : Icons.light_mode_outlined),
          iconSize:
              context.ResponsiveValu(30, mobile: 25, tablet: 35, desktop: 40),
        ),
        Container(
          width: 3,
          height: 30,
          color: Theme.of(context).hintColor,
        ),
        LangPopMenu(),
      ],
    );
  }
}
