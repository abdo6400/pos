import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'config/routes/app_router_config.dart';
import 'config/themes/app_theme.dart';
import 'core/bloc/cubit/user_cubit.dart';
import 'core/utils/constants.dart';
import 'core/utils/assets.dart';
import 'features/settings/presentation/bloc/get_sales_by_user/get_sales_by_user_bloc.dart';
import 'features/settings/presentation/bloc/get_sales_by_warehouse/get_sales_by_warehouse_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => locator<SettingsBloc>()..add(GetSettingsEvent())),
        BlocProvider(create: (_) => locator<GetSalesByUserBloc>()..add(GetSalesByUserRequested())),
        BlocProvider(
            create: (_) => locator<GetSalesByWarehouseBloc>()
              ..add(GetSalesByWarehouseRequested())),
        BlocProvider(
          create: (context) => UserCubit()..setUser(),
        ),
      ],
      child: EasyLocalization(
          supportedLocales: [localArabic, localEnglish],
          path: Assets.translations,
          fallbackLocale: localArabic,
          startLocale: localArabic,
          ignorePluralRules: false,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0),
              devicePixelRatio: 1.0,
            ),
            child: Builder(
              builder: (context) {
                return AdaptiveTheme(
                  light: AppTheme.getApplicationLightTheme,
                  dark: AppTheme.getApplicationDarkTheme,
                  initial: themeMode,
                  builder: (theme, darkTheme) => MaterialApp.router(
                      useInheritedMediaQuery: true,
                      debugShowCheckedModeBanner: false,
                      routerDelegate: AppRouterConfig.router.routerDelegate,
                      routeInformationProvider:
                          AppRouterConfig.router.routeInformationProvider,
                      routeInformationParser:
                          AppRouterConfig.router.routeInformationParser,
                      localizationsDelegates: context.localizationDelegates,
                      supportedLocales: context.supportedLocales,
                      locale: context.locale,
                      theme: theme,
                      darkTheme: darkTheme,
                      builder: (context, child) {
                        child = ResponsiveBreakpoints.builder(
                          child: child!,
                          landscapePlatforms: const [
                            ResponsiveTargetPlatform.fuchsia,
                            ResponsiveTargetPlatform.iOS,
                            ResponsiveTargetPlatform.macOS,
                            ResponsiveTargetPlatform.android,
                            ResponsiveTargetPlatform.linux,
                            ResponsiveTargetPlatform.windows,
                            ResponsiveTargetPlatform.web,
                          ],
                          breakpoints: [
                            const Breakpoint(start: 0, end: 480, name: MOBILE),
                            const Breakpoint(
                                start: 481, end: 1279, name: TABLET),
                            const Breakpoint(
                                start: 1280, end: 1920, name: DESKTOP),
                            const Breakpoint(
                                start: 1921, end: double.infinity, name: '4K'),
                          ],
                          breakpointsLandscape: [
                            const Breakpoint(start: 0, end: 900, name: MOBILE),
                            const Breakpoint(
                                start: 901, end: 1920, name: TABLET),
                            const Breakpoint(
                                start: 1921, end: 3840, name: DESKTOP),
                            const Breakpoint(
                                start: 3841, end: double.infinity, name: '4K'),
                          ],
                        );
                        child = DevicePreview.appBuilder(context, child);
                        return child;
                      }),
                );
              },
            ),
          )),
    );
  }
}
