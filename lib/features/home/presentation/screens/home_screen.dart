import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enums/state_enums.dart';
import '../../../menu/presentation/bloc/cart/cart_bloc.dart';
import '../../../menu/presentation/screens/cart_screen.dart';
import '../../../menu/presentation/screens/menu_screen.dart';
import '../../../payment/presentation/bloc/pay/pay_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PayBloc, PayState>(
        listener: (context, state) {
          if (state is PaySuccess) {
            context.read<CartBloc>().add(ClearCartEvent());
            context.hideOverlayLoader();
          } else if (state is PayError) {
            context.hideOverlayLoader();
            context.handleState(StateEnum.error, state.message);
          } else if (state is PayLoading) {
            context.showLottieOverlayLoader(Assets.loader);
          }
        },
        child: Row(
          children: [
            Expanded(flex: 2, child: CartScreen()),
            Expanded(
              flex: 5,
              child: MenuScreen(),
            ),
          ],
        ));
  }
}
