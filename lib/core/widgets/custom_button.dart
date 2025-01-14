import '../../../../../core/utils/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonLabel;
  final IconData? iconData;
  final Color? backgroundColor;
  final VoidCallback onSubmit;
  const CustomButton(
      {super.key,
      required this.buttonLabel,
      this.iconData,
      this.backgroundColor,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
          elevation: const WidgetStatePropertyAll(1),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
              vertical: context.AppResponsiveValue(1,
                  mobile: 1, tablet: 10, desktop: 10))),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          )),
          backgroundColor: WidgetStatePropertyAll(
              backgroundColor ?? Theme.of(context).colorScheme.primary),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          textStyle: WidgetStatePropertyAll(
            Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontSize: context.AppResponsiveValue(10,
                      mobile: 10, tablet: 16, desktop: 24),
                ),
          )),
      onPressed: () {
        onSubmit();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 3,
        children: [
          Text(
            buttonLabel.tr(),
          ),
          if (iconData != null)
            Icon(iconData,
                color: Colors.white,
                size: context.AppResponsiveValue(15,
                    mobile: 15, tablet: 25, desktop: 30)),
        ],
      ),
    );
  }
}
