import 'package:flutter/material.dart';
import '../utils/extensions/extensions.dart';
import '../utils/assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.AppResponsiveValue(80,
          mobile: 70, tablet: 150, desktop: 200, large: 250),
      height: context.AppResponsiveValue(80,
          mobile: 70, tablet: 150, desktop: 200, large: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: SizedBox(
          width: context.AppResponsiveValue(80,
              mobile: 70, tablet: 150, desktop: 200, large: 250),
          height: context.AppResponsiveValue(80,
              mobile: 70, tablet: 150, desktop: 200, large: 250),
          child: Image.asset(
            Assets.logo,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
