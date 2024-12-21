import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/components/splash_component/custom_splash_screen.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enums/string_enums.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomSplashScreen.lottie(
        gifPath: Assets.splash,
        gifWidth:
            context.ResponsiveValu(150, mobile: 120, tablet: 200, desktop: 300),
        gifHeight:
            context.ResponsiveValu(150, mobile: 120, tablet: 200, desktop: 300),
        title: StringEnums.appName.name.tr(),
        message: StringEnums.appMessage.name.tr(),
        titleFontSize:
            context.ResponsiveValu(40, mobile: 30, tablet: 40, desktop: 50),
        messageFontSize:
            context.ResponsiveValu(20, mobile: 15, tablet: 20, desktop: 25),
        duration: Duration(seconds: 7),
        onEnd: () async => await storage.isOnBoardingState()
            ? await storage.isAuthenticatedState()
                ? context.pushReplacement(AppRoutes.main)
                : context.pushReplacement(AppRoutes.login)
            : context.pushReplacement(AppRoutes.onboarding),
      ),
    );
  }
}
