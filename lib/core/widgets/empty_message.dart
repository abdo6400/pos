import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

class EmptyMessage extends StatelessWidget {
  final String message;
  const EmptyMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.sentiment_dissatisfied_outlined,
          size: context.ResponsiveValu(60, mobile: 40, tablet: 60, desktop: 80),
          color: Theme.of(context).primaryColor,
        ),
        Text(
          message,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: context.ResponsiveValu(16,
                    mobile: 12, tablet: 24, desktop: 30),
              ),
        ),
      ],
    );
  }
}
