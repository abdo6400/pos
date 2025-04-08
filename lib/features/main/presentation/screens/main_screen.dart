import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../close_cashbox/presentation/bloc/close_cashbox_bloc.dart';
import '../../../close_cashbox/presentation/bloc/summary/summary_bloc.dart';
import '../../../close_cashbox/presentation/screens/close_cashbox_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../menu/presentation/bloc/cart/cart_bloc.dart';
import '../../../menu/presentation/bloc/category/category_bloc.dart';
import '../../../menu/presentation/bloc/delivery/delivery_bloc.dart';
import '../../../menu/presentation/bloc/discount/discount_bloc.dart';
import '../../../menu/presentation/bloc/flavor/flavor_bloc.dart';
import '../../../menu/presentation/bloc/offer/offer_bloc.dart';
import '../../../menu/presentation/bloc/order/order_bloc.dart';
import '../../../menu/presentation/bloc/product/product_bloc.dart';
import '../../../menu/presentation/bloc/question/question_bloc.dart';
import '../../../payment/presentation/bloc/pay/pay_bloc.dart';
import '../../../payment/presentation/bloc/payment_types/payment_types_bloc.dart';
import '../../../sales/presentation/screens/sales_summary_screen.dart';
import '../../../settings/presentation/bloc/cubit/comparison_cubit.dart';
import '../../../settings/presentation/bloc/get_sales_by_warehouse/get_sales_by_warehouse_bloc.dart';
import '../../../settings/presentation/bloc/open_point/open_point_bloc.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../bloc/cubit/screen_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static final GlobalKey<AnimatedFloatingActionButtonState> menuKey =
      GlobalKey<AnimatedFloatingActionButtonState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ScreenCubit(),
          ),
          BlocProvider(
            create: (context) => ComparisonCubit(),
          ),
          BlocProvider(
            create: (context) =>
                locator<CategoryBloc>()..add(GetCategoriesEvent()),
          ),
          BlocProvider(
            create: (context) =>
                locator<ProductBloc>()..add(GetProductsEvent()),
          ),
          BlocProvider(create: (_) => CartBloc()),
          BlocProvider(
            create: (context) => locator<FlavorBloc>()..add(GetFlavorsEvent()),
          ),
          BlocProvider(
            create: (context) =>
                locator<QuestionBloc>()..add(GetQuestionsEvent()),
          ),
          BlocProvider(
            create: (context) =>
                locator<DiscountBloc>()..add(GetDiscountEvent()),
          ),
          BlocProvider(
            create: (context) => locator<OfferBloc>()..add(GetOfferEvent()),
          ),
          BlocProvider(
              create: (context) => locator<OrderBloc>()..add(GetOrdersEvent())),
          BlocProvider(
              create: (context) =>
                  locator<DeliveryBloc>()..add(GetDeliveriesEvent())),
          BlocProvider(
              create: (context) =>
                  locator<PaymentTypesBloc>()..add(GetPaymentTypesEvent())),
          BlocProvider(create: (_) => locator<PayBloc>()),
          BlocProvider(
              create: (_) => locator<SummaryBloc>()..add(GetSummaryEvent())),
          BlocProvider(create: (_) => locator<CloseCashboxBloc>()),
          BlocProvider(create: (_) => locator<OpenPointBloc>()),
        ],
        child: BlocConsumer<ComparisonCubit, Map<String, dynamic>>(
          listener: (context, comparison) {
            if (context.read<ComparisonCubit>().isLoading) {
              context.showLottieOverlayLoader(
                Assets.loader,
              );
            } else if (context.read<ComparisonCubit>().isError) {
              context.hideOverlayLoader();
              locator<OpenPointBloc>().add(OpenPointRequested());
            } else if (context.read<ComparisonCubit>().isSuccess) {
              context.go(AppRoutes.openedPoints, extra: {
                'mustCloseDay': context.read<ComparisonCubit>().mustCloseDay,
                StringEnums.from_date.name:
                    context.read<ComparisonCubit>().startDate,
              });
            }
          },
          builder: (context, state) {
            return MultiBlocListener(
              listeners: [
                BlocListener<GetSalesByWarehouseBloc, GetSalesByWarehouseState>(
                  listener: (context, state) {
                    if (state is GetSalesByWarehouseFailure) {
                      context.read<ComparisonCubit>().hasError();
                    } else if (state is GetSalesByWarehouseSuccess) {
                      context
                          .read<ComparisonCubit>()
                          .updateFirstValue(state.sales);
                    }
                  },
                ),
                BlocListener<SettingsBloc, SettingsState>(
                  listener: (context, state) {
                    if (state is SettingsError) {
                      context.read<ComparisonCubit>().hasError();
                    } else if (state is SettingsSuccess) {
                      context
                          .read<ComparisonCubit>()
                          .updateSecondValue(state.settings);
                    }
                  },
                ),
              ],
              child: BlocBuilder<ScreenCubit, int>(
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
                      colorStartAnimation:
                          Theme.of(context).colorScheme.primary,
                      colorEndAnimation:
                          Theme.of(context).colorScheme.secondary,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
