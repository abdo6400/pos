import 'package:flutter/material.dart';
import '../../../menu/presentation/screens/cart_screen.dart';
import '../../../menu/presentation/screens/menu_screen.dart';
import '../widgets/options.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: CartScreen()),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: MenuScreen(),
              ),
              Expanded(child: Options()),
            ],
          ),
        ),
      ],
    );
  }
}
