import '../../../../../core/utils/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomSignButton extends StatelessWidget {
  final String buttonLabel;
  final IconData? iconData;
  final Color? backgroundColor;
  final VoidCallback onSubmit;
  const CustomSignButton(
      {super.key,
      required this.buttonLabel,
      this.iconData,
      this.backgroundColor,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
          backgroundColor: WidgetStatePropertyAll(
              backgroundColor ?? Theme.of(context).colorScheme.primary),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          textStyle: WidgetStatePropertyAll(
            Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontSize: context.ResponsiveValu(14,
                      mobile: 10, tablet: 20, desktop: 24),
                ),
          )),
      onPressed: () {
        onSubmit();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            buttonLabel.tr(),
          ),
          if (iconData != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Icon(iconData),
            ),
        ],
      ),
    );
  }
}
