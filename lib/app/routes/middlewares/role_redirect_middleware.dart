import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/constants/app_constants.dart';
import '../../../modules/auth/services/auth_service.dart';
import '../../utils/custom_alert.dart';
import '../../utils/offline_data.dart';
import '../app_routes.dart';

class RoleRedirectMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final role = userInfo?["role"];

    /// No role → family home
    if (role == null) {
      return const RouteSettings(name: Routes.dashboard);
    }

    /// Executive
    if (role == "user") {

      /// Executive on web → logout
      if (kIsWeb) {
        Future.microtask(() async {
          await AuthService.logout();

          CustomAlert.errorAlert(
            "Please login from the mobile app.",
            title: "Access Restricted",
          );
        });

        return const RouteSettings(name: Routes.login);
      }

      return const RouteSettings(name: Routes.dashboard);
    }

    /// fallback
    return const RouteSettings(name: Routes.dashboard);
  }
}