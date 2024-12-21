import '../../../../../core/utils/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';

class SignWithSocial extends StatelessWidget {
  final String buttonLabel;
  final void Function()? onPressed;
  const SignWithSocial(
      {super.key, required this.buttonLabel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.5,
        foregroundColor: Theme.of(context).textTheme.bodyLarge!.color,
        backgroundColor: Theme.of(context).canvasColor,
        textStyle: Theme.of(context).textTheme.bodyLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 30,
          vertical: 15,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            buttonLabel.tr(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: context.ResponsiveValu(14,
                      mobile: 10, tablet: 20, desktop: 24),
                ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: Image.asset(
              Assets.gmail,
              height: 25,
              width: 25,
            ),
          ),
        ],
      ),
    );
  }
}
