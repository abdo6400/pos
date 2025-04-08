import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_routes.dart';

class OpenedPointsScreen extends StatelessWidget {
  const OpenedPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mustCloseDay = ModalRoute.of(context)!.settings.arguments as bool;
    return PopScope(
      canPop: !mustCloseDay,
      onPopInvokedWithResult: (value, _) {
        if (!mustCloseDay) {
          context.go(AppRoutes.main);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Opened Points'),
        ),
        body: const Placeholder(),
      ),
    );
  }
}
