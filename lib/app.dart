import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'config/routes/app_router_config.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/constants.dart';
import 'core/utils/assets.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
        supportedLocales: [localArabic, localEnglish],
        path: Assets.translations,
        fallbackLocale: localArabic,
        startLocale: localArabic,
        ignorePluralRules: false,
        child: MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(1.2)),
          child: Builder(
            builder: (context) {
              return AdaptiveTheme(
                  light: AppTheme.getApplicationLightTheme,
                  dark: AppTheme.getApplicationDarkTheme,
                  debugShowFloatingThemeButton: true,
                  initial: themeMode,
                  builder: (theme, darkTheme) => DevicePreview(
                        enabled: !kReleaseMode,
                        availableLocales: [localArabic, localEnglish],
                        builder: (context) => MaterialApp.router(
                            useInheritedMediaQuery: !kReleaseMode,
                            debugShowCheckedModeBanner: false,
                            routerDelegate:
                                AppRouterConfig.router.routerDelegate,
                            routeInformationProvider:
                                AppRouterConfig.router.routeInformationProvider,
                            routeInformationParser:
                                AppRouterConfig.router.routeInformationParser,
                            localizationsDelegates:
                                context.localizationDelegates,
                            supportedLocales: context.supportedLocales,
                            locale: context.locale,
                            theme: theme,
                            darkTheme: darkTheme,
                            builder: (context, child) =>
                                ResponsiveBreakpoints.builder(
                                  child: child!,
                                  breakpoints: [
                                    const Breakpoint(
                                        start: 0, end: 600, name: MOBILE),
                                    const Breakpoint(
                                        start: 601, end: 1024, name: TABLET),
                                    const Breakpoint(
                                        start: 1025, end: 1920, name: DESKTOP),
                                    const Breakpoint(
                                        start: 1921,
                                        end: double.infinity,
                                        name: '4K'),
                                  ],
                                  breakpointsLandscape: [
                                    const Breakpoint(
                                        start: 0, end: 899, name: MOBILE),
                                    const Breakpoint(
                                        start: 900, end: 1440, name: TABLET),
                                    const Breakpoint(
                                        start: 1441, end: 2560, name: DESKTOP),
                                    const Breakpoint(
                                        start: 2561,
                                        end: double.infinity,
                                        name: '4K'),
                                  ],
                                )),
                      ));
            },
          ),
        ));
  }
}
