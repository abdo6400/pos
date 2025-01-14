import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

class EmptyMessage extends StatelessWidget {
  final String message;
  final String? image;
  const EmptyMessage({super.key, required this.message, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        image != null
            ? Image.asset(image!,
                height: context.AppResponsiveValue(25,
                    mobile: 25, tablet: 45, desktop: 70))
            : Icon(
                Icons.sentiment_dissatisfied_outlined,
                size: context.AppResponsiveValue(25,
                    mobile: 25, tablet: 45, desktop: 70),
                color: Theme.of(context).primaryColor,
              ),
        Text(
          message,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: context.AppResponsiveValue(12,
                    mobile: 12, tablet: 21, desktop: 26),
              ),
        ),
      ],
    );
  }
}
