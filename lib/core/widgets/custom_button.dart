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
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          )),
          backgroundColor: WidgetStatePropertyAll(
              backgroundColor ?? Theme.of(context).colorScheme.primary),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          textStyle: WidgetStatePropertyAll(
            Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontSize: context.AppResponsiveValue(12,
                      mobile: 10, tablet: 20, desktop: 24),
                ),
          )),
      onPressed: () {
        onSubmit();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
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
