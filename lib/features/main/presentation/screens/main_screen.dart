import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enums/string_enums.dart';
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
    return SafeArea(
      child: BlocConsumer<CheckerPointBloc, CheckerPointState>(
        listener: (context, state) {
          // Handle loading state
          if (state is CheckerPointLoading) {
            context.showLottieOverlayLoader(Assets.loader);
          }
          // Handle error state
          else if (state is CheckerPointError) {
            context.go(AppRoutes.openPoint);
          }
          // Handle success state with navigation logic
          else if (state is CheckerPointReady) {
            if (state.mustCloseDay) {
              context.go(AppRoutes.openedPoints, extra: {
                StringEnums.mustCloseDay.name: state.mustCloseDay,
                StringEnums.to_date.name: state.closeTime,
                StringEnums.from_date.name: state.startDate,
              });
            } else if (!state.hasPoint) {
              context.go(AppRoutes.openPoint);
            } else {
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
                          context.read<ScreenCubit>().changeScreen(2);
                        }),
                    // FloatingActionButton(
                    //     child: const Icon(Icons.timeline_rounded),
                    //     onPressed: () {
                    //       context.read<ScreenCubit>().changeScreen(3);
                    //     }),
                  ],
                  animatedIconData: AnimatedIcons.menu_close,
                  colorStartAnimation: Theme.of(context).colorScheme.primary,
                  colorEndAnimation: Theme.of(context).colorScheme.secondary,
                ),
                body: IndexedStack(
                  index: index,
                  children: const [
                    HomeScreen(),
                    SalesSummaryScreen(),
                    CloseCashboxScreen(),
                    // SalesReportScreen()
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
