import 'package:flutter/material.dart';
import '../../../../home/presentation/widgets/options.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom:
                BorderSide(color: Theme.of(context).hintColor.withAlpha(20)),
          ),
        ),
        child: Options());
  }
}
