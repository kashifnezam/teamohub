import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/custom_alert.dart';
import '../app_routes.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
   /* final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Future.microtask(() {
        CustomAlert.errorAlert(
          "Please login first to access this page.",
          title: "Authentication Required",
        );
      });

      return const RouteSettings(name: Routes.login);
    }*/

    return  const RouteSettings(name: Routes.login);
  }
}