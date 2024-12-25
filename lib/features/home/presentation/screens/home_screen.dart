import 'package:flutter/material.dart';

import '../../../cart/presentation/screens/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(),
                ),
                Expanded(
                  child: Card(
                    elevation: 0.2,
                    shape: BorderDirectional(
                      top: BorderSide(color: Colors.black),
                    ),
                    child: Container(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 2, child: CartScreen()),
        ],
      ),
    );
  }
}
