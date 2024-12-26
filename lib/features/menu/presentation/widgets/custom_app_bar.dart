import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/lang_theme_options.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
              flex: 8,
              child: SearchBar(
                elevation: WidgetStatePropertyAll(0.2),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
                hintText: StringEnums.search_about_item.name.tr(),
                hintStyle: WidgetStatePropertyAll(Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: context.ResponsiveValu(14,
                            mobile: 10, tablet: 20, desktop: 24))),
                trailing: [Icon(Icons.search)],
              )),
          Spacer(flex: 4),
          LangThemeOptions()
        ],
      ),
    );
  }
}
