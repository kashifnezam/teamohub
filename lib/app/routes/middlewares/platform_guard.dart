import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/custom_alert.dart';
import '../app_routes.dart';


class PlatformGuard extends GetMiddleware {
  final bool allowWeb;

  PlatformGuard({this.allowWeb = true});

  @override
  RouteSettings? redirect(String? route) {
    if (!allowWeb && kIsWeb) {
      Future.microtask(() {
        CustomAlert.errorAlert(
          "This feature is only available on mobile.",
          title: "Unsupported Platform",
        );
      });

      return const RouteSettings(name: Routes.login);
    }

    return null;
  }
}