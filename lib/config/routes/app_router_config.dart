import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/enums/string_enums.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/close_cashbox/presentation/bloc/close_cashbox_bloc.dart';
import '../../features/close_cashbox/presentation/bloc/summary/summary_bloc.dart';
import '../../features/close_cashbox/presentation/screens/close_cashbox_screen.dart';
import '../../features/intro/presentation/screens/splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/main/presentation/bloc/cubit/screen_cubit.dart';
import '../../features/main/presentation/screens/main_screen.dart';
import '../../features/menu/presentation/bloc/cart/cart_bloc.dart';
import '../../features/menu/presentation/bloc/category/category_bloc.dart';
import '../../features/menu/presentation/bloc/delivery/delivery_bloc.dart';
import '../../features/menu/presentation/bloc/discount/discount_bloc.dart';
import '../../features/menu/presentation/bloc/flavor/flavor_bloc.dart';
import '../../features/menu/presentation/bloc/offer/offer_bloc.dart';
import '../../features/menu/presentation/bloc/order/order_bloc.dart';
import '../../features/menu/presentation/bloc/product/product_bloc.dart';
import '../../features/menu/presentation/bloc/question/question_bloc.dart';
import '../../features/payment/presentation/bloc/pay/pay_bloc.dart';
import '../../features/payment/presentation/bloc/payment_types/payment_types_bloc.dart';
import '../../features/payment/presentation/screens/payment_screen.dart';
import '../../features/settings/presentation/bloc/cubit/comparison_cubit.dart';
import '../../features/settings/presentation/bloc/end_day/end_day_bloc.dart';
import '../../features/settings/presentation/bloc/get_sales_by_user/get_sales_by_user_bloc.dart';
import '../../features/settings/presentation/bloc/get_sales_by_warehouse/get_sales_by_warehouse_bloc.dart';
import '../../features/settings/presentation/bloc/open_point/open_point_bloc.dart';
import '../../features/settings/presentation/bloc/opened_point/opened_points_bloc.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';
import '../../features/settings/presentation/screens/open_point_screen.dart';
import '../../features/settings/presentation/screens/opened_points_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import 'app_routes.dart';

class AppRouterConfig {
  static GoRouter get router => _router;
  static Page<void> _buildPageWithTransition(
    BuildContext context,
    GoRouterState state, {
    required Widget child,
    PageTransitionType transitionType = PageTransitionType.fade,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      arguments: state.extra,
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return PageTransition(
          type: transitionType,
          child: child,
          duration: Duration(milliseconds: 300),
        ).buildTransitions(context, animation, secondaryAnimation, child);
      },
    );
  }

  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.initial,
        pageBuilder: (context, state) {
          return _buildPageWithTransition(
            context,
            state,
            child: SplashScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) {
          return _buildPageWithTransition(
            context,
            state,
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.main,
        pageBuilder: (context, state) {
          return _buildPageWithTransition(
            context,
            state,
            child: MultiBlocProvider(providers: [
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
                create: (context) =>
                    locator<FlavorBloc>()..add(GetFlavorsEvent()),
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
                  create: (context) =>
                      locator<OrderBloc>()..add(GetOrdersEvent())),
              BlocProvider(
                  create: (context) =>
                      locator<DeliveryBloc>()..add(GetDeliveriesEvent())),
              BlocProvider(
                  create: (context) =>
                      locator<PaymentTypesBloc>()..add(GetPaymentTypesEvent())),
              BlocProvider(create: (_) => locator<PayBloc>()),
              BlocProvider(
                  create: (_) =>
                      locator<SummaryBloc>()..add(GetSummaryEvent())),
              BlocProvider(create: (_) => locator<CloseCashboxBloc>()),
              BlocProvider(
                  create: (_) =>
                      locator<SettingsBloc>()..add(GetSettingsEvent())),
              BlocProvider(
                  create: (_) => locator<GetSalesByUserBloc>()
                    ..add(GetSalesByUserRequested())),
              BlocProvider(
                  create: (_) => locator<GetSalesByWarehouseBloc>()
                    ..add(GetSalesByWarehouseRequested())),
            ], child: MainScreen()),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.payment,
        pageBuilder: (context, state) {
          return _buildPageWithTransition(
            context,
            state,
            child: PaymentScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        pageBuilder: (context, state) {
          return _buildPageWithTransition(
            context,
            state,
            child: BlocProvider(
              create: (context) => locator<SettingsBloc>()..add(GetSettingsEvent()),
              child: SettingsScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.closeCashbox,
        pageBuilder: (context, state) {
          return _buildPageWithTransition(
            context,
            state,
            child: MultiBlocProvider(providers: [
              BlocProvider(create: (_) => locator<CloseCashboxBloc>()),
              BlocProvider(
                  create: (_) => locator<SummaryBloc>()
                    ..add(GetSummaryEvent(
                        userNo: (state.extra
                            as Map)[StringEnums.open_point.name]))),
            ], child: CloseCashboxScreen()),
          );
        },
      ),
      GoRoute(
          path: AppRoutes.openPoint,
          pageBuilder: (context, state) {
            return _buildPageWithTransition(context, state,
                child: BlocProvider(
                  create: (context) => locator<OpenPointBloc>(),
                  child: OpenPointScreen(),
                ));
          }),
      GoRoute(
        path: AppRoutes.openedPoints,
        pageBuilder: (context, state) {
          return _buildPageWithTransition(
            context,
            state,
            child: MultiBlocProvider(providers: [
              BlocProvider(create: (_) => locator<OpenPointBloc>()),
              BlocProvider(create: (_) => locator<EndDayBloc>()),
              BlocProvider(
                  create: (_) => locator<OpenedPointsBloc>()
                    ..add(OpenedPointsRequested((state.extra
                        as Map<String, dynamic>)[StringEnums.from_date.name]))),
            ], child: OpenedPointsScreen()),
          );
        },
      ),
    ],
  );
}
