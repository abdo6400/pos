import 'package:animated_float_action_button/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/cubit/user_cubit.dart';
import '../../../../core/utils/constants.dart';
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
              create: (_) => locator<SettingsBloc>()..add(GetSettingsEvent())),
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
            create: (context) => UserCubit()..setUser(),
          ),
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
          BlocProvider(create: (_) => locator<PayBloc>())
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
                  FloatingActionButton(
                      child: const Icon(Icons.timeline_rounded),
                      onPressed: () {
                        context.read<ScreenCubit>().changeScreen(3);
                      }),
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
                  Center(child: Text('close cash')),
                  Center(child: Text('nodhia')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
