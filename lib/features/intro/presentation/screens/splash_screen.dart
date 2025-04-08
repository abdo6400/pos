import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/widgets/splash_component/custom_splash_screen.dart';
import '../../../../core/utils/assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomSplashScreen.fadeIn(
          gifPath: Assets.logo,
          gifWidth: context.AppResponsiveValue(120,
              mobile: 100, tablet: 200, desktop: 250, large: 300),
          gifHeight: context.AppResponsiveValue(120,
              mobile: 100, tablet: 200, desktop: 250, large: 300),
          duration: Duration(seconds: 4),
          onEnd: () async {
            storage.clearAuthTokenState();
            context.go(AppRoutes.login);
          }

          // await storage.isAuthenticatedState())
          //   ? context.pushReplacement(AppRoutes.main)
          //   :

          ),
    );
  }
}
