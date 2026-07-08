import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RoleGuard extends GetMiddleware {
  final String requiredRole;

  RoleGuard(this.requiredRole);

  @override
  RouteSettings? redirect(String? route) {
   /* final role = userInfo?["role"];

    if (role != requiredRole) {
      Future.microtask(() {
        CustomAlert.errorAlert(
          "You don't have permission to access this page.",
          title: "Access Denied",
        );
      });

      return const RouteSettings(name: Routes.login);
    }
*/
    return null;
  }
}