import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/bloc/cubit/printing_cubit.dart';
import '../../../../core/bloc/cubit/settings_cubit.dart';
import '../../../../core/entities/settings.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enums/printing_status_enums.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../close_cashbox/presentation/bloc/summary/summary_bloc.dart';
import '../../../close_cashbox/presentation/screens/close_cashbox_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../sales/presentation/screens/sales_summary_screen.dart';
import '../../../settings/presentation/bloc/checker_point/checker_point_bloc.dart';
import '../bloc/cubit/screen_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static final GlobalKey<AnimatedFloatingActionButtonState> menuKey =
      GlobalKey<AnimatedFloatingActionButtonState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrintingCubit, PrintingStatusEnums>(
      listener: (context, state) {
        if (state == PrintingStatusEnums.connecting ||
            state == PrintingStatusEnums.printing) {
          context.showLottieOverlayLoader(Assets.loader);
        } else if (state == PrintingStatusEnums.printed) {
          context.hideOverlayLoader();
          context.showMessageToast(msg: StringEnums.printed.name.tr());
        } else if (state == PrintingStatusEnums.connected) {
          context.hideOverlayLoader();
          context.showMessageToast(
              msg: StringEnums.printer_connected.name.tr());
        } else if (state == PrintingStatusEnums.error) {
          context.hideOverlayLoader();
          context.showMessageToast(msg: StringEnums.error.name.tr());
        }
      },
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return BlocBuilder<SettingsCubit, Settings>(
          buildWhen: (previous, current) => false,
          builder: (context, settings) {
            return SafeArea(
              child: BlocConsumer<CheckerPointBloc, CheckerPointState>(
                listener: (context, state) {
                  if (state is CheckerPointLoading) {
                    context.showLottieOverlayLoader(Assets.loader);
                  } else if (state is CheckerPointError) {
                    context.go(AppRoutes.openPoint);
                  } else if (state is CheckerPointReady) {
                    if (!state.hasPoint && (!state.mustCloseDay)) {
                      context.go(AppRoutes.openPoint);
                    }
                    else  if (state.mustCloseDay) {
                      context.go(AppRoutes.openedPoints, extra: {
                        StringEnums.mustCloseDay.name: state.mustCloseDay,
                        StringEnums.to_date.name: state.closeTime,
                        StringEnums.from_date.name: state.startDate,
                        StringEnums.settings.name: settings
                      });
                    }   else {
                      context.hideOverlayLoader();
                    }
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<ScreenCubit, int>(
                    builder: (context, index) {
                      return Scaffold(
                        resizeToAvoidBottomInset: false,
                        floatingActionButton: AnimatedFloatingActionButton(
                          key: menuKey,
                          fabButtons: <Widget>[
                            FloatingActionButton(
                                child: const Icon(Icons.home),
                                onPressed: () {
                                  context.read<ScreenCubit>().changeScreen(0);
                                }),
                            FloatingActionButton(
                                child: const Icon(Icons.receipt_long),
                                onPressed: () {
                                  context.read<ScreenCubit>().changeScreen(1);
                                }),
                            FloatingActionButton(
                                child: const Icon(Icons.money),
                                onPressed: () {
                                  context
                                      .read<SummaryBloc>()
                                      .add(GetSummaryEvent());
                                  context.read<ScreenCubit>().changeScreen(2);
                                }),
                            // FloatingActionButton(
                            //     child: const Icon(Icons.timeline_rounded),
                            //     onPressed: () {
                            //       context.read<ScreenCubit>().changeScreen(3);
                            //     }),
                          ],
                          animatedIconData: AnimatedIcons.menu_close,
                          colorStartAnimation:
                              Theme.of(context).colorScheme.primary,
                          colorEndAnimation:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        body: IndexedStack(
                          index: index,
                          children: [
                            HomeScreen(settings: settings),
                            SalesSummaryScreen(settings: settings),
                            CloseCashboxScreen(settings: settings),
                            // SalesReportScreen()
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
