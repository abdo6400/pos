import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/constants.dart';
import 'app_routes.dart';

class Guards {
  static Future<String?> authGuard(
      BuildContext context, GoRouterState state) async {
    final isAuthenticated = await storage.isAuthenticatedState();
    if (isAuthenticated) {
      return AppRoutes.main;
    } else {
      return AppRoutes.login;
    }
  }
}
