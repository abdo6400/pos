import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_routes.dart';
import '../bloc/get_sales_by_user/get_sales_by_user_bloc.dart';
import '../bloc/opened_point/opened_points_bloc.dart';

class OpenedPointsScreen extends StatelessWidget {
  const OpenedPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final mustCloseDay = data['mustCloseDay'] as bool;
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
          leading: (!mustCloseDay)
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    context.go(AppRoutes.main);
                  },
                )
              : null,
        ),
        body: BlocBuilder<OpenedPointsBloc, OpenedPointsState>(
          builder: (context, state) {
            return const Placeholder();
          },
        ),
      ),
    );
  }
}
